Factory.define :user do |f|
  f.sequence(:email) {|n| "person#{n}@example.com" }
  f.password "joga123"
  f.password_confirmation "joga123"
end
