# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
authors = []
5.times do
  authors <<
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      about_author: Faker::Lorem.sentence(word_count: 20)
    }
end
Author.create(authors)
