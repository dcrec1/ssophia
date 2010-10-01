When /^I visit "(.*)"$/ do |url|
  visit url
end

When /^I request my session$/ do
  visit "/sessions/#{Session.last.session_id}.json"
end

Then /^I should receive "([^"]*)" as the status code$/ do |status|
  page.status_code.should == status.to_i
end
