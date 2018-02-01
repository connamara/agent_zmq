require 'agent_zmq/agents/base_agent'

class AgentZMQ::DealerAgent
  include AgentZMQ::BaseAgent

  def initialize name
    @name=name
    @socket_opts=[]
  end

  def sock_type
    zmq_context.socket(ZMQ::DEALER)
  end

  def start
    zmq_socket
    sleep 0.8 # slow joiner
  end

  def stop
    reset

    unless @ctx.nil?
      @ctx.terminate
      @ctx = nil
    end
  end

  def publish msg
    AgentZMQ::Helpers.publish(zmq_socket, msg)
   end

  def pop
    @zmq_poller = ZMQ::Poller.new
    @zmq_poller.register(zmq_socket, ZMQ::POLLIN)

    @zmq_poller.poll(1000)
    @zmq_poller.readables.each do |sock|
      return AgentZMQ::Helpers.read_msg sock
    end

    return nil #timeout
  end

  alias_method :shift, :pop
  
  def reset
    #reset socket so as to not read old messages
    unless @sub_socket.nil?
      @sub_socket.setsockopt(ZMQ::LINGER, 0)
      @sub_socket.close
      @sub_socket = nil
    end
  end
end
