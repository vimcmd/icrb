namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_invite
    make_users
    make_problems
  end

  def make_invite
    rc = Invite.create!( code: "qwerty" )
  end

  def make_users
    admin = User.create!( login:    "admin",
                          password: "foobar",
                          password_confirmation: "foobar",
                          reg_code: "qwerty" )
    admin.toggle!( :admin )

    30.times do |n|
      login  = Faker::Name.first_name + rand(1..9999).to_s
      password  = "password"
      reg_code = "qwerty"
      User.create!(login: login,
                   password: password,
                   password_confirmation: password,
                   reg_code: reg_code)
    end
  end

  def make_problems
    users = User.all(limit: 6)
    20.times do
      content = Faker::Lorem.sentence(2)
      comment = Faker::Lorem.sentence(1)
      users.each { |user| user.problems.create!(content: content, admin_comment: comment) }
    end
  end

end


