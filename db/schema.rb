# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_08_06_224228) do
  create_table "copies", force: :cascade do |t|
    t.integer "movie_id", null: false
    t.string "identification_code", null: false
    t.integer "media", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_copies_on_movie_id"
  end

  create_table "favorite_movies", id: false, force: :cascade do |t|
    t.integer "movie_id"
    t.integer "user_id"
    t.index ["movie_id"], name: "index_favorite_movies_on_movie_id"
    t.index ["user_id", "movie_id"], name: "index_favorite_movies_on_user_id_and_movie_id", unique: true
    t.index ["user_id"], name: "index_favorite_movies_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title", null: false
    t.string "genre", null: false
    t.float "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "year", null: false
    t.index ["title", "year"], name: "index_movies_on_title_and_year", unique: true
  end

  create_table "rentals", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "checkout_date", null: false
    t.date "due_date", null: false
    t.date "returned_date"
    t.integer "copy_id"
    t.index ["copy_id"], name: "index_rentals_on_copy_id"
    t.index ["user_id", "copy_id"], name: "index_rentals_on_user_id_and_copy_id"
    t.index ["user_id"], name: "index_rentals_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_users_on_name"
  end

  add_foreign_key "copies", "movies"
  add_foreign_key "favorite_movies", "movies"
  add_foreign_key "favorite_movies", "users"
  add_foreign_key "rentals", "copies"
  add_foreign_key "rentals", "users"
end
