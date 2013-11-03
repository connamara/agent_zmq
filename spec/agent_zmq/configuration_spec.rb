require 'spec_helper'

describe AgentZMQ::Configuration do
  it "defaults to reasonable cucumber sleep and retry attempts" do
    AgentZMQ.cucumber_sleep_seconds.should==(0.5)
    AgentZMQ.cucumber_retries.should==(10)
  end

  it "can use custom cuke anticipate settings" do
    AgentZMQ.cucumber_sleep_seconds=20
    AgentZMQ.cucumber_sleep_seconds.should==(20)

    AgentZMQ.cucumber_retries=5
    AgentZMQ.cucumber_retries.should==(5)
  end
end
