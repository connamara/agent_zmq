module AgentZMQ
  module Configuration
    def cucumber_sleep_seconds=(secs)
      @cucumber_sleep_seconds = secs
    end
    
    def cucumber_sleep_seconds
      @cucumber_sleep_seconds ||= 0.5
    end

    def cucumber_retries=(retries)
      @cucumber_retries = retries
    end

    def cucumber_retries
      @cucumber_retries ||= 10
    end

    def reset
      instance_variables.each{|ivar| remove_instance_variable(ivar) }
    end
  end
end
