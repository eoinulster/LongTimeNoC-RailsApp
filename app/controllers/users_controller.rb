class UsersController < ApplicationController
  def show
    render :show
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # Uncomment these lines to enable the email activation flow
      #-------------------------------------------------------------------------
      #ApplicationMailer.activation_email(@user).deliver_now!
      #flash[:notice] = 'Successfully created your account! Check your inbox for an activation email.'
      #redirect_to new_session_url
      #-------------------------------------------------------------------------

      # And remove these lines
      #---------------------
      #e @user.activate!
      login_user!(@user)
      redirect_to user_events_url(@user.id)
      #---------------------
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  #e def activate
  #   @user = User.find_by(activation_token: params[:activation_token])
  #   @user.activate!
  #   login_user!(@user)
  #   flash[:notice] = 'Successfully activated your account!'
  #   redirect_to root_url
  #e end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
