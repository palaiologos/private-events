class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Private Events"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @user   		 = User.find(params[:id])
	  @events 		 = @user.created_events.paginate(page: params[:page]).order(created_at: :desc)
	  @attended_events = @user.attended_events.paginate(page: params[:page]).order(created_at: :desc)
	  @upcoming_events = @user.upcoming_events
	  @past_events     = @user.past_events
  end

  private

    def user_params
      params.require(:user).permit(:name, :email)
    end


end
