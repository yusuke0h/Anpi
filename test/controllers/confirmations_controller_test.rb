require 'test_helper'

class ConfirmationsControllerTest < ActionController::TestCase
  test "should get index_for_admin" do
    get :index_for_admin
    assert_response :success
  end

  test "should get index_for_user" do
    get :index_for_user
    assert_response :success
  end

  test "should get auto_create" do
    get :auto_create
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

end
