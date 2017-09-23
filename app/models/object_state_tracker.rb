class ObjectStateTracker
  include ActiveModel::Model

  attr_accessor :tg_object_id, :tg_object_type, :timestamp
  validates :tg_object_id, :tg_object_type, :timestamp, presence: true

  def status
    @status ||= find_tg_object_status
  end

  private

  def find_tg_object_status
    TgObject.find_status(tg_object_id, tg_object_type, timestamp)
  end
end
