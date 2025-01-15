# create user
username="neonwatty"
user = User.create(username: username, password_digest: "password")
user.save if user.valid?

# create repos from test data file in test_data/user_repos.json
repos = JSON.parse(File.read('./db/test_data/user_repos.json'))
repos.each do |repo|
  r = Repo.create(name: repo, user: user)
  r.save if r.valid?
end

# create repo metadata from test data file in test_data/repo_metadata.json
repo_metadata = JSON.parse(File.read('./db/test_data/repo_meta_data.json'))

# loop over each key-value pair in the repo_metadata hash
# create a new RepoMetadata object with the key-value pair as attributes
repo_metadata.each do |repo_name, subdict|
  # create a new entry hash with the repo key and value
  entry = { repo: Repo.find_by(name: repo_name) }

  # merge entry and subdict hashes
  data = entry.merge(subdict)

  # create and save
  r = RepoMetadata.create(data)
  r.save if r.valid?
end

# create repo traffic from test data file in test_data/repo_traffic_data.json
repo_traffic = JSON.parse(File.read('./db/test_data/repo_traffic_data.json'))
repo_traffic.each do |repo_name, subdict|
  subdict.each do |traffic_type, traffic_subdict|
    if traffic_type == "views"
      # get biweekly views
      data = {
        'repo': Repo.find_by(name: repo_name),
        'count': traffic_subdict['count'], 
        'uniques': traffic_subdict['uniques'],
        'start_timestamp': traffic_subdict['start_timestamp'],
        'end_timestamp': traffic_subdict['end_timestamp']
      }

      # save to ViewsBiweekly table
      r = RepoTrafficDataViewsBiweekly.create(data)
      r.save if r.valid?

      # unpack and save daily views
      daily_views = traffic_subdict['views']
      daily_views.each do |view|
        view['repo'] = Repo.find_by(name: repo_name)
        r = RepoTrafficDataViewsDaily.create(view)
        r.save if r.valid?
      end

    elsif traffic_type == "clones"
      # get biweekly clones
      data = {
        'repo': Repo.find_by(name: repo_name),
        'count': traffic_subdict['count'], 
        'uniques': traffic_subdict['uniques'],
        'start_timestamp': traffic_subdict['start_timestamp'],
        'end_timestamp': traffic_subdict['end_timestamp']
      }

      # save to ClonesBiweekly table
      r = RepoTrafficDataClonesBiweekly.create(data)
      r.save if r.valid?

      # unpack and save daily clones
      daily_clones = traffic_subdict['clones']
      daily_clones.each do |clone|
        clone['repo'] = Repo.find_by(name: repo_name)
        r = RepoTrafficDataClonesDaily.create(clone)
        r.save if r.valid?
      end

    elsif traffic_type == "referrers"
      # unpack and save referrers
      referrers = traffic_subdict
      referrers.each do |referrer|
        referrer['repo'] = Repo.find_by(name: repo_name)
        r = RepoTrafficDataReferrersWeekly.create(referrer)
        r.save if r.valid?
      end

    elsif traffic_type == "paths"
      # unpack and save paths
      paths = traffic_subdict
      paths.each do |path|
        path['repo'] = Repo.find_by(name: repo_name)
        r = RepoTrafficDataPathsWeekly.create(path)
        r.save if r.valid?
      end
    end
  end
end
