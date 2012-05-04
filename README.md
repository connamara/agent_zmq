agent_zeromq
============

Agent framework designed for testing ZeroMQ Applications 


Agent Types
-----------

The agent types correspond to underlying ZMQ Socket type under test

### ZMQ_SUB

* Connects or Binds to local address
* Includes message caching for inspection

### ZMQ_PUB

* Connects or Binds to local address
* Publishes


Usage
-----

### Configuration

Inside of your project, declare your agents inside of ```config/zmq_agents.rb``` like this:     

```ruby
require 'agent_zeromq'

AgentZeroMQ.define_ZMQ_SUB :my_sub_agent do |a|
  a.socket_opts << {ZMQ::SUBSCRIBE=>'com.connamara.BODPosition'}
  a.end_point_type=:bind
  a.end_point='tcp://*:5556'
end

AgentZeroMQ.define_ZMQ_PUB :my_pub_agent do |a|
  a.end_point_type=:connect
  a.end_point='tcp://127.0.0.1:5558'
end
```

### Starting, Stopping and Resetting

```ruby
require 'agent_zeromq'
AgentZeroMQ.start
at_exit { AgentZeroMQ.stop }
```

You may want to reset the agent states between tests without stopping and starting. This may be done with ```AgentZeroMQ.reset```

### Getting your agent

Grab the agent by the name given in the config file

```ruby
my_agent = AgentZeroMQ.agents_hash[:my_sub_agent]  
```

### Agent Interfaces


#### ZMQ_SUB

This agent provides a message cache

```ruby
all_messages_received = my_sub_agent.messages_received

# returns and removes the last message received from the cache
last_message_received = my_sub_agent.pop
```

On `reset`, the sub agent cache is cleared
    
#### ZMQ_PUB

The ```publish``` method takes a single message of one or more parts

```ruby
my_pub_agent.publish "single part message"
my_pub_agent.publish ["part 1", "part 2"]
```
