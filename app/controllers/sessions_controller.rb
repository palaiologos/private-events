class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user
      log_in @user
      flash[:success] = "Welcome"
      redirect_to root_url
    else
      flash.now[:warning] = "Incorrect User"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
