FactoryGirl.define do
  factory :csv_upload do
    csv_file do
      Rack::Test::UploadedFile.new(
        File.join(Rails.root, "spec/fixtures/sample.csv")
      )
    end
  end
end
