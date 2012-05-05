class UsersController < ApplicationController

  def my_account
    @events = current_user.gcal_events
  end

end
