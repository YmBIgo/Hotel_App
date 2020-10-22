# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20201021162804) do

  create_table "articles", force: :cascade do |t|
    t.string   "title",        default: "", null: false
    t.text     "content"
    t.string   "author",                    null: false
    t.string   "thumbnail",    default: "", null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "article_type", default: 0,  null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string   "title",        default: "", null: false
    t.integer  "price",        default: 0,  null: false
    t.integer  "people_num",   default: 1,  null: false
    t.integer  "room_num",     default: 1,  null: false
    t.text     "explanation"
    t.text     "html_content"
    t.string   "photo_url",    default: "", null: false
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "remainrooms", force: :cascade do |t|
    t.string   "reservation_ids", default: "", null: false
    t.date     "room_date"
    t.string   "room_ids",        default: "", null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "room_prices",     default: "", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "plan_id",      default: 0,     null: false
    t.integer  "user_id",      default: 0,     null: false
    t.integer  "people_num",   default: 0,     null: false
    t.integer  "payment_type", default: 0,     null: false
    t.string   "email",        default: "",    null: false
    t.string   "first_name",   default: "",    null: false
    t.string   "last_name",    default: "",    null: false
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "url_hash"
    t.boolean  "has_paid",     default: false, null: false
    t.integer  "price",        default: 0,     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.boolean  "is_admin",               default: false, null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
