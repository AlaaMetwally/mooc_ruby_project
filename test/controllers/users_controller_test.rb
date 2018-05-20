require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def sign_in(user)
    post user_session_path \
      "MyString1"    => user.email,
      "MyString" => user.encrypted_password
  end
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count',0) do
      post users_url, params: { user: { date_of_birth: @user.date_of_birth, email: @user.email, gender: @user.gender, name: @user.name, password: @user.password, profile_picture: @user.profile_picture } }
    end
    auth_token = sign_in(@user)
    request.headers['HTTP_AUTHORIZATION'] = "JWT #{auth_token}" 
    get users_path, params: {}, headers: { HTTP_AUTHORIZATION: "JWT #{auth_token}" }
    assert_response :success
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { date_of_birth: @user.date_of_birth, email: @user.email, gender: @user.gender, name: @user.name, password: @user.password, profile_picture: @user.profile_picture } }
    assert_response :success
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
