class CreateDirectMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :direct_messages do |t|
      t.text "content"
      t.integer "user_id"
      t.integer "to_user_id"
      t.timestamp "to_user_opentime"
      t.timestamps
    end
  end
end
