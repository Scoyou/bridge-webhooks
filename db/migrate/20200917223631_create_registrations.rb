# frozen_string_literal: true

class CreateRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :registrations do |t|
      t.string :live_course_id
      t.string :live_course_session_id
      t.string :bridge_registration_id
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
