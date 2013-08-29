AgentZMQ.define_ZMQ_SUB :my_subscriber do |a|
  a.socket_opts << {ZMQ::SUBSCRIBE=>""} 

  a.end_point_type=:connect
  a.end_point='tcp://127.0.0.1:5560'
end

AgentZMQ.define_ZMQ_PUB :my_publisher do |a|
  a.end_point_type=:bind
  a.end_point='tcp://*:5560'
end



