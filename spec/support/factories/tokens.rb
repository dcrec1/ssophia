# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :token do |f|
  f.association :user
  f.value "MyString"
end
