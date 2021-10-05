FactoryBot.define do
  factory :closecontact do
    firstname { "MyString" }
    secondname { "MyString" }
    telephone { "MyString" }
    email { "MyString" }
    regular { false }
    user {User.new}
  end
end
