Feature: Login
  Background:
  Scenario: Default
    Given I am on the root page
    When I follow "Sign up"
    And I fill in "user_email" with "sofia@ssophia.com"
    And I fill in "user_password" with "abc123"
    And I fill in "user_password_confirmation" with "abc123"
    And I press "Sign up"
    Then I should be on "/"
    And I should see "Logout"

  Scenario: Comming from a third application
    When I visit "/users/sign_up?returnURL=/fake/path"
    And I fill in "user_email" with "sofia@ssophia.com"
    And I fill in "user_password" with "abc123"
    And I fill in "user_password_confirmation" with "abc123"
    And I press "Sign up"
    Then I should be on "/fake/path"
