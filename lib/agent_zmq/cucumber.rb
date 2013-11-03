require 'agent_zmq'
require 'rspec'
require 'anticipate'
require 'cuke_mem'

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
  subscriber = subscriber.to_sym

  AgentZMQ.agents_hash.has_key?(subscriber).should eq(true), "Unknown agent '#{subscriber}'"
  AgentZMQ.agents_hash[subscriber].respond_to?(:shift).should eq(true), "#{subscriber} is not an agent type that receives messages"

  if negative
    @zmq_message = nil
    AgentZMQ.cucumber_retries.times do
      @zmq_message=AgentZMQ.agents_hash[subscriber].shift
      @zmq_message.should be_nil
      sleep AgentZMQ.cucumber_sleep_seconds
    end
  else
    anticipate_zmq do
      @zmq_message=AgentZMQ.agents_hash[subscriber].shift
      @zmq_message.should_not be_nil
    end
  end
end

Then /^the (?:zeromq|ZeroMQ|Zeromq) (?:request|response|message) should( not)? have (\d+) (?:parts|part)$/ do |length, negative|
  throw "last_zmq_message is nil" if last_zmq_message.nil?
  index = index.to_i
  length = length.to_i

  if negative
    last_zmq_message.length.should_not ==(length)
  else
    last_zmq_message.length.should ==(length)
  end
end

def zmq_message_at index
  last_zmq_message.should_not eq(nil), "last_zmq_message is nil"
  index = index.to_i

  (index <= last_zmq_message.length).should be_true, "last_zmq_message has only #{last_zmq_message.length} parts"
  last_zmq_message[(index - 1)]
end

Then /^part (\d+) of the (?:zeromq|ZeroMQ|Zeromq) (?:request|response|message) should( not)? be "([^"]*)"$/ do |index, negative, value|
  value = CukeMem.remember(value)

  if negative
    zmq_message_at(index).should_not eq(value)
  else
    zmq_message_at(index).should eq(value)
  end
end

Then /^part (\d+) of the (?:zeromq|ZeroMQ|Zeromq) (?:request|response|message) should( not)? be:$/ do |index, negative, value|
  value = CukeMem.remember(value)

  if negative
    zmq_message_at(index).should_not eq(value)
  else
    zmq_message_at(index).should eq(value)
  end
end

Then(/^the (?:zeromq|ZeroMQ|Zeromq) (?:request|response|message) should( not)? be:$/) do |negative, exp_message|
  last_zmq_message.should_not eq(nil), "last_zmq_message is nil"

  exp_msg_parts = exp_message.raw.last.map {|part| CukeMem.remember(part)}
  if negative
    last_zmq_message.should_not eq(exp_msg_parts), "Did not expect equivalent message"
  else
    last_zmq_message.should eq(exp_msg_parts)
  end
end


Then /^I keep part (\d+) of the (?:zeromq|ZeroMQ|Zeromq|) (?:request|response|message) as "(.*?)"$/  do |index, key|
  CukeMem.memorize key, zmq_message_at(index)
end

Given(/^the following (?:zeromq|ZeroMQ|Zeromq) (?:request|response|message):$/) do |table|
  @zmq_message = table.raw.last
end
