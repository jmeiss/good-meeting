class UsersController < ApplicationController
  
  require 'google/api_client'

  def my_account
    return unless current_user

    client = Google::APIClient.new
    client.authorization.client_id = current_user.google_token

    client.authorization.scope = 'https://www.googleapis.com/auth/calendar'
    client.authorization.access_token = current_user.google_token

    service = client.discovered_api('calendar', 'v3')
    result = client.execute(:api_method => service.calendar_list.list)

    result.data.items.each do |calendar|
      return @calendar = calendar if calendar['id'] == current_user.email
    end
  end

end
