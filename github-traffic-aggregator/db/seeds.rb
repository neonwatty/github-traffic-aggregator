# create user
username="neonwatty"
user = User.create(username: username, password: "password", password_confirmation: "password")
user.save if user.valid?

# create repos from test data file in test_data/user_repos.json
repos = JSON.parse(File.read('test_data/user_repos.json'))
repos.each do |repo|
  r = Repo.create(name: repo, user: user)
  r.save if r.valid?
end

# create repo metadata from test data file in test_data/repo_metadata.json
repo_metadata = JSON.parse(File.read('test_data/repo_metadata.json'))

# loop over each key-value pair in the repo_metadata hash
# create a new RepoMetadata object with the key-value pair as attributes
repo_metadata.each do |repo_name, subdict|
  # create a new entry hash with the repo key and value
  entry = {repo: Repo.find_by(name: repo_name)}

  # merge entry and subdict hashes
  data = entry.merge(subdict)

  # create and save
  r = RepoMetadata.create(data)
  r.save if r.valid?
end

# # create repo traffic from test data file in test_data/repo_traffic_data.json
# repo_traffic = JSON.parse(File.read('test_data/repo_traffic_data.json'))
# repo_traffic.each do |repo|
#   r = RepoTraffic.create(repo)
#   r.save if r.valid?
# end
