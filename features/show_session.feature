Feature: Show session
  Scenario: Default
    Given I am a new, authenticated user
    When I request my session
    Then I should receive "200" as the status code
