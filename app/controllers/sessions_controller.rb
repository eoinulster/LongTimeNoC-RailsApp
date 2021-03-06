class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if user.nil?
      flash.now[:errors] = ["Invalid credentials."]
      render :new

    # Notice we have User#activated? even though we didn't define it!
    # Rails gives you this method for free because it matches a column name.

    # should always be truty as i set a default value?
    elsif !user.activated?
      flash.now[:errors] = ['You must activate your account first! Check your email.']
      render :new
    else
      login_user!(user)
      redirect_to user_events_url(user)
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil

    redirect_to new_session_url
  end
end
