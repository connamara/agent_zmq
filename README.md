agent_zeromq
============

Agent framework designed for testing ZeroMQ Applications 

Usage
-----

Inside of your project, declare your agents inside of ```config/zmq_agents.rb``` like this:     

```ruby
require 'agent_zeromq'

AgentZeroMQ.define_agent "my_agent" do |a|
  a.end_point='tcp://*:5556'
  a.filter='com.connamara.BODPosition'
end
```

### Starting and Stopping

```ruby
require 'agent_zeromq'
AgentZeroMQ.start
at_exit { AgentZeroMQ.stop }
```

