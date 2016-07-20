class Ingredient < ActiveRecord::Base
  has_many :instructions
  has_many :recipes,  through: :instructions
end