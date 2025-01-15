class CreateRepoTrafficDataPathsWeeklies < ActiveRecord::Migration[8.0]
  def change
    create_table :repo_traffic_data_paths_weeklies do |t|
      t.references :repo, null: false, foreign_key: true
      t.datetime :start_timestamp
      t.datetime :end_timestamp
      t.string :path
      t.string :title
      t.integer :count
      t.integer :uniques

      t.timestamps
    end
  end
end
