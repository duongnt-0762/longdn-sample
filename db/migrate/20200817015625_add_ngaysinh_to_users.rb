class AddNgaysinhToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :ngaysinh, :date
  end
end
