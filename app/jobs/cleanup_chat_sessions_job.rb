class CleanupChatSessionsJob < ApplicationJob
  def perform
    ChatSession.cleanup_old_sessions
  end
end
