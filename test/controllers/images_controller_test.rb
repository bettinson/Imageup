require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  include SessionsHelper

  setup do
    # Image is the model, picture is the actual file
    @user = users(:matt)
    @user.name = "Matt"
    @image = images(:one)

    @picture = fixture_file_upload('test/fixtures/files/test_image.png','application/png')
    @pdf = fixture_file_upload('test/fixtures/files/test_fail.pdf','application/pdf')
  end

  test "should get display" do
    get images_display_url(id: @image.id)
    assert_response :success
  end

  test "should get index" do
    get images_index_url
    assert_response :success
  end

  test "should get create page when logged in" do
    login
    get images_create_url
    assert_response :success
  end

  test "should redirect from create page when not logged in" do
    get images_create_url
    assert_redirected_to login_path
  end

  test "should upload image" do
    login
    assert_difference('Image.count') do
      post images_upload_url, params: { image: { title: 'Hey', picture: @picture } }
    end

    assert_redirected_to root_url
  end

  test "shouldn't upload image if not logged in" do
    assert_no_difference('Image.count') do
      post images_upload_url, params: { image: { title: 'Hey', picture: @picture } }
    end
  end

  test "should fail on invalid image" do
    login
    assert_no_difference('Image.count') do
      post images_upload_url, params: { image: { title: 'Hey', picture: @pdf } }
    end
  end

  test "shouldn't delete image if not on right account" do
    assert_no_difference('Image.count', -1) do
      delete images_url(id: @image.id)
    end
    assert_redirected_to login_path
  end

  test "should delete image if on right account" do
    login
    assert_difference('Image.count', -1) do
      # byebug
      delete images_url(id: @image.id)
    end

    assert_redirected_to images_index_url
  end

  private
  def login
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
  end
end
