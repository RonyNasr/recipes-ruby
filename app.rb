require('sinatra')
require('sinatra/reloader')
require("sinatra/activerecord")
also_reload('lib/**/*.rb')
require('./lib/recipe')
require('./lib/ingredient')
require('./lib/tag')
require('pg')

get('/') do
  @recipes = Recipe.all().order('name ASC')
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
  redirect ('/recipes/new')
end

get ('/recipes/:id/ingredients') do
  @recipe = Recipe.find(params.fetch("id").to_i())
  @tags = Tag.all()

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


get ('/recipes/view') do
  redirect ('/recipes')
end

get ('/recipes/view/:id/ingredients') do
    @recipe = Recipe.find(params.fetch("id").to_i())

    erb(:ingredients)
end

get('/tag/new') do
  @tags = Tag.all()
  erb(:add_tag)
end

post('/tag/new') do
  name = params.fetch("name")
  @tag = Tag.create({:name => name})
  redirect('/tag/new')
end

get('/tag/:id/edit') do
  @tag = Tag.find(params.fetch("id").to_i())
  erb(:edit_tag)
end

delete('/tag/:id/edit') do
  tag = Tag.find(params.fetch("id").to_i())
  tag.destroy()
  redirect('/tag/new')
end

patch ('/recipes/:id/tags') do
  recipe = Recipe.find(params.fetch("id").to_i())
  recipe.tags.delete_all()
  if params.has_key?("tag_ids")
    params.fetch("tag_ids").each() do |tag_id|
      recipe.tags.push(Tag.find(tag_id.to_i()))
    end
  end
  redirect("/recipes/#{params.fetch("id").to_i()}/ingredients")
end
