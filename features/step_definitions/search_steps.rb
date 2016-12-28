When(/^wait for the results$/) do
  Rails.logger.debug 'Just waiting..'
end

Then(/^I should see a table of languages$/) do
  page.should have_css('table.search_results')
end

Then(/^the table should be sorted by no. of repositories$/) do
  # [1, "asdf", "11", 2, "sadf", "10", 3, "asdf", "2"]
  count_array = page.all('table.search_results tr td').map(&:text)
  expect(descending?(select_nth(count_array, 3).map(&:to_i))).to be_truthy
end
