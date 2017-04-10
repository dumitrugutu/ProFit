class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :workouts
  has_many :friendships
  has_many :friends, through: :friendships, class_name: "User"

  validates :full_name, presence: true

  self.per_page = 10

  def self.search_by_name(name)
    where('full_name LIKE ?', "%#{name}%")
  end

  def follows_or_same?(new_friend)
    friendships.map(&:friend).include?(new_friend) || self == new_friend
  end

  def current_friendship(friend)
    friendships.where(friend_id: friend.id).first
  end
end
