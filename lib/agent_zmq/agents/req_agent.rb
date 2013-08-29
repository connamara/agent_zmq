require 'agent_zmq/agents/base_agent'

class AgentZMQ::ReqAgent
  include AgentZMQ::BaseAgent

  def initialize name
    @name=name
    @socket_opts=[]
  end

  def sock_type
    zmq_context.socket(ZMQ::REQ)
  end

  def start
    zmq_socket
    sleep 0.8 # slow joiner
  end

  def stop
    zmq_socket.close
  end

  def publish msg
    AgentZMQ::Helpers.publish(zmq_socket, msg)
    AgentZMQ::Helpers.read_msg zmq_socket
 end

  def reset
    #no-op
  end
end
