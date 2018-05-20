require 'test_helper'

class LecturesControllerTest < ActionDispatch::IntegrationTest
  def sign_in(user)
    post user_session_path \
      "MyString1"    => user.email,
      "MyString" => user.encrypted_password
  end

  setup do
    @user = users(:one)
    auth_token = sign_in(@user)
    request.headers['HTTP_AUTHORIZATION'] = "JWT #{auth_token}" 
    @lecture = lectures(:one)
  end

  test "should get index" do
    get lectures_url
    assert_response :success
  end

  test "should get new" do
    get new_lecture_url
    auth_token = sign_in(@user)
    request.headers['HTTP_AUTHORIZATION'] = "JWT #{auth_token}" 
    get users_path, params: {}, headers: { HTTP_AUTHORIZATION: "JWT #{auth_token}" }
    assert_response :success
  end

  test "should create lecture" do
    assert_difference('Lecture.count',0) do
      post lectures_url, params: { lecture: { content: @lecture.content, upload_file: @lecture.upload_file } }
    end

    auth_token = sign_in(@user)
    request.headers['HTTP_AUTHORIZATION'] = "JWT #{auth_token}" 
    get users_path, params: {}, headers: { HTTP_AUTHORIZATION: "JWT #{auth_token}" }
    assert_response :success
  end

  test "should show lecture" do
    get lecture_url(@lecture)
    assert_response :success
  end

  test "should get edit" do
    get edit_lecture_url(@lecture)
    auth_token = sign_in(@user)
    request.headers['HTTP_AUTHORIZATION'] = "JWT #{auth_token}" 
    get users_path, params: {}, headers: { HTTP_AUTHORIZATION: "JWT #{auth_token}" }
    assert_response :success
  end

  test "should update lecture" do
    patch lecture_url(@lecture), params: { lecture: { content: @lecture.content, upload_file: @lecture.upload_file } }
    auth_token = sign_in(@user)
    request.headers['HTTP_AUTHORIZATION'] = "JWT #{auth_token}" 
    get users_path, params: {}, headers: { HTTP_AUTHORIZATION: "JWT #{auth_token}" }
    assert_response :success
  end

  test "should destroy lecture" do
    assert_difference('Lecture.count', 0) do
      delete lecture_url(@lecture)
    end
    auth_token = sign_in(@user)
    request.headers['HTTP_AUTHORIZATION'] = "JWT #{auth_token}" 
    get users_path, params: {}, headers: { HTTP_AUTHORIZATION: "JWT #{auth_token}" }
    assert_response :success
  end
end
