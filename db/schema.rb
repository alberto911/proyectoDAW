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

ActiveRecord::Schema.define(version: 20161129231410) do

  create_table "employees", force: true do |t|
    t.boolean  "is_admin",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operations", force: true do |t|
    t.integer  "sender_id"
    t.decimal  "amount",     precision: 10, scale: 2
    t.datetime "created_at"
  end

  create_table "receivers", force: true do |t|
    t.string   "name"
    t.string   "last_name"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "money",        precision: 10, scale: 2, default: 0.0
  end

  add_index "receivers", ["name", "last_name", "phone_number"], name: "index_receivers_on_name_and_last_name_and_phone_number", unique: true, using: :btree

  create_table "receivers_senders", id: false, force: true do |t|
    t.integer "sender_id",   null: false
    t.integer "receiver_id", null: false
  end

  create_table "senders", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "money",      precision: 10, scale: 2, default: 0.0
  end

  create_table "transfers", force: true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.decimal  "amount",      precision: 10, scale: 2
    t.datetime "created_at"
    t.string   "code"
    t.boolean  "recibido",                             default: false
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "last_name"
    t.string   "mail"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "userable_id"
    t.string   "userable_type"
  end

  add_index "users", ["userable_id", "userable_type"], name: "index_users_on_userable_id_and_userable_type", using: :btree

end
