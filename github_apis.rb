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
      {}
    end
  end

  def get_repo_metadata
    # GitHub API URL for endpoint
    url = URI("https://api.github.com/repos/#{@username}/#{@repository}")
    request = Net::HTTP::Get.new(url, @headers)

    # Make the GET request
    response = Net::HTTP.start(url.hostname, url.port, use_ssl: true) do |http|
      http.request(request)
    end

    # Check the response
    if response.is_a?(Net::HTTPSuccess)
      @data = JSON.parse(response.body)

      # delete 'owner' sub-hash
      @data.delete('owner')

      # remove 'permissions'
      @data.delete("permissions")

      # remove "license"
      @data.delete("license")

      # remove "security_and_analysis"
      @data.delete("security_and_analysis")

      # change "created_at" to "created_at_github"
      @data["created_at_github"] = @data["created_at"]
      @data.delete("created_at")

      # change "updated_at" to "updated_at_github"
      @data["updated_at_github"] = @data["updated_at"]
      @data.delete("updated_at")

      # change "pushed at" to "pushed_at_github"
      @data["pushed_at_github"] = @data["pushed_at"]
      @data.delete("pushed_at")

      @data
    else
      puts "Failed to fetch data for repository #{@repository} - received: #{response.code}"
      puts response.body

      # return empty hash if no data
      {}
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

  return repos
end

# save to json file
def save_to_json(data, filename)
  File.open(filename, 'w') do |file|
    file.write(JSON.pretty_generate(data))
  end
end



  if __FILE__ == $PROGRAM_NAME
    username = "neonwatty"

    # get repositories for user
    puts "Fetching reposiotires for user #{username}:"
    repositories = get_user_repositories(username: username)
    puts "Done!"

    # save to json file
    save_to_json(repositories, 'user_repos.json')

    # loop over repositories, get traffic data for each
    repositories = ["meme-search"]
    all_traffic_data = {}
    all_metadata = {}
    repositories.each do |repo|
      puts "Getting traffic data for #{username}/#{repo}:"
      api = GithubRepoApis.new(username: username, repo: repo)
      traffic_data = api.get_all

      # if traffic_data is not empty
      if traffic_data['views']['views']
        # add start and end timestamps to referrers and paths
        start_timestamp = traffic_data["views"]["views"].first["timestamp"]
        end_timestamp = traffic_data["views"]["views"].last["timestamp"]

        # add to views hash
        traffic_data['views']['start_timestamp'] = start_timestamp
        traffic_data['views']['end_timestamp'] = end_timestamp

        # add to clones hash
        traffic_data['clones']['start_timestamp'] = start_timestamp
        traffic_data['clones']['end_timestamp'] = end_timestamp

        # loop over elements of referrers and add both timestamps
        traffic_data['referrers'].each do |referrer|
          referrer["start_timestamp"] = start_timestamp
          referrer["end_timestamp"] = end_timestamp
        end

        # loop over elements of paths and add both timestamps
        traffic_data["paths"].each do |path|
          path["start_timestamp"] = start_timestamp
          path["end_timestamp"] = end_timestamp
        end
      end

      all_traffic_data[repo] = traffic_data
      puts 'Done!'

      puts "Getting metadata for #{username}/#{repo}:"
      metadata = api.get_repo_metadata
      all_metadata[repo] = metadata
      puts 'Done!'
      end

    save_to_json(all_traffic_data, 'repo_traffic_data.json')
    save_to_json(all_metadata, 'repo_meta_data.json')

    puts "Data saved to repo_traffic_data.json and repo_meta_data.json"
end
