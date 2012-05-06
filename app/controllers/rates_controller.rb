class RatesController < ApplicationController
  
  before_filter :authenticate_user!


  def create
    @rate = Rate.find_or_create_by_user_id_and_gcal_id(current_user.id, params[:rate][:gcal_id]) do |rate|
      rate.mark = params[:rate][:mark]
    end

    redirect_to event_path(@rate.gcal_id)
  end

end
