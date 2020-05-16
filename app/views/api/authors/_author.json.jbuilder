json.extract! author, :id, :first_name, :last_name, :about_author, :created_at, :updated_at
json.url author_url(author, format: :json)
