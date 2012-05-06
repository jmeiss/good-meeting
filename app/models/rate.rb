class Rate < ActiveRecord::Base

  attr_accessible :gcal_id, :mark, :user_id

  belongs_to :user


end
