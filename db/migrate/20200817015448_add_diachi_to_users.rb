class AddDiachiToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :diachi, :string
  end
end
