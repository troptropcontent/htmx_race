# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
DEFAULT_PASSWORD = "test123".freeze


User.destroy_all
Race.destroy_all

main_user = User.create(email: "tom@example.com", password: DEFAULT_PASSWORD)
10.times do |n|
    user_number = (n+1).to_s.rjust(2, "0")
    User.create(email: "user#{user_number}@example.com", password: DEFAULT_PASSWORD)
end

5.times do |n|
    race_name ="Course " + "#{n+1}".rjust(2, "0")
    race = main_user.owned_races.create(name: race_name)
    User.where.not(id: race.owners.ids).all.sample(rand(1..4)).each do |user|
        race.participants.create(user: user)
    end
end