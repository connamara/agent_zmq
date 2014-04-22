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

      if @socket_opts.is_a? Array
        @socket_opts.each do |opts|
          opts.each_pair do |opt_name, opt_val|
            @sub_socket.setsockopt(opt_name,opt_val)
          end
        end
      end
    end
  end
end
