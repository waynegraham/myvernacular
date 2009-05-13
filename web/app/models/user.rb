class User < ActiveRecord::Base
  
  validates_presence_of :flickr_username
  
  # buildings this user has created
  has_many :buildings
  
  # *all* notes this user has created,
  # not just notes for the buildings this user has created
  has_many :building_notes
  
  acts_as_authentic do |c|
    # optional config block...
  end
  
end