module AgentZeroMQ
  extend self

  def agent_path
    "./config/zmq_agents.rb"
  end

  def agents
    return @agents if @agents

    (@agents=[]).tap do
      load_agents if agent_files_loaded.empty?
    end
  end

  def agent_files_loaded
    @agent_files_loaded ||=[]
  end

  def load_agents path=nil
    path = File.expand_path(path || agent_path, Dir.pwd)
    return if agent_files_loaded.include? path
    agent_files_loaded << path
    load path
  end

  def define_agent(agent, &blk)
    yield agent
    agents << agent
  end

  def define_ZMQ_SUB(name, &blk) 
    define_agent(AgentZeroMQ::SubAgent.new(name), &blk)
  end

  def define_ZMQ_PUB(name, &blk)
    define_agent(AgentZeroMQ::PubAgent.new(name), &blk)
  end

  def define_ZMQ_REQ(name, &blk)
    define_agent(AgentZeroMQ::ReqAgent.new(name), &blk)
  end

  def define_ZMQ_REP(name, &blk)
    define_agent(AgentZeroMQ::RepAgent.new(name), &blk)
  end

  #starts all configured agents
  def start
    raise RuntimeError, "No ZeroMQ Agents Defined" if agents.empty?

    agents.each do |a|
      a.start
    end
  end

  def stop
    agents.each {|a| a.stop}
  end

  def reset
    agents.each {|a| a.reset}
  end

  def agents_hash
    Hash[agents.map { |a| [a.name.to_sym, a]}]
  end
end

require 'agent_zeromq/helpers'
require 'agent_zeromq/agent'
