module TgObjectsHelper
  def uniq_object_types
    TgObject.order(tg_object_type: :asc).distinct.pluck(:tg_object_type)
  end
end
