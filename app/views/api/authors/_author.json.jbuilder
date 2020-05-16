# app/views/api/authors/_author.json.jbuilder

#json.extract! author, :id, :first_name, :last_name, :about_author, :created_at, :updated_at
#json.url author_url(author, format: :json)

json.extract! author, :id, :first_name, :last_name
json.short_name author.short_name
