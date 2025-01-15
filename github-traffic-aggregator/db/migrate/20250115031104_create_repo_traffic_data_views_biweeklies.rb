class CreateRepoTrafficDataViewsBiweeklies < ActiveRecord::Migration[8.0]
  def change
    create_table :repo_traffic_data_views_biweeklies do |t|
      t.references :repo, null: false, foreign_key: true
      t.datetime :start_timestamp
      t.datetime :end_timestamp
      t.integer :count
      t.integer :uniques

      t.timestamps
    end
  end
end
