FactoryGirl.define do
  factory :tg_object do
    tg_object_type "Order"
    tg_object_id { rand(1..10) }
    timestamp { Time.now.to_i - rand(1..10) }
    object_changes "{}"
  end

  factory :csv_upload do
    csv_file do
      Rack::Test::UploadedFile.new(
        Rails.root.join("spec", "fixtures", "sample.csv")
      )
    end
  end
end
