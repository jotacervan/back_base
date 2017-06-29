require 'test_helper'

class TorcidasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get torcidas_index_url
    assert_response :success
  end

  test "should get new" do
    get torcidas_new_url
    assert_response :success
  end

  test "should get edit" do
    get torcidas_edit_url
    assert_response :success
  end

  test "should get show" do
    get torcidas_show_url
    assert_response :success
  end

  test "should get create" do
    get torcidas_create_url
    assert_response :success
  end

  test "should get update" do
    get torcidas_update_url
    assert_response :success
  end

  test "should get destroy" do
    get torcidas_destroy_url
    assert_response :success
  end

end
