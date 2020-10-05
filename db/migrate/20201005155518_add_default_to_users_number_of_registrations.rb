class AddDefaultToUsersNumberOfRegistrations < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :number_of_registrations, :integer, :default => 0
  end
end
