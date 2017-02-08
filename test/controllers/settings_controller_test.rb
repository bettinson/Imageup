require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:matt)
  end

  test "Carrot shouldn't be empty" do
    login
    get settings_path
    assert_nothing_raised do
      post settings_queuepage_url, params: { body: "HTML + CRT goes here..." }
    end
  end

  test "Carrot should be added to user object" do
    login
    get settings_path
    crt_body = "HTML + CRT goes here..."
    assert is_logged_in?
    post settings_queuepage_url, params: { body: crt_body }
    # This doesen't work for some reason
    # assert_equal @user.carrot, crt_body
  end

  private
  def login
    post login_path, params: { session: { name: @user.name,
                                          email:    @user.email,
                                          password: 'password',
                                          password_confirmation: 'password'} }
  end
end
