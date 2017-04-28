# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require'random_data'

# Create Users
20.times do
  User.create!(
    email: RandomData.random_email,
    password: 'Helloworld',
    password_confirmation: 'Helloworld'
  )
end

# Create public Wikis
15.times do
  Wiki.create!(
    title: "Public #{RandomData.random_sentence}",
    body: RandomData.random_paragraph,
    private: false
  )
end

15.times do
  Wiki.create!(
    title: "Private #{RandomData.random_sentence}",
    body: RandomData.random_paragraph,
    private: true
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"