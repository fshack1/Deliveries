# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :set_user_id
  before_action :find_or_initialize_chat_session

  def index
    @messages = @chat_session.data.reject { |message| message["role"] == "system" }

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to deliveries_path }
    end
  end

  def create
    deliveries = Delivery.all
    return unless deliveries.any?

    user_message = params[:message].to_s.strip

    if user_message.blank?
      render_error_message("Please enter a valid message.")
      return
    end

    new_message = { "role" => "user", "content" => user_message }
    updated_conversation = @chat_session.data << new_message

    begin
      updated_conversation = LlmService.chat_with_llm(
        conversation: updated_conversation,
        deliveries:
      )

      @chat_session.update_conversation!(updated_conversation)
      @new_messages = updated_conversation.last(2)

    rescue => e
      Rails.logger.error("Chat error: #{e.message}")
      render_error_message("Something went wrong. Please try again.")
    end
  end

  def find_or_initialize_chat_session
    @chat_session = ChatSession.find_or_create_by(user_id: session[:user_id])
  end

  def set_user_id
    session[:user_id] ||= SecureRandom.uuid
  end

  private def render_error_message(message)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.append(
          "chat_messages",
          partial: "chats/message",
          locals: { message: { "role" => "error", "content" => message } }
        )
      end
    end
  end
end
