require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should create carrot" do
    get settings_path
  end
end
