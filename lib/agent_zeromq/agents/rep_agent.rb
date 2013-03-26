require 'agent_zeromq/agents/base_agent'
require 'thread'

class AgentZeroMQ::RepAgent
  include AgentZeroMQ::BaseAgent
  include AgentZeroMQ::MessageCache

  attr_accessor :reply

  def initialize name
    @name=name
    @socket_opts=[]

    @read_thread=nil
    @mutex = Mutex.new
    @do_run_read_thread = true
  end

  def do_read 
    while true 
      @mutex.synchronize do
        return unless @do_run_read_thread
      end
      @zmq_poller.poll(1000)

      @zmq_poller.readables.each do |sock|
        request=AgentZeroMQ::Helpers.read_msg sock
        add_msg request

        unless @reply.nil?
          AgentZeroMQ::Helpers.publish(sock, @reply.call(request))
        end
      end
    end

    zmq_socket.close 
  end

  def sock_type
    zmq_context.socket(ZMQ::REP)
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
      @do_run_read_thread=false
    end
    @read_thread.join
    zmq_socket.close
  end

  def reset
    clear
  end
end
