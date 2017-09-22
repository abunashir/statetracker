class TgObject < ApplicationRecord
  belongs_to :csv_upload

  validates :tg_object_id, :tg_object_type, presence: true
  validates(
    :timestamp,
    presence: true,
    uniqueness: {
      scope: [:tg_object_id, :tg_object_type],
      message: "duplicate entry for exact same object",
    },
  )
end
