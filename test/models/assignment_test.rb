require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:role)
end
