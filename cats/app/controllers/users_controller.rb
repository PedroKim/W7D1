class UsersController < ApplicationController
    # before_action :require_current_user!, except: [:create, :new]
    before_action :exists_current_user!, only: [:create, :new]


    def new
      @user = User.new
      render :new
    end

    def create
      @user = User.new(users_params)

      if @user.save!
        login!(@user)
        redirect_to cats_url
      else
        flash.now[:errors] = @user.errors.full_messages
        render :new, status: 422
      end
    end

    private
    def users_params
      params.require(:user).permit(:user_name, :password)
    end
end