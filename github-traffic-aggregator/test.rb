require 'json'

# puts from db/test_data/user_repos.json
repos = JSON.parse(File.read('db/test_data/user_repos.json'))
# puts repos

repos = JSON.parse(File.read('db/test_data/repo_metadata.json'))
# puts first repo
repos.each do |key, subdict|
  puts key
end
