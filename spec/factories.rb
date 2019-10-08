FactoryGirl.define do
  
  factory :report do
    glucose_level 150
  end

  factory :user do
    username 'test'
    password 'test@123'
    email 'test@abc.com'
    password_confirmation 'test@123'
    role 'patient'
  end

end