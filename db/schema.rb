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

ActiveRecord::Schema.define(version: 20141210054139) do

  create_table "books", force: true do |t|
    t.string   "title"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bundle_mails", force: true do |t|
    t.string   "title",       null: false
    t.text     "body"
    t.integer  "disaster_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "confirmations", force: true do |t|
    t.string   "locate"
    t.text     "locate_desc"
    t.string   "safely"
    t.text     "safely_desc"
    t.boolean  "contacted",   default: false, null: false
    t.integer  "disaster_id",                 null: false
    t.integer  "user_id",                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "disasters", force: true do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.string   "tel"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
