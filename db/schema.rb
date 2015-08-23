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

ActiveRecord::Schema.define(version: 20150823054400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "course_offers", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "industry_id"
    t.integer  "teacher_id"
    t.string   "date"
    t.string   "location"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "course_offers", ["course_id"], name: "index_course_offers_on_course_id", using: :btree
  add_index "course_offers", ["industry_id"], name: "index_course_offers_on_industry_id", using: :btree
  add_index "course_offers", ["teacher_id"], name: "index_course_offers_on_teacher_id", using: :btree

  create_table "course_offers_students", force: :cascade do |t|
    t.integer "course_offer_id"
    t.integer "student_id"
  end

  add_index "course_offers_students", ["course_offer_id", "student_id"], name: "index_course_offers_students_on_course_offer_id_and_student_id", unique: true, using: :btree

  create_table "course_ratings", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.integer  "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "course_ratings", ["course_id", "user_id"], name: "index_course_ratings_on_course_id_and_user_id", unique: true, using: :btree
  add_index "course_ratings", ["course_id"], name: "index_course_ratings_on_course_id", using: :btree
  add_index "course_ratings", ["user_id"], name: "index_course_ratings_on_user_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "requirements"
    t.string   "cost"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "description"
    t.string   "image"
  end

  create_table "courses_industries", force: :cascade do |t|
    t.integer "course_id"
    t.integer "industry_id"
  end

  add_index "courses_industries", ["course_id", "industry_id"], name: "index_courses_industries_on_course_id_and_industry_id", unique: true, using: :btree
  add_index "courses_industries", ["course_id"], name: "index_courses_industries_on_course_id", using: :btree
  add_index "courses_industries", ["industry_id"], name: "index_courses_industries_on_industry_id", using: :btree

  create_table "courses_teachers", force: :cascade do |t|
    t.integer "course_id"
    t.integer "teacher_id"
  end

  add_index "courses_teachers", ["course_id", "teacher_id"], name: "index_courses_teachers_on_course_id_and_teacher_id", unique: true, using: :btree
  add_index "courses_teachers", ["course_id"], name: "index_courses_teachers_on_course_id", using: :btree
  add_index "courses_teachers", ["teacher_id"], name: "index_courses_teachers_on_teacher_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "name",                                null: false
    t.string   "type"
    t.string   "field"
    t.string   "age_range"
    t.string   "location"
    t.string   "study"
    t.string   "work"
    t.string   "info"
    t.string   "genre"
    t.integer  "birth_year"
    t.string   "image"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["provider"], name: "index_users_on_provider", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", using: :btree

  add_foreign_key "course_offers", "courses"
  add_foreign_key "course_offers", "users", column: "teacher_id"
  add_foreign_key "course_offers_students", "courses", column: "course_offer_id"
  add_foreign_key "course_offers_students", "users", column: "student_id"
  add_foreign_key "course_ratings", "courses"
  add_foreign_key "course_ratings", "users"
  add_foreign_key "courses_industries", "courses"
  add_foreign_key "courses_industries", "users", column: "industry_id"
  add_foreign_key "courses_teachers", "courses"
  add_foreign_key "courses_teachers", "users", column: "teacher_id"
end
