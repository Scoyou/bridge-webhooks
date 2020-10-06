class RemoveBridgeIdFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :bridge_user_id
  end
end
