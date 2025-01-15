class CreateRepoTrafficData < ActiveRecord::Migration[8.0]
  def change
    create_table :repo_traffic_data do |t|
      t.references :repo, null: false, foreign_key: true
      t.jsonb :views, default: {}, null: false
      t.jsonb :clones, default: {}, null: false
      t.jsonb :referrers, default: {}, null: false
      t.jsonb :paths, default: {}, null: false
      t.timestamps
    end
  end
end
