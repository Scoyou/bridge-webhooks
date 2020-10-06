class AddLcTitleToRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_column :registrations, :live_course_title, :string
  end
end
