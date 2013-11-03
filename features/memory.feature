Feature: Memory
  Background:
    Given the following zeromq message:
    |marco | polo | marco | polo | marco polo |

  Scenario: Single Message Part
    When I keep part 1 of the zeromq message as "foo"
    And I keep part 2 of the zeromq message as "bar"

    Then part 3 of the zeromq message should be "%{foo}"
    And part 4 of the zeromq message should not be "%{foo}"
    But part 5 of the zeromq message should be "%{foo} %{bar}"

    And the zeromq message should be:
    | marco | polo | %{foo} | %{bar} | %{foo} %{bar} |
