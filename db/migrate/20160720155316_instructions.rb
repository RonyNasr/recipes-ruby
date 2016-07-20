class Instructions < ActiveRecord::Migration
  def change
    create_table(:instructions) do |t|
      t.column(:name, :string)
      t.column(:recipe_id, :int)
      t.column(:ingredient_id, :int)
      t.column(:ingredient_quantity, :int)
    end
  end
end
