require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest

  setup do
    @image = images(:one)
  end

  test "should get display" do
    get images_display_url(id: @image.id)
    assert_response :success
  end

  test "should get index" do
    get images_index_url
    assert_response :success
  end

  test "should get upload" do
    get images_upload_url
    assert_response :success
  end

  test "should upload image" do
    assert_difference('Image.count') do
      post images_create_url, params: { image: { title: 'Hey'} }
    end

    assert_redirected_to images_index_url
  end
end
