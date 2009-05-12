class User < ActiveRecord::Base
  
  acts_as_authentic do |c|
    # optional config block...
  end
  
end