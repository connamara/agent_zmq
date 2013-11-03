Feature: The Cucumber interface allows message inspection

Scenario: A message is received

  Given publisher "my_publisher" sends the following: 
  |hello|world|

  Then I should receive a message on ZeroMQ with agent "my_subscriber" 
  And the ZeroMQ message should have 2 parts
  And part 1 of the ZeroMQ message should be "hello"
  And part 2 of the ZeroMQ message should be "world"

  But I should not receive another message on ZeroMQ with agent "my_subscriber"
