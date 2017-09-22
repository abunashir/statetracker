class CreateTgObjects < ActiveRecord::Migration[5.0]
  def change
    create_table :tg_objects do |t|
      t.integer :tg_object_id, index: true
      t.string :tg_object_type
      t.integer :timestamp, index: true
      t.jsonb :object_changes
      t.references :csv_upload, foreign_key: true

      t.timestamps
    end
  end
end
