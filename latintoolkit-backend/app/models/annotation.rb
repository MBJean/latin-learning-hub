class Annotation < ApplicationRecord
  belongs_to :line
  belongs_to :section
end
