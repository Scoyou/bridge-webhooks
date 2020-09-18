class AddUidToRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :uid, :string
  end
end
