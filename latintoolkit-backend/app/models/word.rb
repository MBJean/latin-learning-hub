class Word < ApplicationRecord
  has_many :users, through: :vocabulary_books
end
