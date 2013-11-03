require 'agent_zmq/message_cache'
require 'agent_zmq/agents/base_agent'

class AgentZMQ::SubAgent
  include AgentZMQ::MessageCache
  include AgentZMQ::BaseAgent

  attr_reader :name

  def initialize name
    @name=name
    @socket_opts=[]

    @mutex=Mutex.new
    @read_thread=nil
    @do_run_read_thread = true
  end

  def do_read 
    while true 
      @mutex.synchronize do
        return unless @do_run_read_thread
      end

      @zmq_poller.poll(1000)

      @zmq_poller.readables.each do |sock|
        add_msg AgentZMQ::Helpers.read_msg sock
      end
    end

    zmq_socket.close 
  end

  def sock_type
    zmq_context.socket(ZMQ::SUB)
  end


  def start_read_thread
    @zmq_poller = ZMQ::Poller.new
    @zmq_poller.register(zmq_socket, ZMQ::POLLIN)

    @read_thread = Thread.new {do_read}
  end

  def start
    start_read_thread
  end

  def stop
    @mutex.synchronize do
      @do_run_read_thread = false
    end
    @read_thread.join
    zmq_socket.close
  end

  def reset
    clear
  end

end
