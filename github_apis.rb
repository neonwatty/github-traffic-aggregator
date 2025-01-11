require 'net/http'
require 'json'
require 'dotenv/load'

class GithubRepoApis
  # Fetch data for a given username and repository
  # Endpoints for traffic data
  ENDPOINTS = [
    'traffic/views',
    'traffic/clones',
    'traffic/popular/referrers',
    'traffic/popular/paths'
  ]

  def initialize(username: "neonwatty", repo: "meme-search")
    @username = username
    @repository = repo

    # Load the personal access token from .env
    @access_token = ENV['GITHUB_TOKEN']
    raise "GitHub token not found. Please set GITHUB_TOKEN in the .env file." unless @access_token

    # Form headers with authentication
    @headers = {
      "Authorization" => "token #{@access_token}",
      "Accept" => "application/vnd.github+json"
    }

    @endpoint_data = {}
  end

  def get_data(endpoint)
    # GitHub API URL for endpoint
    url = URI("https://api.github.com/repos/#{@username}/#{@repository}/#{endpoint}")
    request = Net::HTTP::Get.new(url, @headers)

    # Make the GET request
    response = Net::HTTP.start(url.hostname, url.port, use_ssl: true) do |http|
      http.request(request)
    end

    # Check the response
    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      puts "Failed to fetch data for endpoint #{endpoint} - received: #{response.code}"
      puts response.body
      nil
    end
  end

  def get_all
    # Get all endpoint data
    ENDPOINTS.each do |endpoint|
      endpoint_name = endpoint.split('/').last
      @endpoint_data[endpoint_name] = get_data(endpoint)
    end
    @endpoint_data
  end
end

def get_user_repositories(username: "neonwatty")
  # Load the personal access token from .env
  access_token = ENV['GITHUB_TOKEN']
  raise "GitHub token not found. Please set GITHUB_TOKEN in the .env file." unless access_token

  # Form headers with authentication
  headers = {
    "Authorization" => "token #{access_token}",
    "Accept" => "application/vnd.github+json"
  }

  url = URI("https://api.github.com/users/#{username}/repos")
  repos = []
  page = 1

  loop do
    begin
      # Fetch one page of repositories
      uri = URI(url)
      uri.query = URI.encode_www_form({ page: page, per_page: 100 })
      request = Net::HTTP::Get.new(uri, headers)

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      if response.is_a?(Net::HTTPSuccess)
        data = JSON.parse(response.body)
        break if data.empty?

        # Append repository names to the list
        repos.concat(data.map { |repo| repo['name'] })
        page += 1
      else
        puts "Failed to fetch repositories - received: #{response.code}"
        puts response.body
        break
      end
    rescue StandardError => e
      puts "An error occurred: #{e}"
      break
    end
  end

  repos
end

# Example Usage
if __FILE__ == $PROGRAM_NAME
  username = "neonwatty" 
  repo = "meme-search"
  api = GithubRepoApis.new(username: username, repo: repo)
  traffic_data = api.get_all
  puts "Traffic data for #{username}#{repo}:"
  puts traffic_data

  repositories = get_user_repositories(username: username)
  puts "Repositories for user #{username}:"
  repositories.each { |repo| puts repo }
end
