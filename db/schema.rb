# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_22_193928) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "registrations", force: :cascade do |t|
    t.string "live_course_id"
    t.string "live_course_session_id"
    t.string "bridge_registration_id"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "uid"
    t.boolean "is_attended"
    t.index ["user_id"], name: "index_registrations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.integer "number_of_registrations"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phone_number"
  end

  add_foreign_key "registrations", "users"
end
