FactoryGirl.define do
  sequence :email do |n|
    "example#{n.to_s}@example.com"
  end
  factory :user, class: 'User' do
    name { Faker::Name.name }
    email
    password { 'password' }
    trait :has_not_setup do
      name nil
    end
  end
end
