require 'test_helper'

class BuildingTest < ActiveSupport::TestCase
  
  test "validations" do
    b = Building.create
    assert_equal false, b.valid?
    errors = b.errors
    assert_equal 2, errors.size
    assert_equal "can't be blank", errors['name']
    assert_equal "can't be blank", errors['country']
  end
  
end