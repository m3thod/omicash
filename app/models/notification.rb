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
		account_sid = 'ACb7ab149eb0706c444c6fe00f688c45de'
		auth_token = '99090f489e89597e5f58cda4adee0bef'
		to_number = self.phone_number
		message_body = self.message_text

		# set up a client to talk to the Twilio REST API
		@client = Twilio::REST::Client.new account_sid, auth_token

		@client.account.messages.create({
			:from => '+16503810319',
			:to => to_number,
			:body => message_body,
		})
	end

end
