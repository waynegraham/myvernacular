require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "the flickr_username required validation" do
    u = User.create
    assert_equal "can't be blank", u.errors['flickr_username']
  end
  
end