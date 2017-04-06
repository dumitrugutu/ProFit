class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :workouts
  validates :full_name, presence: true

  self.per_page = 10

  def self.search_by_name(name)
    where('full_name LIKE ?', "%#{name}%")
  end
end
