# frozen_string_literal: true

class ChatSession < ApplicationRecord
  attribute :data, :jsonb, default: []

  def conversation
    self.data || []
  end

  def update_conversation!(new_conversation)
    update!(data: new_conversation)
  end

  def self.cleanup_old_sessions
    where("updated_at < ?", 2.hours.ago).destroy_all
  end
end
