class CreateRepoTrafficData < ActiveRecord::Migration[8.0]
  def change
    create_table :repo_traffic_data do |t|
      t.references :repo, null: false, foreign_key: true
      t.jsonb :data, default: {}, null: false

      t.timestamps
    end
  end
end
