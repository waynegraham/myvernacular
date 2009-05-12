class User < ActiveRecord::Base
  
  validates_presence_of :flickr_username
  
  acts_as_authentic do |c|
    # optional config block...
  end
  
end