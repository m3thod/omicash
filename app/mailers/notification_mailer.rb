class NotificationMailer < ApplicationMailer
	default from: "notification@omicash.com"

	def notification_email(notification, user)
		@user = user
		@notification = notification
		mail(to: notification.email, subject: "You have a pending Venmo nofitication!")
	end

end
