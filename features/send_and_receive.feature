Feature: The Cucumber interface allows messages to be sent and received

Scenario: A message is sent with a pub socket, and received with a sub socket
  Given publisher "my_publisher" sends the following: 
  |hello|world|

  Then I should receive a message on ZeroMQ with agent "my_subscriber" 
  And the ZeroMQ message should be:
  |hello|world|

  But I should not receive another message on ZeroMQ with agent "my_subscriber"
