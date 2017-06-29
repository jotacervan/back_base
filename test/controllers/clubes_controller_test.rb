require 'test_helper'

class ClubesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get clubes_index_url
    assert_response :success
  end

  test "should get new" do
    get clubes_new_url
    assert_response :success
  end

  test "should get edit" do
    get clubes_edit_url
    assert_response :success
  end

  test "should get show" do
    get clubes_show_url
    assert_response :success
  end

  test "should get create" do
    get clubes_create_url
    assert_response :success
  end

  test "should get update" do
    get clubes_update_url
    assert_response :success
  end

  test "should get destroy" do
    get clubes_destroy_url
    assert_response :success
  end

end
