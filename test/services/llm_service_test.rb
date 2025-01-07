# frozen_string_literal: true

require "minitest/mock"
require "test_helper"

class LlmServiceTest < ActiveSupport::TestCase
  setup do
    @conversation = [ { "role" => "user", "content" => "Hello" } ]
    @deliveries = [ { id: 1, status: "delivered" } ]
  end

  test "chat_with_llm returns conversation with assistant response" do
    OpenAI::Client.stub_any_instance(:chat, {
      "choices" => [ { "message" => { "content" => "Hello! How can I assist you today?" } } ]
    }) do
      result = LlmService.chat_with_llm(conversation: @conversation, deliveries: @deliveries)

      assert_equal(3, result.size)
      assert_equal("assistant", result.last["role"])
      assert_equal("Hello! How can I assist you today?", result.last["content"])
    end
  end


  test "chat_with_llm handles OpenAI::Error" do
    mock_client = Minitest::Mock.new
    mock_client.expect(:chat, -> { raise OpenAI::Error.new("API error") })

    OpenAI::Client.stub(:new, mock_client) do
      result = LlmService.chat_with_llm(conversation: @conversation, deliveries: @deliveries)

      assert_equal(3, result.size)
      assert_equal("assistant", result.last["role"])
      assert_match("Error: An unexpected issue occurred. Please try again later.", result.last["content"])
    end
  end


  test "chat_with_llm handles StandardError" do
    mock_client = Minitest::Mock.new
    mock_client.expect(:chat, -> { raise StandardError::Error.new("Unexpected error") })

    OpenAI::Client.stub(:new, mock_client) do
      result = LlmService.chat_with_llm(conversation: @conversation, deliveries: @deliveries)

      assert_equal(3, result.size)
      assert_equal("assistant", result.last["role"])
      assert_match("Error: An unexpected issue occurred. Please try again later.", result.last["content"])
    end
  end

  test "prepare_conversation adds system message" do
    result = LlmService.prepare_conversation(@conversation, @deliveries)

    assert_equal(2, result.size)
    assert_equal("system", result.first["role"])
    assert_match("You have access to the following deliveries data:", result.first["content"])
  end
end
