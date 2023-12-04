FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{"#{n+1}".rjust(2, "0")}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
