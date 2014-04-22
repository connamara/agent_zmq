Feature: The Cucumber interface allows messages to be sent and received

Scenario: A message is sent with a pub socket, and received with a sub socket
  Given the following ZeroMQ message:
  |hello|world|

  When I publish the ZeroMQ message with agent "my_publisher"

  Then I should receive a message on ZeroMQ with agent "my_subscriber" 
  And the ZeroMQ message should be:
  |hello|world|

  But I should not receive another message on ZeroMQ with agent "my_subscriber"

  Given I set part 1 of the ZeroMQ message to "goodbye"
  And I set part 2 of the ZeroMQ message to "moon"
  When I publish the ZeroMQ message with agent "my_publisher"

  Then I should receive a message on ZeroMQ with agent "my_subscriber" 
  And the ZeroMQ message should be:
  |goodbye|moon|
