class Rate < ActiveRecord::Base

  attr_accessible :gcal_id, :mark, :user_id

  belongs_to :user


  def self.for_email_and_gcal_id email, gcal_id
    Rate.joins(:user).where(:gcal_id => gcal_id, users: {email: email}).first
  end

  def self.roti_for_gcal_id gcal_id
    Rate.where(:gcal_id => gcal_id).average('mark')
  end

end
