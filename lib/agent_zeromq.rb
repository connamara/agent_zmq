module AgentZeroMQ
  AGENT_PATH="./config/zmq_agents.rb"

  extend self

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
    path = File.expand_path(path || AGENT_PATH, Dir.pwd)
    return if agent_files_loaded.include? path
    agent_files_loaded << path
    load path
  end

  def define_agent(name=nil, &blk) 
    name ||=File.basename(caller.first.gsub(/.rb:.+$/,""))

    AgentZeroMQ::Agent.new(name).tap do |agent|
      yield agent
      agents << agent
    end
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

  def agents_hash
    Hash[agents.map { |a| [a.name.to_sym, a]}]
  end
end

require 'agent_zeromq/agent'
