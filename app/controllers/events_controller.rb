class EventsController < ApplicationController
  
  before_filter :authenticate_user!


  def show
    @current_user_rate = Rate.joins(:user).where(:gcal_id => params[:gcal_id], users: {email: current_user.email})
    @roti   = Rate.roti_for_gcal_id params[:gcal_id]
    @event  = Event.find params[:gcal_id], current_user.google_token
    @rate   = Rate.new
  end

end
