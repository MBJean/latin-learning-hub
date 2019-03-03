class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :lesson_activities
  has_many :lessons, through: :lesson_activities
  has_many :skill_activities
  has_many :skills, through: :skill_progresses
  has_many :vocabulary_books
  has_many :words, through: :vocabulary_books
  has_many :annotations
  has_and_belongs_to_many :classrooms
end
