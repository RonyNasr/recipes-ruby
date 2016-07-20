ENV['RACK_ENV'] = 'test'
require("rspec")
require("pg")
require("sinatra/activerecord")
require('ingredient')
require('recipe')
require('pry')

RSpec.configure do |config|
  config.after(:each) do
    Ingredient.all().each() do |this_ingredients|
      this_ingredients.destroy()
    end
    Recipe.all().each() do |this_recipes|
      this_recipes.destroy()
    end
  end
end
