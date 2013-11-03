require File.expand_path("../../agent_zmq", __FILE__)

require 'rspec'
require 'anticipate'

module ZMQMessageCache
  include Anticipate

  def last_zmq_message
    @zmq_message
  end

  def anticipate_zmq
    sleeping(AgentZMQ.cucumber_sleep_seconds).seconds.between_tries.failing_after(AgentZMQ.cucumber_retries).tries do
      yield
    end
  end
end

World(ZMQMessageCache)

Then /^I should( not)? receive (?:a|another) (?:request|response|message) on (?:zeromq|ZeroMQ|Zeromq) with (?:agent|socket) "([^"]*)"$/ do |negative, subscriber|
  throw "Unknown agent #{subscriber}" unless AgentZMQ.agents_hash.has_key?(subscriber.to_sym)
  throw "#{subscriber} is not an agent type that receives messages" unless AgentZMQ.agents_hash[subscriber.to_sym].respond_to?(:shift)

  if negative
    @zmq_message = nil
    AgentZMQ.cucumber_retries.times do
      @zmq_message=AgentZMQ.agents_hash[subscriber.to_sym].shift
      @zmq_message.should be_nil
      sleep AgentZMQ.cucumber_sleep_seconds
    end
  else
    anticipate_zmq do
      @zmq_message=AgentZMQ.agents_hash[subscriber.to_sym].shift
      @zmq_message.should_not be_nil
    end
  end
end

Then /^the (?:zeromq|ZeroMQ|Zeromq) (?:request|response|message) should have (\d+) (?:parts|part)$/ do |length|
  throw "last_zmq_message is nil" if last_zmq_message.nil?

  last_zmq_message.length.should ==(length.to_i)
end

Then /^part (\d+) of the (?:zeromq|ZeroMQ|Zeromq) (?:request|response|message) should be "([^"]*)"$/ do |index, value|
  throw "last_zmq_message is nil" if last_zmq_message.nil?

  last_zmq_message.length.should >= index.to_i
  last_zmq_message[(index.to_i - 1)].should == value
end
