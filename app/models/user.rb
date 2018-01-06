class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :name
  has_many :restaurants, through: :comments
  has_many :comments, dependent: :restrict_with_error

  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  has_many :inverse_followships, class_name: "Followship", primary_key: "id", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :inverse_friendships, class_name: "Friendship", primary_key: "id", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  mount_uploader :avatar, AvatarUploader
  def admin?
    self.role == "admin"
  end
  def following?(user)
    self.followings.include?(user)
  end
  def friend?(user)
    self.friends.include?(user)
  end
  def all_friends
    self.friends | self.inverse_friends
  end
end
