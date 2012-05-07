class UsersController < ApplicationController
  
  before_filter :authenticate_user!

  def my_account
    @events = current_user.gcal_events
  end

end
