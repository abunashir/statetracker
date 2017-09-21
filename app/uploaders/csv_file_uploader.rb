class CsvFileUploader < CarrierWave::Uploader::Base
  def extension_white_list
    %w(csv)
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
