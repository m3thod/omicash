class User < ActiveRecord::Base
	has_secure_password
	# validates :name, :email
	has_many :notifications
end
