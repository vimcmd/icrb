namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_invite
    make_users
    make_problems
    make_filials
  end

  task filials: :environment do
    make_filials
  end

  def make_invite
    rc = Invite.create!( code: "qwerty" )
  end

  def make_users
    admin = User.create!( login:    "admin",
                          filial_id: "1",
                          cabinet: "29",
                          phone: "777-77777",
                          password: "foobar",
                          password_confirmation: "foobar",
                          reg_code: "qwerty" )
    admin.toggle!( :admin )

    15.times do |n|
      login  = Faker::Name.first_name + rand(1..999).to_s
      filial_id = rand(1..5)
      cabinet = rand(1..99).to_s
      phone = Faker::PhoneNumber.cell_phone
      password  = "password"
      reg_code = "qwerty"
      User.create!(login: login,
                   filial_id: filial_id,
                   cabinet: cabinet,
                   phone: phone,
                   password: password,
                   password_confirmation: password,
                   reg_code: reg_code)
    end
  end

  def make_filials
    5.times do |f|
      Faker::Config.locale = 'ru'
      name = Faker::Company.name
      address = Faker::Address.street_address
      phone = Faker::PhoneNumber.cell_phone
      Filial.create!(name: name,
                     address: address,
                     phone: phone)
    end
  end

  def make_problems
    3.times do
      users = User.all(limit: 10)
      status_id = rand(0..2)
      content = Faker::Lorem.sentence(2)
      comment = Faker::Lorem.sentence(1)
      users.each { |user| user.problems.create!(content: content,
                                                admin_comment: comment,
                                                status_id: status_id) }
    end
  end

end


