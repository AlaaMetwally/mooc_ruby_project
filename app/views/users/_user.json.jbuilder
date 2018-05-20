json.extract! user, :id, :name, :email, :password, :date_of_birth, :gender, :profile_picture, :created_at, :updated_at
json.url user_url(user, format: :json)
