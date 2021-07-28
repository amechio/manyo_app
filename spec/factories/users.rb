FactoryBot.define do
  factory :user do
    name { 'Factoryで作ったデフォルトの名前１' }
    email { 'factory1@mail.com' }
    password { 'factory1' }
    password_confirmation { 'factory1' }
    admin { true }
  end
  factory :user2, class: User do
    name { 'Factoryで作ったデフォルトの名前２' }
    email { 'factory2@mail.com' }
    password { 'factory2' }
    password_confirmation { 'factory2' }
    admin { false }
  end
  factory :user3, class: User do
    name { 'Factoryで作ったデフォルトの名前３' }
    email { 'factory3@mail.com' }
    password { 'factory3' }
    password_confirmation { 'factory3' }
    admin { false }
  end
end
