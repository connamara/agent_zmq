module AgentZeroMQ::MessageCache
  def messages_received
    lock.lock
    msg_cpy = messages.dup
    lock.unlock

    msg_cpy
  end

  def add_msg msg
    lock.lock
    messages << msg
    lock.unlock
  end

  private

  def messages
    @messages||=[]
  end

  def lock
    @lock||=java.util.concurrent.locks.ReentrantLock.new
  end
end
