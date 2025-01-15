# frozen_string_literal: true

class LlmService
  require "openai"

  def self.chat_with_llm(conversation:, deliveries:)
    conversation = prepare_conversation(conversation, deliveries)

    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
    response = client.chat(
      parameters: {
        model:       "gpt-3.5-turbo",
        messages:    conversation,
        max_tokens:  150, # max token for response
        temperature: 0.7
      }
    )

    assistant_content = response.dig("choices", 0, "message", "content").to_s.strip
    conversation << { "role" => "assistant", "content" => assistant_content }

    conversation

  rescue OpenAI::Error => e
    log_error("OpenAI API Error", e.response.body)
    conversation << { "role" => "assistant", "content" => error_message("service") }
    conversation
  rescue StandardError => e
    log_error("Unexpected Error", e.message)
    conversation << { "role" => "assistant", "content" => error_message("unexpected") }
    conversation
  end

  def self.summarize_with_llm(deliveries:)
    summary = deliveries.to_json

    conversation = [
      { "role" => "system", "content" => "Please give a summary of the following data: #{summary}" }
    ]


    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])

    response = client.chat(
      parameters: {
        model:       "gpt-3.5-turbo",
        messages:    conversation,
        max_tokens:  150, # max token for response
        temperature: 0.7
      }
    )

    assistant_content = response.dig("choices", 0, "message", "content").to_s.strip
    conversation << { "role" => "assistant", "content" => assistant_content }

    conversation
  end


  def self.prepare_conversation(conversation, deliveries)
    conversation = conversation.map(&:stringify_keys)
    if conversation.any? { |message| message["role"] == "system" }
      conversation
    else
      conversation.unshift(
        "role" => "system",
        "content" => build_deliveries_prompt(deliveries)
      )
    end
  end

  private_class_method def self.build_deliveries_prompt(deliveries)
    summary = deliveries.to_json

    <<~MSG
      You have access to the following deliveries data:
      #{summary}
      Provide answers based on this data where relevant. Include any relevant details in your response.
    MSG
  end

  private_class_method def self.log_error(error_type, message)
    Rails.logger.error("#{error_type}: #{message}")
  end

  private_class_method def self.error_message(type)
    case type
    when "service"
      "Error: Unable to process your request due to a service issue. Please try again later."
    else
      "Error: An unexpected issue occurred. Please try again later."
    end
  end
end
