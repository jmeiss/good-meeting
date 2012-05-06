class EventsController < ApplicationController
  
  before_filter :authenticate_user!


  def show
    @current_user_rate = Rate.joins(:user).where(:gcal_id => params[:gcal_id], users: {email: current_user.email})
    @event  = Event.for_gcal_id_and_google_token params[:gcal_id], current_user.google_token
    @roti   = Rate.roti_for_gcal_id params[:gcal_id]
    @rate   = Rate.new
  end

end
