class CreateChatSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :chat_sessions do |t|
      t.string :user_id, null: false
      t.jsonb :data, null: false, default: []

      t.timestamps
    end
  end
end
