#encoding: utf-8
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_invite
    make_users_with_problems
    make_filials
  end

  task filials: :environment do
    make_filials
  end

  def make_invite
    rc = Invite.create!( code: "qwerty" )
  end

  def make_users_with_problems
    admin = User.create!( login:                 "admin",
                          filial_id:             "1",
                          cabinet:               "29",
                          phone:                 "777-77777",
                          password:              "foobar",
                          password_confirmation: "foobar",
                          reg_code:              "qwerty",
                          name:                  "Администратор 9000" )
    admin.toggle!( :admin )

    15.times do |n|
      cabinet      = rand(1..99).to_s
      filial_id    = rand(1..5)
      name         = Faker::Name.first_name
      login        = name + rand(1..999).to_s
      password     = "password"
      phone        = Faker::PhoneNumber.cell_phone
      reg_code     = "qwerty"
      user_created = rand(1..99).days.ago
      name_full    = name + " " + Faker::Name.last_name
      user = User.create!(
                          cabinet:               cabinet,
                          filial_id:             filial_id,
                          login:                 login,
                          name:                  name_full,
                          password:              password,
                          password_confirmation: password,
                          phone:                 phone,
                          reg_code:              reg_code,
                          )
      user.created_at = rand(1..40).days.ago
      user.save
      2.times do |p|
        problems = user.problems.create!(
                                          admin_comment: Faker::Lorem.sentence(1),
                                          content:       Faker::Lorem.sentence(2),
                                          status_id:     rand(0..3)
                                         )
        problems.created_at = rand( 1..30 ).days.ago
        problems.save
      end
    end
  end

  def make_filials
    7.times do |f|
      Faker::Config.locale = 'ru'
      address              = Faker::Address.street_address
      name                 = Faker::Company.name
      phone                = Faker::PhoneNumber.cell_phone
      Filial.create!(name:    name,
                     address: address,
                     phone:   phone)
    end
  end

end


