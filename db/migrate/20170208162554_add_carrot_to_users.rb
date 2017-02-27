class AddCarrotToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :carrot, :string
  end
end
