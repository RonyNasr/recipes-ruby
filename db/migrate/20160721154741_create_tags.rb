class CreateTags < ActiveRecord::Migration
  def change
    create_table(:tags) do |t|
      t.column(:name, :string)

      t.timestamps()
    end
    create_table(:recipes_tags) do |t|
      t.column(:recipe_id, :int)
      t.column(:tag_id, :int)

      t.timestamps()
    end
  end
end
