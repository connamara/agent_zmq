Feature: The Cucumber interface allows message inspection

  Background:
    Given the following zeromq message: 
    |part 1| part 2 |
    |hello |world   |

  Scenario: Equivalence
    Then the zeromq message should be: 
    |part 1 | part 2|
    |hello  |world  |

    And the zeromq message should be: 
    |hello  |world  |

    But the zeromq message should not be:
    |goodbye|moon|

    And the zeromq message should not be:
    |hello|my|world|

  Scenario: The message parts can be checked
    Then the ZeroMQ message should have 2 parts
    And the ZeroMQ message should not have 1 part

  Scenario: Message part inspection
    Then part 1 of the ZeroMQ message should be "hello"
    And part 2 of the zeromq message should be:
    """
    world
    """

    But part 1 of the ZeroMQ message should not be "goodbye"
    And part 2 of the zeromq message should not be:
    """
    moon
    """
