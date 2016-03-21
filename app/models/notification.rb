class Notification < ActiveRecord::Base
	belongs_to :user

	def self.send_notifications
		self.find_each do |notification|
			# do stuff here
			# check if needs to be sent
			notification.send
		end
	end

	def send
		#make api calls
	end

end
