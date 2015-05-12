class User < ActiveRecord::Base
	has_many :chirps, dependent: :destroy
    validates :password, confirmation: true
    validates_uniqueness_of :email, :username, case_sensitive: false
    validates_presence_of :username, :email, :password, :lname, :fname
    validates :password, presence: true, on: :create
    validates :password_confirmation, presence: true, on: :create
    validates :username, format: { with:/\A\w+\z/, message: "Only letters, number, and underscore allowed" }

    def self.find_by_email(email)
    	User.where("email = lower(?)", email).first
    end

    def self.find_by_username(username)
    	User.where("username = lower(?)", username).first
    end
end
