class AddPrecarrotToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :pre_carrot, :text
  end
end
