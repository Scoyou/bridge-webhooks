# frozen_string_literal: true

class AddIsAttendedToRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :is_attended, :boolean
  end
end
