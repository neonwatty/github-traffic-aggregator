# create user
username="neonwatty"
user = User.create(username: username, password: "password", password_confirmation: "password")
user.save if user.valid?

# create repos from test data file in test_data/user_repos.json
#
