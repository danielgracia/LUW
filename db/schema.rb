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

ActiveRecord::Schema.define(version: 20141122181335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "content_id"
    t.text     "body"
    t.integer  "score",           default: 0
    t.string   "attachment_path"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "comments", ["content_id"], name: "index_comments_on_content_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "contents", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.string   "attachment_path"
    t.integer  "score",           default: 0
    t.boolean  "closed"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "contents", ["user_id"], name: "index_contents_on_user_id", using: :btree

  create_table "contents_tags", id: false, force: true do |t|
    t.integer "tag_id",     null: false
    t.integer "content_id", null: false
  end

  create_table "invites", force: true do |t|
    t.integer  "user_id"
    t.boolean  "used",       default: false
    t.uuid     "token",      default: "uuid_generate_v4()"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "tags", force: true do |t|
    t.string "body"
  end

  add_index "tags", ["body"], name: "index_tags_on_body", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "photo_path"
    t.boolean  "banned"
    t.text     "profile"
    t.integer  "reputation"
    t.boolean  "admin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

  create_table "votes", force: true do |t|
    t.integer  "user_id"
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "value",        default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "votes", ["user_id", "votable_id", "votable_type"], name: "index_votes_on_user_id_and_votable_id_and_votable_type", unique: true, using: :btree

end
