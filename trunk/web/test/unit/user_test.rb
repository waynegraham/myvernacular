require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "the flickr_username required validation" do
    u = User.create
    assert_equal "can't be blank", u.errors['flickr_username']
  end
  
  test 'that the samiam user has a building named "Building A"' do
    sam = users(:sam_iam)
    assert_equal 1, sam.buildings.size
    assert_equal 'Building A', sam.buildings.first.name
  end
  
  test "that the samiam user has building notes" do
    user = users(:sam_iam)
    assert_equal 1, user.building_notes.size
    assert_equal 'Some notes about this building from sam iam', user.building_notes.first.notes
  end
  
end