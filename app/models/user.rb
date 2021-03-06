class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  
  has_many :microposts
  
  has_many :following_relationships, class_name: "Relationship",
                                     foreign_key: "follower_id", 
                                     dependent: :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  
  has_many :followed_relationships, class_name: "Relationship",
                                    foreign_key: "followed_id", 
                                    dependent: :destroy
  has_many :followed_users, through: :followed_relationships, source: :follower
  
  has_many :favoriteships,  class_name: "Favoriteship",
                            foreign_key: "user_id", 
                            dependent: :destroy
  has_many :favorited_posts, through: :favoriteships, source: :micropost
  
  mount_uploader :avatar, AvatarUploader
  
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, 
    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    
  def follow(other_user)
    following_relationships.create(followed_id: other_user.id)
  end
  
  def unfollow(other_user)
    following_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  def following?(other_user)
    following_users.include?(other_user)
  end
  
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
  
  def favo(micropost)
    favoriteships.find_or_create_by(micropost_id: micropost.id)
  end
  
  def unfavo(micropost)
    favoriteships.find_by(micropost_id: micropost.id).destroy
  end
  
  def favo?(micropost)
    favorited_posts.include?(micropost)
  end
  
  has_secure_password
end
