require 'rails_helper'

RSpec.describe TgObject, type: :model do
  describe "validations" do
    it { should validate_presence_of :tg_object_id }
    it { should validate_presence_of :tg_object_type }
    it { should validate_presence_of :timestamp }

    it "ensures unique timestamp entry scopped to object and type " do
      should(
        validate_uniqueness_of(:timestamp).
        scoped_to(:tg_object_id, :tg_object_type).
        with_message("duplicate entry for exact same object")
      )
    end
  end
end
