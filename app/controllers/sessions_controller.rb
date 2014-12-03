class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      user.refresh_token!
      session[:token] = user.token
      redirect_to root_url, notice:'Log in successfully.'
    else
      flash.now[:error] = 'Invalid email or password.'
      render 'new'
    end
  end

  def destroy
    session[:token] = nil
    redirect_to root_url, notice:'Log out successfully.'
  end
end
