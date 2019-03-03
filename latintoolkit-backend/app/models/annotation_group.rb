class AnnotationGroup < ApplicationRecord
  belongs_to :section
  belongs_to :line
  has_many :annotations
end
