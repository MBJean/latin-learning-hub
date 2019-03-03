class Lesson < ApplicationRecord
  has_many :users, through: :lesson_activities
  has_many :skills, through: :lesson_levels
end
