require "test_helper"

class ChatSessionTest < ActiveSupport::TestCase
  setup do
    @chat_session = ChatSession.create!(
      data: [ { "role" => "user", "content" => "Test message" } ],
      user_id: 3
    )
  end

  test "conversation data" do
    assert_equal([ { "role" => "user", "content" => "Test message" } ], @chat_session.conversation)
  end

  test "update_conversation! updates the data attribute" do
    new_conversation = [ { "role" => "assistant", "content" => "Test message 2" } ]
    @chat_session.update_conversation!(new_conversation)

    assert_equal(new_conversation, @chat_session.data)
  end

  test "cleanup_old_sessions destroys sessions older than 2 hours" do
    old_session = ChatSession.create!(data: [], updated_at: 3.hours.ago, user_id: 1)
    recent_session = ChatSession.create!(data: [], updated_at: 1.hour.ago, user_id: 1)

    ChatSession.cleanup_old_sessions

    assert_not ChatSession.exists?(old_session.id)
    assert ChatSession.exists?(recent_session.id)
  end
end
