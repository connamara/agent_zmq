require 'thread'
module AgentZeroMQ::MessageCache
  def messages_received
    lock.synchronize do
      msg_cpy = messages.dup
    end

    msg_cpy
  end

  def pop
    result = nil
    lock.synchronize do
      result = messages.pop
    end
    result
  end

  def add_msg msg
    lock.synchronize do
      messages << msg
    end
  end

  def clear
    lock.synchronize do
      messages.clear
    end
  end

  private

  def messages
    @messages||=[]
  end

  def lock
    @lock||=Mutex.new
  end
end
