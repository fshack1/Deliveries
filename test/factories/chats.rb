FactoryBot.define do
  factory :chat_session do
    user_id { SecureRandom.uuid }
    data { [ { "role" => "user", "content" => "Test chat" } ] }

    trait :with_multiple_messages do
      data do
        [
          { "role" => "user", "content" => "First message" },
          { "role" => "assistant", "content" => "Response to first message" }
        ]
      end
    end
  end
end
