# frozen_string_literal: true

require "test_helper"

class DeliveriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @delivery = create(:delivery)
  end

  test "should get index" do
    get deliveries_url
    assert_response :success
    assert_select "h1", "Deliveries"
    assert_not_nil assigns(:records)
    assert_not_nil assigns(:total_cost)
  end

  test "should get new" do
    get new_delivery_url
    assert_response :success
    assert_select "form"
  end

  test "should create delivery" do
    assert_difference("Delivery.count", 1) do
      post deliveries_url, params: {
        delivery: {
          pickup_address: "123 Main St",
          delivery_address: "456 Elm St",
          weight: 10,
          distance: 20,
          scheduled_time: Time.zone.now + 1.day,
          driver_name: "John Doe"
        }
      }
    end
    assert_redirected_to delivery_url(Delivery.last)
    follow_redirect!
    assert_match "Delivery was scheduled successfully.", response.body
  end

  test "should show delivery" do
    get delivery_url(@delivery)
    assert_response :success
    assert_select "strong", text: "Pickup address:"
  end

  test "should get edit" do
    get edit_delivery_url(@delivery)
    assert_response :success
    assert_select "form"
  end

  test "should update delivery" do
    patch delivery_url(@delivery), params: {
      delivery: { pickup_address: "Updated Address" }
    }
    assert_redirected_to delivery_url(@delivery)
    follow_redirect!
    assert_match "Delivery was successfully updated.", response.body
    assert_equal "Updated Address", @delivery.reload.pickup_address
  end

  test "should destroy delivery" do
    assert_difference("Delivery.count", -1) do
      delete delivery_url(@delivery)
    end
    assert_redirected_to deliveries_url
    follow_redirect!
    assert_match "Delivery was successfully destroyed.", response.body
  end

  test "should get total cost" do
    get total_cost_deliveries_url
    assert_response :success
    assert_select "table"
    assert_not_nil assigns(:total_cost)
  end
end
