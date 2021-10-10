class AddColumsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :age, :string
    add_column :users, :sex, :string
    add_column :users, :prefucture, :string
    add_column :users, :city, :string
    add_column :users, :type, :string
    add_column :users, :nursing, :string
    add_column :users, :status, :string
    add_column :users, :key_word1, :string
    add_column :users, :key_word2, :string
    add_column :users, :key_word3, :string
  end
end
