require 'test_helper'

class CephalopodsControllerTest < ActionController::TestCase
  setup do
    @cephalopod = cephalopods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cephalopods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cephalopod" do
    assert_difference('Cephalopod.count') do
      post :create, cephalopod: { name: @cephalopod.name, tentacles: @cephalopod.tentacles }
    end

    assert_redirected_to cephalopod_path(assigns(:cephalopod))
  end

  test "should show cephalopod" do
    get :show, id: @cephalopod
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cephalopod
    assert_response :success
  end

  test "should update cephalopod" do
    patch :update, id: @cephalopod, cephalopod: { name: @cephalopod.name, tentacles: @cephalopod.tentacles }
    assert_redirected_to cephalopod_path(assigns(:cephalopod))
  end

  test "should destroy cephalopod" do
    assert_difference('Cephalopod.count', -1) do
      delete :destroy, id: @cephalopod
    end

    assert_redirected_to cephalopods_path
  end
end
