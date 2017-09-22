require "rails_helper"

RSpec.describe CsvDataImporter do
  describe ".import" do
    context "with valid data" do
      it "importes csv data successfully" do
        csv_upload = create(:csv_upload)

        CsvDataImporter.import(csv_upload)

        expect(csv_upload.status).to eq("imported")
        expect(csv_upload.tg_objects.count).to eq(7)
      end
    end

    context "with some invalid data" do
      it "partially import the valid csv data" do
        csv_upload = create_upload_with_partial_valid_data

        CsvDataImporter.import(csv_upload)

        expect(csv_upload.tg_objects.count).to eq(7)
        expect(csv_upload.status).to eq("partially_imported")
        expect(csv_upload.failed_imports.first["errors"]["timestamp"]).
          to(match_array(["duplicate entry for exact same object"]))
      end
    end
  end

  def create_upload_with_partial_valid_data
    create(
      :csv_upload,
      csv_file: Rack::Test::UploadedFile.new(
        Rails.root.join("spec", "fixtures", "sample-partial.csv")
      )
    )
  end
end
