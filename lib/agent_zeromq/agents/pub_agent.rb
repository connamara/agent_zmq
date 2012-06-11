require 'agent_zeromq/agents/base_agent'

class AgentZeroMQ::PubAgent
  include AgentZeroMQ::BaseAgent

  def initialize name
    @name=name
    @socket_opts=[]
  end

  def sock_type
    zmq_context.socket(ZMQ::PUB)
  end

  def start
    zmq_socket
    sleep 0.8 # slow joiner
  end

  def stop
    zmq_socket.close
  end

  def publish msg
    AgentZeroMQ::Helpers.publish zmq_socket, msg
  end

  def reset

  end
end
