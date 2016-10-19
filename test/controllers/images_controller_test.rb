require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest

  setup do
    # Image is the model, picture is the actual file
    @image = images(:one)
    @picture = fixture_file_upload('test/fixtures/files/test_image.png','application/png')
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

  test "should get create pages" do
    get images_create_url
    assert_response :success
  end

  test "should upload image" do
    assert_difference('Image.count') do
      post images_upload_url, params: { image: { title: 'Hey', picture: @picture } }
    end

    assert_redirected_to images_index_url
  end
end
