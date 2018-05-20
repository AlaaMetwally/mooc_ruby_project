json.extract! lecture, :id, :content, :upload_file, :created_at, :updated_at
json.url lecture_url(lecture, format: :json)
