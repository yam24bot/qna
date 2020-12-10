ActiveRecord::Schema.define(version: 2020_12_10_115743) do
  enable_extension "plpgsql"

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end
end
