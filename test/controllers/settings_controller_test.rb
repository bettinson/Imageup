require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:matt)
  end

  test "should create carrot" do
    login
    get settings_path
    assert_nothing_raised do
      post settings_queuepage_url, params: { body: "HTML + CRT goes here..." }
    end
  end

  private
  def login
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
  end
end
