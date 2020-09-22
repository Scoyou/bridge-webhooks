# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do |reg|
    Registration.create(
        user_id: User.last.id,
        uid: User.last.uid,
        live_course_id: rand(20),
        live_course_session_id: rand(30),
        bridge_registration_id: rand(500)
    )
end