require('spec_helper')

describe(Recipe) do
  describe('#ingredients') do
    it "tells you the instructions for the recipe" do
      test_recipe = Recipe.create({:name => "Onion Soup"})
      test_ingredient = Ingredient.create({:name => "Onions"})
      test_instruction = Instruction.create(:name => "Onion Soup Instruction", :recipe_id => test_recipe.id(), :ingredient_id => test_ingredient.id, :ingredient_quantity => 2)
      expect(test_recipe.ingredients()).to(eq([test_ingredient]))
    end
  end
end
