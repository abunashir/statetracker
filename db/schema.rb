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

ActiveRecord::Schema.define(version: 20170923052523) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "csv_uploads", force: :cascade do |t|
    t.string   "tag"
    t.string   "csv_file"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "status",         default: 0
    t.jsonb    "failed_imports", default: {}
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "tg_objects", force: :cascade do |t|
    t.integer  "tg_object_id"
    t.string   "tg_object_type"
    t.integer  "timestamp"
    t.jsonb    "object_changes"
    t.integer  "csv_upload_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["csv_upload_id"], name: "index_tg_objects_on_csv_upload_id", using: :btree
  end

  add_foreign_key "tg_objects", "csv_uploads"
end
