class CsvUpload < ApplicationRecord
  validates :csv_file, presence: true
  mount_uploader :csv_file, CsvFileUploader

  def self.recent(limit = 100)
    order(created_at: :desc).limit(limit)
  end
end
