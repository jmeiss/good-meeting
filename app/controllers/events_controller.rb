class EventsController < ApplicationController
  
  before_filter :authenticate_user!

  def show
    @event = Event.find params[:gcal_id], current_user.google_token
  end

end
