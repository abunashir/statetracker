class CsvDataImporterJob < ApplicationJob
  def perform(csv_upload)
    CsvDataImporter.import(csv_upload)
  end
end
