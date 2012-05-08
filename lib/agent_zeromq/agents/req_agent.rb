require 'agent_zeromq/agents/base_agent'

class AgentZeroMQ::ReqAgent
  include AgentZeroMQ::BaseAgent

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
    msg = [msg] unless msg.is_a? Array

    while true do
      msg_part=msg.shift

      if msg.empty?
        zmq_socket.send_string msg_part
        break
      else
        zmq_socket.send_string msg_part, ZMQ::SNDMORE
      end
    end
   
    response=[]
    begin
      part=""
      zmq_socket.recv_string part
      response << part
    end while zmq_socket.more_parts?

    return response
  end

  def reset

  end






end
