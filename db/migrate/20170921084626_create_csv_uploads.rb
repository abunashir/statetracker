class CreateCsvUploads < ActiveRecord::Migration[5.0]
  def change
    create_table :csv_uploads do |t|
      t.string :tag
      t.string :csv_file

      t.timestamps
    end
  end
end
