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

ActiveRecord::Schema.define(version: 20140908085331) do

  create_table "account_details", force: true do |t|
    t.string   "title",                    null: false
    t.decimal  "sum",        default: 0.0, null: false
    t.integer  "user_id"
    t.string   "memo"
    t.string   "purpose"
    t.integer  "account_id"
    t.decimal  "amount",     default: 0.0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "account_details", ["account_id"], name: "index_account_details_on_account_id"
  add_index "account_details", ["user_id"], name: "index_account_details_on_user_id"

  create_table "accounts", force: true do |t|
    t.string   "title",                      null: false
    t.decimal  "amount",     default: 0.0,   null: false
    t.integer  "creator",                    null: false
    t.integer  "officer",                    null: false
    t.boolean  "is_public",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "app_logs", force: true do |t|
    t.integer "app_id"
    t.string  "module", null: false
  end

  create_table "apps", force: true do |t|
    t.string   "name",             limit: 32
    t.string   "access_key"
    t.string   "secret_key"
    t.integer  "permission_level",            default: 0,    null: false
    t.boolean  "enable",                      default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt",                        default: ""
  end

  create_table "configs", force: true do |t|
    t.string "key",   null: false
    t.text   "value", null: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                                                      null: false
    t.string   "crypted_password",                                           null: false
    t.string   "salt",                                                       null: false
    t.string   "name"
    t.string   "nick"
    t.datetime "birth"
    t.string   "address"
    t.string   "phone",                           limit: 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "photo_url"
    t.boolean  "admin",                                      default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token"

end
