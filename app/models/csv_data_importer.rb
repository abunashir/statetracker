require "csv"
require "open-uri"

class CsvDataImporter
  def initialize(csv_upload)
    @failed_imports = []
    @csv_upload = csv_upload
  end

  def import
    import_objects_from_csv
    update_csv_upload_status
  end

  def self.import(csv_upload)
    new(csv_upload).import
  end

  private

  attr_reader :csv_upload, :failed_imports

  def import_objects_from_csv
    CSV.new(open(csv_file_path), csv_options).each do |csv_row|
      tg_object = create_tg_object_from_csv(csv_row)

      unless tg_object.persisted?
        csv_row[:errors] = tg_object.errors
        @failed_imports.push(csv_row.to_h)
      end
    end
  end

  def update_csv_upload_status
    if @failed_imports.empty?
      csv_upload.update!(status: :imported)
    else
      csv_upload.update!(
        status: :partially_imported,
        failed_imports: @failed_imports,
      )
    end
  end

  def create_tg_object_from_csv(csv_row)
    TgObject.create(
      csv_upload: csv_upload,
      timestamp: csv_row[:timestamp],
      tg_object_id: csv_row[:object_id],
      tg_object_type: csv_row[:object_type],
      object_changes: csv_row[:object_changes],
    )
  end

  def csv_options
    { headers: true, header_converters: [:downcase, :symbol] }
  end

  def csv_file_path
    Rails.env.test? ? csv_upload.csv_file.file.file : csv_upload.csv_file_url
  end
end
