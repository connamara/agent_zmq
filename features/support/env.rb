$: << File.expand_path("../../../lib", __FILE__)

require 'agent_zmq/cucumber'

AgentZMQ.start
at_exit {
  AgentZMQ.stop
}
