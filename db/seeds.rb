# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'random_data'

# Create Users
5.times do
  User.create!(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    confirmed_at: Time.now.utc, #skip confirmation
  )
end

#Create a standard User
1.times do
  User.create!(
    email: Faker::Internet.email,
    password: 'password',
    confirmed_at: Time.now.utc, #skip confirmation
  )
end

# Create Wikis
50.times do
  Wiki.create!(
    title: Faker::Name.title,
    body: RandomData.random_paragraph
  )
end
wikis = Wiki.all

puts "Seed finished"
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"
