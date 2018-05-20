require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:valid)
  end
  test 'valid user' do
    user = User.new(name: 'MyString', email: 'mystring@gmail.com', gender: 'Female',password: "MyString")
    assert user.valid? 
  end

  test 'invalid without name' do
    user = User.new(email: 'MyString1')
    refute user.valid?, 'user is valid without a name'
    assert_not_nil user.errors[:name], 'no validation error for name present'
  end

  test 'invalid without email' do
    user = User.new(name: 'MyString')
    refute user.valid?
    assert_not_nil user.errors[:email]
  end
  test '#lectures' do
  assert_equal 2, @user.lectures.size
end
test '#recent' do
  assert_includes User.recent, users(:valid)
  refute_includes User.recent, users(:old)
end
end
