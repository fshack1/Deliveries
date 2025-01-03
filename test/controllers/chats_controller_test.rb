# frozen_string_literal: true

require "test_helper"
require "minitest/mock"

class ChatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @chat_session = create(:chat_session)
    @user_message = "This is a test message."
  end

  test "index" do
    get(chats_url, headers: { "Accept" => "text/vnd.turbo-stream.html" })

    assert_response(:success)
    assert_includes(@response.content_type, "text/vnd.turbo-stream.html")
  end

  test "create" do
    conversation = { role: "user", content: @user_message }
    LlmService.stub(:chat_with_llm, [ conversation, { role: "assistant", content: "Response from LLM." } ]) do
      post(chats_url, params: { message: @user_message }, headers: { "Accept" => "text/vnd.turbo-stream.html" })

      assert_response(:success)
      assert_includes(@response.content_type, "text/vnd.turbo-stream.html")

      assert_match(%r{<turbo-stream action="append" target="chat_messages">}, @response.body)
      assert_match(%r{<span>#{@user_message}</span>}, @response.body)
      assert_match(%r{<span>Response from LLM.</span>}, @response.body)
    end
  end

  test "should not create chat with blank message" do
    post(chats_url, params: { message: "" }, headers: { "Accept" => "text/vnd.turbo-stream.html" })

    assert_match("Please enter a valid message.", @response.body)
  end

  test "should handle LLM errors" do
    mock = Minitest::Mock.new
    mock.expect(:call, nil) { raise StandardError, "LLM error" }


    LlmService.stub(:chat_with_llm, mock) do
      post(chats_url, params: { message: @user_message }, headers: { "Accept" => "text/vnd.turbo-stream.html" })

      assert_match("Something went wrong. Please try again.", @response.body)
    end
  end
end
