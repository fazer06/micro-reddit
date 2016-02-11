class User < ActiveRecord::Base

	validates :username, presence: true, length: { maximum: 25 }, 
			   uniqueness: true

	validates :email, presence: true, length: { maximum: 255 },
			   uniqueness: true
			   
	validates :password, presence: true, length: { minimum: 6 }

end
