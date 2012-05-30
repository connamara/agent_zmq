module AgentZeroMQ
  module Helpers
    extend self

    def read_msg socket
      msg_parts = []

      begin
        part=""
        socket.recv_string part
        msg_parts << part
      end while socket.more_parts?

      msg_parts
    end

    def publish msg, socket
      msg = [msg] unless msg.is_a? Array

      while true do
        msg_part=msg.shift

        if msg.empty?
          socket.send_string msg_part
          break
        else
          socket.send_string msg_part, ZMQ::SNDMORE
        end
      end
    end
  end
end
