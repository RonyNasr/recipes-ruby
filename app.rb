require('sinatra')
require('sinatra/reloader')
require("sinatra/activerecord")
also_reload('lib/**/*.rb')
require('./lib/recipe')
require('./lib/ingredient')
require('pg')

get('/') do
  erb(:index)
end

get('/recipes') do
  @recipes = Recipe.all()
  erb(:recipes)
end

get('/recipes/new') do
  @recipes = Recipe.all()

  erb(:new_recipe)
end

post('/recipes/new') do
  @recipe = Recipe.create(:name => params.fetch("name"), :instructions=> params.fetch("instructions"))
  @recipes = Recipe.all()
  erb(:recipes)
end

get ('/recipes/:id/ingredients') do
  @recipe = Recipe.find(params.fetch("id").to_i())

  erb(:ingredient_form)
end

post ('/recipes/:id/ingredients') do
  recipe = Recipe.find(params.fetch("id").to_i())
  recipe.ingredients.push(Ingredient.create({:name => params.fetch("name")}))

  redirect("/recipes/#{recipe.id().to_i()}/ingredients")
end

delete ('/recipes/:id/ingredients') do
  recipe = Recipe.find(params.fetch("id").to_i())
  recipe.destroy()

  redirect("/recipes")
end

get("/recipes/:recipe_id/ingredients/:id") do
  @ingredient = Ingredient.find(params.fetch("id").to_i())
  @recipe = Recipe.find(params.fetch("recipe_id").to_i)

  erb(:ingredients_edit)
end

patch ('/ingredients/:id') do
  ingredient = Ingredient.find(params.fetch("id").to_i())
  ingredient.update({:name => params.fetch("name") })
  recipe_id = params.fetch("recipe_id").to_i()
  redirect ("/recipes/#{recipe_id}/ingredients")
  end

delete '/ingredients/:id' do
  ingredient = Ingredient.find(params.fetch("id").to_i())
  ingredient.destroy()
  recipe_id = params.fetch("recipe_id").to_i()
  redirect ("/recipes/#{recipe_id}/ingredients")
end


get '/recipes/view' do
  redirect ('/recipes')
end

get '/recipes/view/:id/ingredients' do
    @recipe = Recipe.find(params.fetch("id").to_i())

    erb(:ingredients)
end
