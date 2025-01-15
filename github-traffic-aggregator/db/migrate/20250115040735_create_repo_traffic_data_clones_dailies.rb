class CreateRepoTrafficDataClonesDailies < ActiveRecord::Migration[8.0]
  def change
    create_table :repo_traffic_data_clones_dailies do |t|
      t.references :repo, null: false, foreign_key: true
      t.datetime :timestamp
      t.integer :count
      t.integer :uniques

      t.timestamps
    end
  end
end
