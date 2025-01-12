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
repo_metadata.each do |repo|
  r = RepoMetadata.create(repo)
  r.save if r.valid?
end

# create repo traffic from test data file in test_data/repo_traffic_data.json
repo_traffic = JSON.parse(File.read('test_data/repo_traffic_data.json'))
repo_traffic.each do |repo|
  r = RepoTraffic.create(repo)
  r.save if r.valid?
end
