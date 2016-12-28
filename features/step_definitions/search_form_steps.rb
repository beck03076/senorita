Given(/^I am on the homepage$/) do
  visit '/'
end

Given(/^I fill in the form with "([^"]*)"$/) do |username|
  fill_in 'search_username', with: username
end

When(/^I press "([^"]*)"$/) do |arg|
  click_button(arg)
end

Then(/^I should see "([^"]*)"$/) do |arg1|
  page.should have_text(arg1)
end
