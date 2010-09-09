# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :token do |f|
  f.user nil
  f.value "MyString"
end
