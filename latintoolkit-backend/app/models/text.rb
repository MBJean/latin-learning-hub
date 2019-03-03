class Text < ApplicationRecord
  belongs_to :author
  has_many :books
  has_many :lines
end
