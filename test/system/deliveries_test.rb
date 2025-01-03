# frozen_string_literal: true

require "application_system_test_case"

class DeliveriesTest < ApplicationSystemTestCase
  setup do
    @delivery = create(:delivery)
  end

  test "visiting the index" do
    visit deliveries_url
    assert_selector "h1", text: "Deliveries"
  end

  test "should create delivery" do
    visit deliveries_url
    click_on "New delivery"

    fill_in "pickup_address", with: "New Pickup Address"
    fill_in "delivery_address", with: "New Delivery Address"
    fill_in "weight", with: 10
    fill_in "distance", with: 100
    fill_in "scheduled_time", with: (Time.current + 1.day)
    click_on "Submit"

    assert_text "Delivery was scheduled successfully"
    click_on "Back"
  end

  test "should update delivery" do
    visit delivery_url(@delivery)
    click_on "Edit this delivery", match: :first

    fill_in "pickup_address", with: "Updated Pickup Address"
    fill_in "delivery_address", with: @delivery.delivery_address
    fill_in "weight", with: @delivery.weight
    fill_in "distance", with: @delivery.distance
    fill_in "scheduled_time", with: @delivery.scheduled_time
    fill_in "driver_name", with: @delivery.driver_name
    click_on "Submit"

    assert_text "Delivery was successfully updated"
    click_on "Back"
  end

  test "should destroy delivery" do
    visit delivery_url(@delivery)
    click_on "Destroy this delivery", match: :first

    assert_text "Delivery was successfully destroyed"
  end
end
