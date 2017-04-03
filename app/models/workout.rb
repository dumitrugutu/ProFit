class Workout < ApplicationRecord
  belongs_to :user

  alias_attribute :workout_details, :workout_type
  alias_attribute :activity_date, :date

  validates :duration, numericality: { greater_than: 0.0 }
  validates :workout_details, presence: true
  validates :activity_date, presence: true
end
