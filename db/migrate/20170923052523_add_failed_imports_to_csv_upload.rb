class AddFailedImportsToCsvUpload < ActiveRecord::Migration[5.0]
  def change
    add_column :csv_uploads, :failed_imports, :jsonb, default: {}
  end
end
