# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_13_194747) do

  create_table "closecontacts", force: :cascade do |t|
    t.string "firstname", null: false
    t.string "secondname", null: false
    t.string "telephone"
    t.string "email"
    t.boolean "regular", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
  end

  create_table "closecontacts_events", force: :cascade do |t|
    t.integer "closecontact_id"
    t.integer "event_id"
    t.index ["closecontact_id"], name: "index_closecontacts_events_on_closecontact_id"
    t.index ["event_id"], name: "index_closecontacts_events_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.datetime "date"
    t.integer "duration"
    t.boolean "indoors"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", default: "CN-=+9nG5A", null: false
    t.string "session_token", null: false
    t.boolean "activated", default: true, null: false
    t.string "activation_token", default: "activate", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activation_token"], name: "index_users_on_activation_token"
    t.index ["email"], name: "index_users_on_email"
    t.index ["session_token"], name: "index_users_on_session_token", unique: true
  end

end
