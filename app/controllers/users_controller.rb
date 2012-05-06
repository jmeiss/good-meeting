require 'google/api_client'

class UsersController < ApplicationController
  
  before_filter :authenticate_user!

  def my_account
    client = Google::APIClient.new
    client.authorization.client_id = current_user.google_token
    client.authorization.scope = 'https://www.googleapis.com/auth/calendar'
    client.authorization.access_token = current_user.google_token

    service = client.discovered_api('calendar', 'v3')
    parameters = {
      'calendarId'    => 'primary',
      'singleEvents'  => 'true',
      'timeMin'       => (Time.zone.now-3.days).iso8601.to_s,
      'timeMax'       => Time.zone.now.iso8601.to_s
    }
    result = client.execute(api_method: service.events.list, parameters: parameters)

    @events = result.data.items
  end

end
