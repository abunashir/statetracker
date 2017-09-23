require "rails_helper"

RSpec.describe TgObjectsHelper, type: :helper do
  describe "uniq_object_types" do
    it "returns the uniq tg object types" do
      create(:tg_object, tg_object_type: "Order")
      create(:tg_object, tg_object_type: "Order")
      create(:tg_object, tg_object_type: "Product")

      expect(helper.uniq_object_types).to match(["Order", "Product"])
    end
  end
end
