require "rails_helper"

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

  describe ".find_status" do
    context "with valid timestamp entries" do
      it "returns changes status during a timeframe" do
        create_tg_object(1, 20, name: "John", status: "unpaid")
        create_tg_object(1, 10, status: "paid", provider: "DHL")
        create_tg_object(1, 1, { status: "paid", name: "Jennie" }, "Product")

        status = TgObject.find_status(1, "Order", Time.now.to_i)

        expect(
          status.to_json,
        ).to eq({ name: "John", status: "paid", provider: "DHL" }.to_json)
      end
    end

    context "with non existance entries" do
      it "returns an empty json object for that object" do
        status = TgObject.find_status(1, "Order", Time.now.to_i)

        expect(status.empty?).to be_truthy
      end
    end
  end

  def create_tg_object(id, minutes, object_changes, object_type = "Order")
    create(
      :tg_object,
      tg_object_id: id,
      tg_object_type: object_type,
      object_changes: object_changes,
      timestamp: minutes.to_i.minutes.ago.to_i,
    )
  end
end
