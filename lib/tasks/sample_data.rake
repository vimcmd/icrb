# namespace :db do
#   desc "Fill database with sample data"
#   task populate: :environment do
#     admin = User.create!( login:    "admin",
#                           password: "123qwe",
#                           password_confirmation: "123qwe" )
#     admin.toggle!( :admin )

#     User.create!(login: "Example User",
#                  password: "foobar",
#                  password_confirmation: "foobar")
#     30.times do |n|
#       name  = Faker::Name.name
#       email = "example-#{n+1}@railstutorial.org"
#       password  = "password"
#       User.create!(name: name,
#                    email: email,
#                    password: password,
#                    password_confirmation: password)
#     end
#   end
# end


