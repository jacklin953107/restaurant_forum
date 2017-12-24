namespace :dev do
  task fake_restaurant: :environment do
    Restaurant.destroy_all

    50.times do |i|
      Restaurant.create!(name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample,
        image: File.open(File.join(Rails.root,"/public/seed_img/#{rand(0..7)}.jpg")),
      )
    end
    puts "have created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"
  end

  task fake_user: :environment do
    User.destroy_all
    User.create(email: "root@admin.com", password: "12345678", role: "admin")
    10.times do |i|
      User.create!(email: FFaker::Internet.email, password: FFaker::Internet.password)
    end
    puts "Default admin and fake user created!"
  end

  task fake_comment: :environment do
    Comment.destroy_all
    Restaurant.all.each do |restaurant|
      3.times do |i|
        restaurant.comments.create!(
          content: FFaker::Lorem.sentence,
          user: User.all.sample
        )
      end
    end
    puts "have created fake comments"
    puts "now you #{Comment.count} comment data"
  end
end
