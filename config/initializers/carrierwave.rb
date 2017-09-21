CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider              => "AWS",
    :region                => ENV["ST_S3_REGION"],
    :aws_access_key_id     => ENV["ST_S3_KEY"],
    :aws_secret_access_key => ENV["ST_S3_SECRET"]
  }

  if Rails.env.test?
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  else
    config.storage = :fog
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads"
  config.fog_directory = ENV["ST_S3_BUCKET_NAME"]
end
