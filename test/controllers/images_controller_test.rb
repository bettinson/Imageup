require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest

  setup do
    # Image is the model, picture is the actual file
    @image = images(:one)
    @picture = fixture_file_upload('test/fixtures/files/test_image.png','application/png')
    @pdf = fixture_file_upload('test/fixtures/files/test_fail.pdf','application/pdf')
  end

  def file_data(name)
    File.read(Rails.root.to_s + "/test/fixtures/files/#{name}")
  end

  test "should get display" do
    get images_display_url(id: @image.id)
    assert_response :success
  end

  test "should get index" do
    get images_index_url
    assert_response :success
  end

  test "should get create page" do
    get images_create_url
    assert_response :success
  end

  test "should upload image" do
    assert_difference('Image.count') do
      post images_upload_url, params: { image: { title: 'Hey', picture: @picture } }
    end

    assert_redirected_to images_index_url
  end

  test "should fail on invalid image" do
    assert_no_difference('Image.count') do
      post images_upload_url, params: { image: { title: 'Hey', picture: @pdf } }
    end
  end

  test "should delete image" do
    image = images(:one)

    assert_difference('Image.count', -1) do
      # byebug
      delete images_url(id: image.id)
    end
    assert_redirected_to images_index_url
  end
end
