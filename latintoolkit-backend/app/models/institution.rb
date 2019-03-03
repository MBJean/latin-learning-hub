class Institution < ApplicationRecord
  has_many :classrooms
  has_many :users, through: :classrooms
end
