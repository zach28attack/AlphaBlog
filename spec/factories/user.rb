FactoryBot.define do 
  factory :user do
    username {"@testing"}
    email {"test@case.com"}
    password {"123456"}
  end
end