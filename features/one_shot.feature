Feature: One-shot verification of AddressBook
  Launch ab-1.0.0.jar, and execute basic features verification.

  Scenario: Add/Search/Delete one entry
    Given I run `java -jar ../../target/ab-1.0.0.jar` interactively
    And the response should exactly contain "ab> "
    When I type "add"
    Then the response should contain "name:"
    And I type "xiaoming"
    Then the response should contain "mobile:"
    And I type "18888888888"
    Then the response should contain "address:"
    And I type "xiaoming jia"
    Then the response should contain "address entry added"
    When I type "search"
    Then the response should contain "by (name|mobile|address):"
    And I type "name"
    Then the response should contain "name:"
    And I type "xiaoming"
    Then the response should contain "xiaoming; 18888888888; xiaoming jia"
    When I type "search"
    Then the response should contain "by (name|mobile|address):"
    And I type "mobile"
    Then the response should contain "mobile:"
    And I type "188.*"
    Then the response should contain "xiaoming; 18888888888; xiaoming jia"
    When I type "search"
    Then the response should contain "by (name|mobile|address):"
    And I type "address"
    Then the response should contain "mobile:"
    And I type ".*jia"
    Then the response should contain "xiaoming; 18888888888; xiaoming jia"
    When I type "delete"
    Then the response should contain "by (name|mobile|address):"
    And I type "address"
    Then the response should contain "address:"
    And I type ".*jia"
    Then the response should contain "deleted"
    When I type "!quit"
    Then the exit status should be 0

  Scenario: Add/Search two entries
    Given I run `java -jar ../../target/ab-1.0.0.jar` interactively
    And the response should exactly contain "ab> "
    When I type "add"
    Then the response should contain "name:"
    And I type "xiaoming"
    Then the response should contain "mobile:"
    And I type "18888888888"
    Then the response should contain "address:"
    And I type "xiaoming jia"
    Then the response should contain "address entry added"
    When I type "add"
    Then the response should contain "name:"
    And I type "xiaohong"
    Then the response should contain "mobile:"
    And I type "18888888889"
    Then the response should contain "address:"
    And I type "xiaohong jia"
    Then the response should contain "address entry added"
    When I type "search"
    Then the response should contain "by (name|mobile|address):"
    And I type "name"
    Then the response should contain "name:"
    And I type "xiao.*"
    Then the response should match /xiaoming.*xiaohong/
    When I type "!quit"
    Then the exit status should be 0

  Scenario: Get help message and quit
    Given I run `java -jar ../../target/ab-1.0.0.jar` interactively
    And the response should exactly contain "ab> "
    When I type "!help"
    Then the response should contain "add|search|delete|!help|!quit"
    When I type "!invalid"
    Then the response should contain "add|search|delete|!help|!quit"
    When I type "!quit"
    Then the exit status should be 0
