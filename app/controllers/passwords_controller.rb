class PasswordsController < ApplicationController
  def new
    @user = current_user
  end
  def create
    @user = current_user
    @user.changing_password = true
    if @user.update(user_params)
      @user.change_password
      redirect_to root_url, notice:'Password changed successfully.'
    else
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:original_password, :new_password, :new_password_confirmation)
  end
end
