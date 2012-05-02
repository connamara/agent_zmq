require 'java'
require 'ffi-rzmq'

require 'agent_zeromq/message_cache'

class AgentZeroMQ::Agent
  include AgentZeroMQ::MessageCache

  attr_reader :name
  attr_accessor :filter, :end_point

  def initialize name
    @name=name

    @read_thread=nil
    @do_run_read_thread = java.util.concurrent.atomic.AtomicBoolean.new(true)
  end

  def do_read 
    while @do_run_read_thread.get
      @zmq_poller.poll(1000)

      @zmq_poller.readables.each do |sock|
        msg_parts=[]
        begin
          part=""
          sock.recv_string part
          msg_parts << part
        end while sock.more_parts?

        add_msg msg_parts
      end
    end

    zmq_socket.close 
  end

  def zmq_context
    @ctx ||= ZMQ::Context.new 1
  end

  def zmq_socket
    return @sub_socket unless @sub_socket.nil?

    (@sub_socket = zmq_context.socket(ZMQ::SUB)).tap do
      @sub_socket.bind(@end_point) 
      @sub_socket.setsockopt(ZMQ::SUBSCRIBE,@filter)
    end
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
    @do_run_read_thread.set(false)
    @read_thread.join
  end

end
