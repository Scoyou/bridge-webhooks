# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do
  user = User.create(
    uid: Faker::Internet.email,
    phone_number: Faker::PhoneNumber.cell_phone_in_e164,
  )

  10.times do
    Registration.create(
      live_course_id: rand(),
      live_course_session_id: rand(),
      bridge_registration_id: rand(),
      user_id: user.id,
      uid: user.uid,
      is_attended: [true, false].sample,
      live_course_title: Faker::DcComics.title,
      session_start_time: Faker::Time.between_dates(from: Date.today - 20, to: Date.today, period: :all),
    )
  end
end
