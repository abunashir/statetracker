require "rails_helper"

RSpec.describe CsvUpload, type: :model do
  describe "validations" do
    it { should validate_presence_of :csv_file }
  end

  describe ".recent" do
    it "returns the uploads in descending order" do
      csv_upload_one = create(:csv_upload)
      csv_upload_three = create(:csv_upload, created_at: 20.days.ago)
      csv_upload_two = create(:csv_upload, created_at: 10.days.ago)

      csv_uploads = CsvUpload.recent

      expect(
        csv_uploads.map(&:id)
      ).to eq([csv_upload_one.id, csv_upload_two.id, csv_upload_three.id])
    end
  end
end
