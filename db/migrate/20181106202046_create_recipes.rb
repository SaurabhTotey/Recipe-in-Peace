class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string "name", null: false
      t.text "description", null: false
      t.string "ingredients", array: true, default: []
      t.text "steps", array: true, default: []
      t.string "utensils", array: true, default: []
      t.integer "minTime"
      t.integer "maxTime"
    end
  end
end
