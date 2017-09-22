require "rails_helper"

RSpec.describe CsvUploadsController, type: :controller do
  describe "POST /csv_uploads" do
    context "with valid data" do
      it "creates a new upload and invoke import to importer" do
        allow(CsvDataImporter).to receive(:import)

        post(:create, params: { csv_upload: attributes_for(:csv_upload) })

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq(t("csv_upload.create.success"))
        expect(CsvDataImporter).to have_received(:import).with(CsvUpload.last)
      end
    end
  end
end
