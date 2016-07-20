class DroppingQuantity < ActiveRecord::Migration
  def change
    remove_column(:ingredients_recipes , :quantity)
  end
end
