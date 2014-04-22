agent\_zmq [![Build Status](https://travis-ci.org/connamara/agent_zmq.png?branch=master)](https://travis-ci.org/connamara/agent_zmq)
============

Agent framework designed for testing [ZeroMQ](http://zeromq.org/) Applications 

Usage
-----


### Agent Types

The agent types correspond to underlying ZMQ Socket type under test

#### ZMQ\_SUB

* Connects or Binds to local address
* Includes message caching for inspection

#### ZMQ\_PUB

* Connects or Binds to local address
* Publishes

#### ZMQ\_REQ

* Connects or Binds to local address
* Publishes request, returns response

#### ZMQ\_REP

* Connects or Binds to local address
* Listens for request, sends response

#### ZMQ\_DEALER

* Connects or Binds to local address
* Listens for requests, sends responses


### Configuration

Inside of your project, declare your agents inside of ```config/zmq_agents.rb``` like this:     

```ruby
require 'agent_zmq'

AgentZMQ.define_ZMQ_SUB :my_sub_agent do |a|
  a.socket_opts << {ZMQ::SUBSCRIBE=>'com.connamara.BODPosition'}
  a.end_point_type=:bind
  a.end_point='tcp://*:5556'
end

AgentZMQ.define_ZMQ_PUB :my_pub_agent do |a|
  a.end_point_type=:connect
  a.end_points=['tcp://127.0.0.1:5558', 'tcp://127.0.0.1:5559']
end

AgentZMQ.define_ZMQ_REQ :my_req_agent do |a|
  a.end_point_type=:connect
  a.end_point='tcp://127.0.0.1:5552'
end

AgentZMQ.define_ZMQ_REP :my_rep_agent do |a|
  a.reply = Proc.new {|msg| "ok"}
  a.end_point_type=:bind
  a.end_point='tcp://*:5552'
end
```

### Starting, Stopping and Resetting

```ruby
require 'agent_zmq'
AgentZMQ.start
at_exit { AgentZMQ.stop }
```

You may want to reset the agent states between tests without stopping and starting. This may be done with ```AgentZMQ.reset```

### Getting your agent

Grab the agent by the name given in the config file

```ruby
my_agent = AgentZMQ.agents_hash[:my_sub_agent]  
```

### Agent Interfaces


#### ZMQ\_SUB

This agent provides a message cache

```ruby
all_messages_received = my_sub_agent.messages_received

# returns and removes the last message received from the cache
last_message_received = my_sub_agent.pop
```

On `reset`, the sub agent cache is cleared
    
#### ZMQ\_PUB

The ```publish``` method takes a single message of one or more parts

```ruby
my_pub_agent.publish "single part message"
my_pub_agent.publish ["part 1", "part 2"]
```

#### ZMQ\_REQ

The ```publish``` method takes a single message of one or more parts. The agent blocks until a response is received and returned as an array of message parts

```ruby
response = my_req_agent.publish "single part message"
response = my_pub_agent.publish ["part 1", "part 2"]
```

#### ZMQ\_REP

Like the ZMQ_SUB agent, ZMQ_REP provides a message cache

```ruby
all_messages_received = my_rep_agent.messages_received

# returns and removes the last message received from the cache
last_message_received = my_rep_agent.pop
```

When receiving requests, the agent will reply with the output of the ```reply``` Proc.  The return value of this proc may be in the form of a multi-part message.

### Cucumber

There is some support for cucumber.  See [features](https://github.com/connamara/agent_zmq/blob/master/features) for example usage.

### Pairing with a Serialization Method

Once a message is captured, you may want to parse and inspect it some way. The message serialization technique is specific to the system being tested.  Some common serialization methods include JSON and Protocol Buffers.  [json\_spec](https://github.com/collectiveidea/json_spec) and [protobuf_spec](https://github.com/connamara/protobuf_spec) are two examples of testing libraries that can be easily paired with agent\_zmq for complete testing.

### More

Check out [specs](https://github.com/connamara/agent_zmq/blob/master/spec) and [features](https://github.com/connamara/agent_zmq/blob/master/features) to see all the ways you can use agent_zmq.

Install
-------

```shell
gem install agent_zmq
```

or add the following to Gemfile:
```ruby
gem 'agent_zmq'
```
and run `bundle install` from your shell.

More Information
----------------

* [Rubygems](https://rubygems.org/gems/agent_zmq)
* [Issues](https://github.com/connamara/agent_zmq/issues)
* [Connamara Systems](http://connamara.com)

Contributing
------------

Please see the [contribution guidelines](https://github.com/connamara/agent_zmq/blob/master/CONTRIBUTION_GUIDELINES.md).

Credits
-------

Contributers:

* Chris Busbey
* Brad Haan

![Connamara Systems](http://www.connamara.com/images/home-connamara-logo-lg.png)

agent_zmq is maintained and funded by [Connamara Systems, llc](http://connamara.com).

The names and logos for Connamara Systems are trademarks of Connamara Systems, llc.

Licensing
---------

agent_zmq is Copyright © 2013 Connamara Systems, llc. 

This software is available under the GPL and a commercial license.  Please see the [LICENSE](https://github.com/connamara/agent_zmq/blob/master/LICENSE.txt) file for the terms specified by the GPL license.  The commercial license offers more flexible licensing terms compared to the GPL, and includes support services.  [Contact us](mailto:info@connamara.com) for more information on the Connamara commercial license, what it enables, and how you can start developing with it.
