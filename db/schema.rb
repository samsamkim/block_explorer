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

ActiveRecord::Schema[8.0].define(version: 2025_04_21_051658) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "transactions", force: :cascade do |t|
    t.string "tx_hash"
    t.string "block_hash"
    t.integer "block_height"
    t.string "sender"
    t.string "receiver"
    t.string "deposit"
    t.datetime "tx_time"
    t.jsonb "actions"
    t.string "gas_burnt"
    t.boolean "success"
    t.integer "action_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tx_hash"], name: "index_transactions_on_tx_hash", unique: true
  end
end
