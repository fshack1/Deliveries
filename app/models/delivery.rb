# frozen_string_literal: true

class Delivery < ApplicationRecord
  validates :pickup_address, :delivery_address, :weight, :distance, :scheduled_time, presence: true
  validates :weight, :distance, numericality: { greater_than: 0 }
  validate :scheduled_time_within_valid_range

  before_save :calculate_cost

  private def calculate_cost
    self.cost = (distance * 2) + (weight * 1.5)
  end

  private def scheduled_time_within_valid_range
    return unless scheduled_time.present?

    if scheduled_time < Time.now
      errors.add(:scheduled_time, "must be in the future")
    elsif scheduled_time > Time.now + 3.years
      errors.add(:scheduled_time, "must be within the next 3 years")
    end
  end
end
