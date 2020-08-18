class AddGioitinhToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :gioitinh, :integer
  end
end
