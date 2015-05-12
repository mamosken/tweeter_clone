class User < ActiveRecord::Base
    has_many :chirps, dependent: :destroy
    has_many :active_relationships, class_name: "Relationship",
                              foreign_key: :follower_id, 
                              dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                               foreign_key: :followed_id, 
                               dependent: :destroy
  has_many :following, through: :active_relationships,  source: :followed # User.first.following
  has_many :followers, through: :passive_relationships, source: :follower # User.first.followers
  
    validates :password, confirmation: true
    validates_uniqueness_of :email, :username, case_sensitive: false
    validates_presence_of :username, :email, :password, :lname, :fname
    validates :password, presence: true, on: :create
    validates :password_confirmation, presence: true, on: :create
    validates :username, format: { with:/\A\w+\z/, message: "Only letters, number, and underscore allowed" }
    has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "40x40>" }, :default_url => "/images/:style/img.png"
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

    def self.find_by_email(email)
      User.where("lower(email) = ?", email.downcase).first
    end

    def self.find_by_username(username)
      User.where("lower(username) = ?", username.downcase).first
    end
    
    # def self.lower_case_username(username)
    #     result = User.all.map do |user|
    #         user.username.downcase == username.downcase ? user : nil
    #     end
    #     result.compact.first
    # end

    # def self.lower_case_email(email)
    #     result = User.all.map do |user|
    #         user.email.downcase == email.downcase ? user : nil
    #     end
    #     result.compact.first
    # end


end

