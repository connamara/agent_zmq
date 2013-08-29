Given /^publisher "([^"]*)" sends the following:$/ do |publisher, message|
  AgentZMQ.agents_hash[publisher.to_sym].publish message.raw.first
end

Given /^I sleep (\d+) seconds$/ do |seconds|
  sleep(seconds.to_i)
end
