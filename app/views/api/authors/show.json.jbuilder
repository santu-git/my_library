# app/views/api/authors/show.json.jbuilder

#json.partial! "author", author: @author

json.extract! @author, :id, :first_name, :last_name, :about_author
json.short_name @author.short_name
