class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
 devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :musics, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_books, through: :favorites, source: :book
  has_many :music_comments, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followings, through: :follower, source: :followed
  has_many :followers, through: :followed, source: :follower

  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy

  attachment :profile_image, destroy: false
  
 def already_favorite?(music)
    favorites.exists?(music_id: music.id)
  end

  def follow(other_user)
    unless self == other_user
      follower.create(followed_id: other_user.id)
    end
  end

  def unfollow(other_user)
    follower.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end



end
