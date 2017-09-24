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

  def self.find_status(tg_object_id, tg_object_type, timestamp = nil)
    select("jsonb_object_agg(object_changes order by timestamp asc) as status").
      where(tg_object_id: tg_object_id, tg_object_type: tg_object_type).
      where("timestamp <= ?", (timestamp || Time.now).to_i).take.status
  end
end
