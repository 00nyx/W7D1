class UsersController < ApplicationController

  before_action :require_logged_in, only: [:index, :show]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      login(@user)
      # render :show
      redirect_to new_user_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
      # redirect_to new_user_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password, :session_token)
  end

end
