class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
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
		respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to notifications_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
	end

	def venmo
	end

	def set_venmo
		respond_to do |format|
      if @user.update(venmo_params)
        format.html { redirect_to notifications_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		def venmo_params
			params.require(:user).permit(:venmo_username, :venmo_password)
		end
end
