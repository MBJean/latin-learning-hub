class Section < ApplicationRecord
  belongs_to :book
  has_many :lines
  has_many :annotations
end
