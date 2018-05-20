require 'test_helper'

class CoursesControllerTest < ActionDispatch::IntegrationTest
  
  def sign_in(user)
    post user_session_path \
      "MyString1"    => user.email,
      "MyString" => user.encrypted_password
  end

  setup do
    @user = users(:one)
    auth_token = sign_in(@user)
    request.headers['HTTP_AUTHORIZATION'] = "JWT #{auth_token}" 
   

    @course = courses(:one)
  end
  test "should get index" do
    get courses_url
    assert_response :success
  end

  test "should get new" do  
    get new_course_url
    auth_token = sign_in(@user)
    request.headers['HTTP_AUTHORIZATION'] = "JWT #{auth_token}" 
    get users_path, params: {}, headers: { HTTP_AUTHORIZATION: "JWT #{auth_token}" }
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count',0) do
      post courses_url, params: { course: { title: @course.title } }
    end
    auth_token = sign_in(@user)
    request.headers['HTTP_AUTHORIZATION'] = "JWT #{auth_token}" 
    get users_path, params: {}, headers: { HTTP_AUTHORIZATION: "JWT #{auth_token}" }
    assert_response :success
  end

  test "should show course" do
    get course_url(@course)
    assert_response :success
  end

  test "should get edit" do
    get edit_course_url(@course)
    auth_token = sign_in(@user)
    request.headers['HTTP_AUTHORIZATION'] = "JWT #{auth_token}" 
    get users_path, params: {}, headers: { HTTP_AUTHORIZATION: "JWT #{auth_token}" }
    assert_response :success
  end

  test "should update course" do
    patch course_url(@course), params: { course: { title: @course.title } }
    auth_token = sign_in(@user)
    request.headers['HTTP_AUTHORIZATION'] = "JWT #{auth_token}" 
    get users_path, params: {}, headers: { HTTP_AUTHORIZATION: "JWT #{auth_token}" }
    
    assert_response :success
  end

  test "should destroy course" do
    assert_difference('Course.count',0) do
      delete course_url(@course)
    end
    auth_token = sign_in(@user)
    request.headers['HTTP_AUTHORIZATION'] = "JWT #{auth_token}" 
    get users_path, params: {}, headers: { HTTP_AUTHORIZATION: "JWT #{auth_token}" }
    assert_response :success
  end
end
