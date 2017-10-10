class CsvUpload < ApplicationRecord
  validates :csv_file, presence: true
  has_many :tg_objects, dependent: :nullify
  mount_uploader :csv_file, CsvFileUploader

  enum(
    status: {
      pending: 0,
      imported: 10,
      invalid_format: 20,
      partially_imported: 5,
    },
  )

  def self.recent(limit = 100)
    order(created_at: :desc).limit(limit)
  end
end
