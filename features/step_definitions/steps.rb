Given /^publisher "([^"]*)" sends the following:$/ do |publisher, message|
  AgentZeroMQ.agents_hash[publisher.to_sym].publish message.raw.first
end
