class AddClassificationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :classification, :string
  end
end
