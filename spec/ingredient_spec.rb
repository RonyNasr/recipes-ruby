require('spec_helper')

describe(Ingredient) do
  it "belongs to many recipes" do
    test_recipe = Recipe.create({:name => 'Mac and Cheese'})
    test_ingredient = Ingredient.create({:name => 'cheese'})
    test_ingredient2 = Ingredient.create({:name => 'noodles'})
    test_recipe.ingredients.push(test_ingredient)
    test_recipe.ingredients.push(test_ingredient2)
    expect(test_recipe.ingredients()).to(eq([test_ingredient, test_ingredient2]))
  end
end
