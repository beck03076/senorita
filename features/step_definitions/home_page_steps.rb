Given(/^I have started favorito app$/) {}

When(/^I goto the homepage$/) do
  visit '/'
end

Then(/^I should see the search form$/) do
  page.should have_css('div.search_form')
  page.should have_css('form#search')
  page.should have_css('input#search_username')
  page.should have_css('input.btn-danger')
end
