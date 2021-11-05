class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.string :picture
      t.string :video
      t.string :key_word1
      t.string :key_word2
      t.string :key_word3
      t.string :key_word4
      t.string :key_word5
      t.timestamps
    end
    add_index :posts, :user_id
    add_index :posts, :created_at
  end
end