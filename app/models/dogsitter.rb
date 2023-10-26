class Dogsitter < ApplicationRecord
  belongs_to :city
  has_many :strolls
end
