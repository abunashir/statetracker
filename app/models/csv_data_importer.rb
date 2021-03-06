require "csv"
require "json"
require "open-uri"

class CsvDataImporter
  def initialize(csv_upload)
    @failed_imports = []
    @csv_upload = csv_upload
  end

  def import
    import_objects_from_csv
    update_csv_upload_status
  rescue CSV::MalformedCSVError
    csv_upload.update(status: :invalid_format)
  end

  def self.import(csv_upload)
    new(csv_upload).import
  end

  private

  attr_reader :csv_upload, :failed_imports

  def import_objects_from_csv
    headers = []
    open(csv_file_path) do |file|
      file.each_line do |csv_line|
        csv_row = CSV.parse(csv_line.gsub('\\"','""')).first

        if headers.empty?
          headers = csv_row.map(&:downcase).map(&:to_sym)
          next
        end

        csv_row = Hash[headers.zip(csv_row)]
        persist_csv_row_to_tg_objects(csv_row)
      end
    end
  end

  def persist_csv_row_to_tg_objects(csv_row)
    tg_object = create_tg_object_from_csv(csv_row)

    unless tg_object.persisted?
      csv_row[:errors] = tg_object.errors
      @failed_imports.push(csv_row.to_h)
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
      tg_object_id: csv_row[:object_id],
      timestamp: csv_row[:timestamp].to_i,
      tg_object_type: csv_row[:object_type],
      object_changes: JSON.parse(csv_row[:object_changes]),
    )
  rescue JSON::ParserError
    TgObject.new { |object| object.errors.add(:object_changes, "Invalid JSON") }
  end

  def csv_file_path
    Rails.env.test? ? csv_upload.csv_file.file.file : csv_upload.csv_file_url
  end
end
