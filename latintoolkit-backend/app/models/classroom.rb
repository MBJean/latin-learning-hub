class Classroom < ApplicationRecord
  belongs_to :institution
  has_and_belongs_to_many :users
end
