class UsersController < ApplicationController
	def new
	end

	def create
		user = User.new(user_params)
		if user.save
			session[:user_id] = user.id
			redirect_to '/notifications'
		else
			redirect_to '/signup'
		end
	end

	def edit
	end

	def update
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
end
