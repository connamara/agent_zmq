require File.expand_path("../../agent_zeromq", __FILE__)

require 'rspec'

module ZMQMessageCache
  def last_zmq_message
    @message
  end
end

World(ZMQMessageCache)

Then /^I should receive a (?:request|response|message) on ZeroMQ with agent "([^"]*)"$/ do |subscriber|
  throw "Unknown agent #{subscriber}" unless AgentZeroMQ.agents_hash.has_key?(subscriber.to_sym)
  throw "#{subscriber} is not an agent type that receives messages" unless AgentZeroMQ.agents_hash[subscriber.to_sym].respond_to?(:pop)

  @message=AgentZeroMQ.agents_hash[subscriber.to_sym].pop
  @message.should_not be_nil
end

Then /^the ZeroMQ (?:request|response|message) should have (\d+) parts$/ do |length|
  throw "last_zmq_message is nil" if last_zmq_message.nil?

  last_zmq_message.length == length.to_i
end

Then /^part (\d+) of the ZeroMQ (?:request|response|message) should be "([^"]*)"$/ do |index, value|
  throw "last_zmq_message is nil" if last_zmq_message.nil?

  last_zmq_message.length.should >= index.to_i
  last_zmq_message[(index.to_i - 1)].should == value
end
