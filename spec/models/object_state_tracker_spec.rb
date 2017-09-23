require "rails_helper"

RSpec.describe ObjectStateTracker do
  describe "validations" do
    it { should validate_presence_of :tg_object_id }
    it { should validate_presence_of :tg_object_type }
    it { should validate_presence_of :timestamp }
  end

  describe "#status" do
    context "with valid states" do
      it "returns the status successfully" do
        tg_object = create(:tg_object, object_changes: { status: "paid" })

        state_tracker = ObjectStateTracker.new(
          timestamp: Time.now.to_i,
          tg_object_id: tg_object.tg_object_id,
          tg_object_type: tg_object.tg_object_type,
        )

        expect(state_tracker.status.to_json).to eq({ status: "paid"}.to_json)
      end
    end
  end
end
