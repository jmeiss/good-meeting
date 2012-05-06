class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, 
         :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :google_token
  # attr_accessible :title, :body


  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.extra.raw_info
    
    if user = self.find_by_email(data.email)
      user
    else # Create a user with a stub password.
      self.create! :email => data.email, :google_token => access_token[:credentials][:token], :password => Devise.friendly_token[0,20]
    end
  end

end
