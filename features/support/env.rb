$: << File.expand_path("../../../lib", __FILE__)

require 'agent_zeromq/cucumber'

AgentZeroMQ.start
at_exit {
  AgentZeroMQ.stop
}
