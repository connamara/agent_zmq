module AgentZMQ::MessageCache
  def messages_received
    lock.synchronize do
      return messages.dup
    end
  end

  def shift
    lock.synchronize do
      return messages.shift
    end
  end

  def pop
    lock.synchronize do
      return messages.pop
    end
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
