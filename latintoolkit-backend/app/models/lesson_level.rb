class LessonLevel < ApplicationRecord
  belongs_to :lesson
  belongs_to :skill
end
