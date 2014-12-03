class PasswordsController < ApplicationController
  def new
    @form = PasswordForm.new(current_user)
  end
  def create
    @form = PasswordForm.new(current_user)
    if @form.submit(form_params)
      redirect_to root_url, notice:'Password changed successfully.'
    else
      render 'new'
    end
  end

  private
  def form_params
    params.require(:password_form).permit(:original_password, :new_password, :new_password_confirmation)
  end
end
