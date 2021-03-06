Feature: Login
  Background:
    Given an user exists with email: "sofia@ssophia.com", password: "abc123", password_confirmation: "abc123"

  Scenario: Default
    Given I am on the root page
    When I follow "Login"
    And I fill in "user_email" with "sofia@ssophia.com"
    And I fill in "user_password" with "abc123"
    And I press "Sign in"
    Then I should be on "/"
    And I should see "Logout"

  Scenario: Comming from a third application
    When I visit "/users/sign_in?returnURL=/fake/path"
    And I fill in "user_email" with "sofia@ssophia.com"
    And I fill in "user_password" with "abc123"
    And I press "Sign in"
    Then I should be on "/fake/path"
