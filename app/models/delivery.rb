# frozen_string_literal: true

class Delivery < ApplicationRecord
  validates :pickup_address, :delivery_address, :weight, :distance, :scheduled_time, presence: true
  before_save :calculate_cost

  private def calculate_cost
    self.cost = (distance * 2) + (weight * 1.5)
  end
end