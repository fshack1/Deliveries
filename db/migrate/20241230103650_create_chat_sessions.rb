class CreateChatSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :chat_sessions do |t|
      t.string :user_id
      t.jsonb :data

      t.timestamps
    end
  end
end
