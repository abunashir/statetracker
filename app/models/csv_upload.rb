class CsvUpload < ApplicationRecord
  validates :csv_file, presence: true
  has_many :tg_objects, dependent: :nullify
  enum status: { pending: 0, partially_imported: 5, imported: 10 }

  mount_uploader :csv_file, CsvFileUploader

  def self.recent(limit = 100)
    order(created_at: :desc).limit(limit)
  end
end
