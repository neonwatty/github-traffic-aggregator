# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_01_15_041205) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "repo_metadata", force: :cascade do |t|
    t.bigint "repo_id", null: false
    t.integer "repo_id_github"
    t.string "node_id"
    t.string "name"
    t.string "full_name"
    t.boolean "private"
    t.string "html_url"
    t.text "description"
    t.boolean "fork"
    t.string "url"
    t.string "forks_url"
    t.string "keys_url"
    t.string "collaborators_url"
    t.string "teams_url"
    t.string "hooks_url"
    t.string "issue_events_url"
    t.string "events_url"
    t.string "assignees_url"
    t.string "branches_url"
    t.string "tags_url"
    t.string "blobs_url"
    t.string "git_tags_url"
    t.string "git_refs_url"
    t.string "trees_url"
    t.string "statuses_url"
    t.string "languages_url"
    t.string "stargazers_url"
    t.string "contributors_url"
    t.string "subscribers_url"
    t.string "subscription_url"
    t.string "commits_url"
    t.string "git_commits_url"
    t.string "comments_url"
    t.string "issue_comment_url"
    t.string "contents_url"
    t.string "compare_url"
    t.string "merges_url"
    t.string "archive_url"
    t.string "downloads_url"
    t.string "issues_url"
    t.string "pulls_url"
    t.string "milestones_url"
    t.string "notifications_url"
    t.string "labels_url"
    t.string "releases_url"
    t.string "deployments_url"
    t.datetime "created_at_github", precision: nil
    t.datetime "updated_at_github", precision: nil
    t.datetime "pushed_at_github", precision: nil
    t.string "git_url"
    t.string "ssh_url"
    t.string "clone_url"
    t.string "svn_url"
    t.string "homepage"
    t.integer "size"
    t.integer "stargazers_count"
    t.integer "watchers_count"
    t.string "language"
    t.boolean "has_issues"
    t.boolean "has_projects"
    t.boolean "has_downloads"
    t.boolean "has_wiki"
    t.boolean "has_pages"
    t.boolean "has_discussions"
    t.integer "forks_count"
    t.string "mirror_url"
    t.boolean "archived"
    t.boolean "disabled"
    t.integer "open_issues_count"
    t.jsonb "license", default: {}
    t.boolean "allow_forking"
    t.boolean "is_template"
    t.boolean "web_commit_signoff_required"
    t.string "topics", default: [], array: true
    t.string "visibility"
    t.integer "forks"
    t.integer "open_issues"
    t.integer "watchers"
    t.string "default_branch"
    t.boolean "permissions_admin"
    t.boolean "permissions_maintain"
    t.boolean "permissions_push"
    t.boolean "permissions_triage"
    t.boolean "permissions_pull"
    t.boolean "secret_scanning_status"
    t.boolean "secret_scanning_push_protection_status"
    t.boolean "dependabot_security_updates_status"
    t.boolean "secret_scanning_non_provider_patterns_status"
    t.boolean "secret_scanning_validity_checks_status"
    t.integer "network_count"
    t.integer "subscribers_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repo_id"], name: "index_repo_metadata_on_repo_id"
  end

  create_table "repo_traffic_data", force: :cascade do |t|
    t.bigint "repo_id", null: false
    t.jsonb "data", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repo_id"], name: "index_repo_traffic_data_on_repo_id"
  end

  create_table "repo_traffic_data_clones_biweeklies", force: :cascade do |t|
    t.bigint "repo_id", null: false
    t.datetime "start_timestamp"
    t.datetime "end_timestamp"
    t.integer "count"
    t.integer "uniques"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repo_id"], name: "index_repo_traffic_data_clones_biweeklies_on_repo_id"
  end

  create_table "repo_traffic_data_clones_dailies", force: :cascade do |t|
    t.bigint "repo_id", null: false
    t.datetime "timestamp"
    t.integer "count"
    t.integer "uniques"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repo_id"], name: "index_repo_traffic_data_clones_dailies_on_repo_id"
  end

  create_table "repo_traffic_data_paths_weeklies", force: :cascade do |t|
    t.bigint "repo_id", null: false
    t.datetime "start_timestamp"
    t.datetime "end_timestamp"
    t.string "path"
    t.string "title"
    t.integer "count"
    t.integer "uniques"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repo_id"], name: "index_repo_traffic_data_paths_weeklies_on_repo_id"
  end

  create_table "repo_traffic_data_referrers_weeklies", force: :cascade do |t|
    t.bigint "repo_id", null: false
    t.datetime "start_timestamp"
    t.datetime "end_timestamp"
    t.string "referrer"
    t.integer "count"
    t.integer "uniques"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repo_id"], name: "index_repo_traffic_data_referrers_weeklies_on_repo_id"
  end

  create_table "repo_traffic_data_views_biweeklies", force: :cascade do |t|
    t.bigint "repo_id", null: false
    t.datetime "start_timestamp"
    t.datetime "end_timestamp"
    t.integer "count"
    t.integer "uniques"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repo_id"], name: "index_repo_traffic_data_views_biweeklies_on_repo_id"
  end

  create_table "repo_traffic_data_views_dailies", force: :cascade do |t|
    t.bigint "repo_id", null: false
    t.datetime "timestamp"
    t.integer "count"
    t.integer "uniques"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repo_id"], name: "index_repo_traffic_data_views_dailies_on_repo_id"
  end

  create_table "repos", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_repos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "repo_metadata", "repos"
  add_foreign_key "repo_traffic_data", "repos"
  add_foreign_key "repo_traffic_data_clones_biweeklies", "repos"
  add_foreign_key "repo_traffic_data_clones_dailies", "repos"
  add_foreign_key "repo_traffic_data_paths_weeklies", "repos"
  add_foreign_key "repo_traffic_data_referrers_weeklies", "repos"
  add_foreign_key "repo_traffic_data_views_biweeklies", "repos"
  add_foreign_key "repo_traffic_data_views_dailies", "repos"
  add_foreign_key "repos", "users"
end
