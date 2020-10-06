class AddLcStartTimeToRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :session_start_time, :datetime
  end
end
