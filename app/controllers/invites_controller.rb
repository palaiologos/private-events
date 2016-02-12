class InvitesController < ApplicationController
  before_action :correct_user , only: [ :create ]

  def create
	  @event = Event.find(params[:invite][:attended_event_id])
    current_user.invites.create(attended_event_id: @event.id)
	  redirect_to @event
  end

  def destroy
	  @invite = Invite.find(params[:id])
	  current_user.invites.destroy(@invite)
	  redirect_to :back
  end

  private

	  def correct_user
	    !current_user?(User.find(Event.find(params[:invite][:attended_event_id]).creator_id))
	  end

end
