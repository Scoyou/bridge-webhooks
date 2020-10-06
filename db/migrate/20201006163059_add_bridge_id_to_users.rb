class AddBridgeIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :bridge_user_id, :string
  end
end
