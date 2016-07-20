require('spec_helper')

describe(Recipe) do
  describe('#ingredients') do
    it "tells you the ingredients for the recipe" do
      test_recipe = Recipe.create({:name => "Onion Soup"})
      test_ingredient = Ingredient.create({:name => "Onions"})
      test_recipe.ingredients.push(test_ingredient)
      expect(test_recipe.ingredients()).to(eq([test_ingredient]))
    end
  end
end
