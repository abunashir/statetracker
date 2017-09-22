FactoryGirl.define do
  factory :tg_object do
    tg_object_id 1
    tg_object_type "MyString"
    timestamp 1
    object_changes ""
    csv_upload nil
  end
  factory :csv_upload do
    csv_file do
      Rack::Test::UploadedFile.new(
        Rails.root.join("spec", "fixtures", "sample.csv")
      )
    end
  end
end
