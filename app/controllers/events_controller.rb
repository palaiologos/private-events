class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def create
    @event = current_user.created_events.build(user_params)
    if @event.save
      flash.now[:success] = "Created"
      render 'show'
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
    @attendees = @event.attendees.paginate(page: params[:page]).order(created_at: :desc)
  end

  def index
    @events = Event.paginate(page: params[:page]).order(created_at: :desc)
  end

  private

    def event_params
      params.require(:event).permit(:title, :description, :date, :location)
    end
end
