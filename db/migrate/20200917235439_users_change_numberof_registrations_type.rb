class UsersChangeNumberofRegistrationsType < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :number_of_registrations, 'integer USING CAST(number_of_registrations AS integer)'
  end
end
