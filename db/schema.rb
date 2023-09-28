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

ActiveRecord::Schema[7.0].define(version: 2023_09_27_043119) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "organization_id", null: false
    t.string "name", null: false
    t.string "website"
    t.string "country", null: false
    t.string "description", null: false
    t.integer "founded", null: false
    t.string "industry", null: false
    t.string "number_of_employees", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "earthquakes", force: :cascade do |t|
    t.datetime "DateTime"
    t.float "Latitude"
    t.float "Longitude"
    t.float "Depth"
    t.float "Magnitude"
    t.string "MagType"
    t.integer "NbStations"
    t.integer "Gap"
    t.integer "Distance"
    t.float "RMS"
    t.string "Source"
    t.integer "EventID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "football_players", force: :cascade do |t|
    t.string "short_name", null: false
    t.string "long_name", null: false
    t.string "player_positions"
    t.integer "overall"
    t.integer "potential"
    t.integer "age"
    t.date "dob"
    t.integer "height"
    t.string "club_name"
    t.string "league_name"
    t.string "club_position"
    t.integer "club_jersey"
    t.date "club_joined"
    t.string "nationality"
    t.string "preferred_foot"
    t.integer "pace"
    t.integer "shooting"
    t.integer "passing"
    t.integer "dribbling"
    t.integer "defending"
    t.integer "physical"
    t.integer "crossing"
    t.integer "finishing"
    t.integer "heading"
    t.integer "short_pass"
    t.integer "volleys"
    t.integer "skills"
    t.integer "control"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "customer", null: false
    t.integer "employee_id", null: false
    t.date "order_date"
    t.date "required_date"
    t.date "shipped_date"
    t.integer "shipped_id", null: false
    t.float "freight", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "google_id"
    t.string "name"
    t.text "token"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_tables", force: :cascade do |t|
    t.string "google_id"
    t.string "name"
    t.text "token"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
