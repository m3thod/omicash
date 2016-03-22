class Notification < ActiveRecord::Base
	belongs_to :user

	def self.send_notifications
		self.find_each do |notification|
			# check if needs to be sent
			now = DateTime.current
			30_ago = now - 30.minutes
			created = notification.created_at.utc
			if notification.is_active
				# notification is active
				if notification.last_sent
					# notification has already been sent once
					time_to_send = notification.last_sent + notification.frequency.hours
					notification.send if now >= time_to_send && 30_ago <= time_to_send
				else
					# notification hasn't been sent yet
					time_to_send = created + notification.frequency.hours
					notification.send if now >= time_to_send && 30_ago <= time_to_send
				end
				notification.last_sent = DateTime.current
			end
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
