class CleanupChatSessionsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    ChatSession.cleanup_old_sessions
  end
end
