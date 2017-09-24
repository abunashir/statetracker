require "rails_helper"

RSpec.describe CsvUploadsController, type: :controller do
  describe "POST /csv_uploads" do
    context "with valid data" do
      it "creates a new upload and enqueue an import job" do
        allow(CsvDataImporterJob).to receive(:perform_later)
        allow(CsvDataImporter).to receive(:import)

        post(:create, params: { csv_upload: attributes_for(:csv_upload) })

        expect(
          CsvDataImporterJob,
        ).to have_received(:perform_later).with(CsvUpload.last)

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq(t("csv_uploads.create.success"))
      end
    end
  end
end
