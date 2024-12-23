# frozen_string_literal: true

require "test_helper"

class DeliveryTest < ActiveSupport::TestCase
  setup do
    @delivery = Delivery.new(
      pickup_address: "123 Main St",
      delivery_address: "456 Elm St",
      weight: 10,
      distance: 20,
      scheduled_time: Time.zone.now + 1.day
    )
  end

  test "should be valid with valid attributes" do
    assert @delivery.valid?
  end

  test "should be invalid without a pickup address" do
    @delivery.pickup_address = nil
    assert_not @delivery.valid?
    assert_includes @delivery.errors[:pickup_address], "can't be blank"
  end

  test "should be invalid without a delivery address" do
    @delivery.delivery_address = nil
    assert_not @delivery.valid?
    assert_includes @delivery.errors[:delivery_address], "can't be blank"
  end

  test "should be invalid without a weight" do
    @delivery.weight = nil
    assert_not @delivery.valid?
    assert_includes @delivery.errors[:weight], "can't be blank"
  end

  test "should be invalid without a distance" do
    @delivery.distance = nil
    assert_not @delivery.valid?
    assert_includes @delivery.errors[:distance], "can't be blank"
  end

  test "should be invalid without a scheduled time" do
    @delivery.scheduled_time = nil
    assert_not @delivery.valid?
    assert_includes @delivery.errors[:scheduled_time], "can't be blank"
  end

  test "should calculate cost before saving" do
    @delivery.save
    expected_cost = (@delivery.distance * 2) + (@delivery.weight * 1.5)
    assert_equal expected_cost, @delivery.cost
  end

  test "should not overwrite cost after saving if no changes are made" do
    @delivery.save
    original_cost = @delivery.cost

    @delivery.update(driver_name: "Updated Driver")
    assert_equal original_cost, @delivery.cost
  end
end
