require 'spec_helper'

class DummyClass
end

describe AgentZeroMQ::MessageCache do
  before(:each) do
    @cache = DummyClass.new
    @cache.extend(AgentZeroMQ::MessageCache)
  end

  describe "pop" do
    it "returns nil if empty" do
      @cache.pop.should be_nil
    end

    it "returns pops messages in lifo" do
      @cache.add_msg "hello"
      @cache.add_msg "world"

      @cache.pop.should ==("world")
      @cache.pop.should ==("hello")
      @cache.pop.should be_nil
    end
  end

  describe "clear" do
    it "removes all cached messages" do
      @cache.add_msg "hello"
      @cache.add_msg "world"

      @cache.clear
      @cache.pop.should be_nil
    end
  end

  describe "messages_received" do
    it "duplicates the internal message cache" do
      @cache.add_msg "hello"
      @cache.add_msg "world"

      msgs_received = @cache.messages_received
      @cache.clear
      msgs_received.should ==["hello", "world"]
    end
  end
end
