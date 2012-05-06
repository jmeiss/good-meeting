class Event

  attr_accessor :gcal_id


  def self.for_gcal_id_and_google_token gcal_id, google_token
    client = Google::APIClient.new
    client.authorization.access_token = google_token

    service = client.discovered_api('calendar', 'v3')
    parameters = {
      'calendarId'  => 'primary',
      'eventId'     => gcal_id
    }
    result = client.execute api_method: service.events.get, parameters: parameters

    result.data
  end

end
