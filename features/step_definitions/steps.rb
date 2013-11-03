Given /^publisher "([^"]*)" sends the following:$/ do |publisher, message|
  AgentZMQ.agents_hash[publisher.to_sym].publish message.raw.first
end
