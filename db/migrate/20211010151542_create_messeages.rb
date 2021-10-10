class CreateMesseages < ActiveRecord::Migration[5.2]
  def change
    create_table :messeages do |t|
      t.text :messege
      t.integer :sender_id
      t.integer :receiver_id
      t.timestamp :to_user_opentime
      t.timestamps
    end
  end
end
