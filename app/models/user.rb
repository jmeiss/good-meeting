require 'google/api_client'

class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :recoverable, 
         :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :google_token

  has_many :rates, dependent: :delete_all
  

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    
    if user = self.find_by_email(data.email)
      user
    else # Create a user with a stub password.
      self.create! :email => data.email, :google_token => access_token[:credentials][:token], :password => Devise.friendly_token[0,20]
    end
  end

  def gcal_events
    client = Google::APIClient.new
    client.authorization.access_token = self.google_token

    service = client.discovered_api('calendar', 'v3')
    parameters = {
      'calendarId'    => 'primary',
      'orderBy'       => 'startTime',
      'singleEvents'  => 'true',
      'timeMin'       => (Time.zone.now-3.days).iso8601.to_s,
      'timeMax'       => Time.zone.now.iso8601.to_s
    }

    result = client.execute api_method: service.events.list, parameters: parameters

    p "=================== result.data"
    p result.data
    p "=================== result.data.items"
    p result.data.items
    
    events = result.data.items
    events.sort_by!{|e| (e['end']['dateTime'] || e['end']['date'])}.reverse!
  end

end
