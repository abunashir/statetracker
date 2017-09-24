require "rails_helper"

RSpec.describe CsvDataImporterJob do
  describe "#perform" do
    it "invokes import method to data importer" do
      csv_upload = create(:csv_upload)
      allow(CsvDataImporter).to receive(:import)

      CsvDataImporterJob.perform_now(csv_upload)

      expect(CsvDataImporter).to have_received(:import).with(csv_upload)
    end
  end
end
