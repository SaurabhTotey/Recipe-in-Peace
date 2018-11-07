json.extract! recipe, :id, :name, :imageURL, :description, :ingredients, :steps, :utensils, :minTime, :maxTime, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
