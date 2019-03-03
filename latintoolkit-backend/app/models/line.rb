class Line < ApplicationRecord
  belongs_to :author
  belongs_to :text
  belongs_to :book, optional: true
  belongs_to :section, optional: true
  has_many :annotations
end
