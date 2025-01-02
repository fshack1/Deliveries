class CleanupChatSessionsJob < ApplicationJob
  def perform(*args)
    ChatSession.cleanup_old_sessions
  end
end
