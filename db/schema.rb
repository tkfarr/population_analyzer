# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_21_001123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cbsas", force: :cascade do |t|
    t.integer "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_cbsas_on_code"
  end

  create_table "cbsas_zip_codes", force: :cascade do |t|
    t.integer "cbsa_id"
    t.integer "zip_code_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cbsa_id"], name: "index_cbsas_zip_codes_on_cbsa_id"
    t.index ["zip_code_id"], name: "index_cbsas_zip_codes_on_zip_code_id"
  end

  create_table "msas", force: :cascade do |t|
    t.integer "cbsa_id"
    t.integer "mdiv"
    t.integer "stcou"
    t.string "name"
    t.string "lsad"
    t.integer "pop_estimate_2010"
    t.integer "pop_estimate_2011"
    t.integer "pop_estimate_2012"
    t.integer "pop_estimate_2013"
    t.integer "pop_estimate_2014"
    t.integer "pop_estimate_2015"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cbsa_id"], name: "index_msas_on_cbsa_id"
    t.index ["mdiv"], name: "index_msas_on_mdiv"
  end

  create_table "zip_codes", force: :cascade do |t|
    t.integer "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_zip_codes_on_code"
  end

end
