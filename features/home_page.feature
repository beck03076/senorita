Feature: Goto Home Page
  In order to use favorito and find an users favorite programming language
  As a Visitor
  I want to visit the home page and see a search form

  Scenario: View Search Form
    Given I have started favorito app
    When I goto the homepage
    Then I should see the search form
