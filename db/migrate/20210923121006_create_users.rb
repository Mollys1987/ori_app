class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :nickname
      t.string :age
      t.string :sex
      t.string :prefucture
      t.string :city
      t.string :classification
      t.string :nursing
      t.string :status
      t.string :key_word1
      t.string :key_word2
      t.string :key_word3
      t.string :password_digest
      t.string :remember_digest
      t.string :email
      t.timestamps
    end
  end
end
