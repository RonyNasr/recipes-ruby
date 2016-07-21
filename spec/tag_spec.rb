require('spec_helper')

describe(Tag) do
  it "belongs to many recipes" do
    test_recipe = Recipe.create({:name => 'Mac and Cheese'})
    test_tag = Tag.create({:name => 'mexican'})
    test_tag2 = Tag.create({:name => 'spicy'})
    test_recipe.tags.push(test_tag)
    test_recipe.tags.push(test_tag2)
    expect(test_recipe.tags()).to(eq([test_tag, test_tag2]))
  end
end
 
