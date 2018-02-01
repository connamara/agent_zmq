module AgentZMQ::BaseAgent
  attr_reader :name

  attr_accessor :end_point_type, :end_point, :socket_opts
  alias :end_points :end_point
  alias :end_points= :end_point=

  def zmq_context
    @ctx ||= ZMQ::Context.new 1
  end

  def zmq_socket
    return @sub_socket unless @sub_socket.nil?

    (@sub_socket = sock_type).tap do
      if @socket_opts.is_a?(Array)
        @socket_opts_after = @socket_opts.select {|o| o if o.has_key?(ZMQ::SUBSCRIBE) || o.has_key?(ZMQ::UNSUBSCRIBE) || o.has_key?(ZMQ::LINGER) }
        @socket_opts_before = @socket_opts - @socket_opts_after
      end

      setsockopts(@sub_socket, @socket_opts_before)

      case @end_point_type 
        when :connect
          if @end_point.is_a? Array
            @end_point.each { |ep| @sub_socket.connect(ep) }
          else
            @sub_socket.connect(@end_point) 
          end
        else
          @sub_socket.bind(@end_point) 
      end

      setsockopts(@sub_socket, @socket_opts_after)
    end
  end

  def setsockopts(sock, opts=[])
    if opts.is_a?(Array)
      opts.each do |o|
        o.each_pair do |name, val|
          sock.setsockopt(name, val)
        end
      end
    end
  end
end
