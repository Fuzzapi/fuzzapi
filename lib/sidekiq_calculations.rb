class SidekiqCalculations
  DEFAULT_CLIENT_REDIS_SIZE  = 2
  DEFAULT_SERVER_CONCURRENCY = 25

  def raise_error_for_env!
    return if !Rails.env.production?

    web_dynos
    worker_dynos
    max_redis_connection
  rescue KeyError, TypeError # Integer(nil) raises TypeError
    raise <<-ERROR
Sidekiq Server Configuration failed.
!!!======> Please add ENV:
  - NUMBER_OF_WEB_DYNOS
  - NUMBER_OF_WORKER_DYNOS
  - MAX_REDIS_CONNECTION
    ERROR
  end

  def client_redis_size
    return DEFAULT_CLIENT_REDIS_SIZE if !Rails.env.production?

    puma_workers * (puma_threads/2) * web_dynos
  end

  def server_concurrency_size
    return DEFAULT_SERVER_CONCURRENCY if !Rails.env.production?

    (max_redis_connection - client_redis_size - sidekiq_reserved) / worker_dynos / paranoid_divisor
  end

  private
    def web_dynos
      Integer(1)
    end

    def worker_dynos
      Integer(5)
    end

    def max_redis_connection
      Integer(20)
    end

    # ENV used in `config/puma.rb` too.
    def puma_workers
      Integer(ENV.fetch("WEB_CONCURRENCY", 2))
    end

    # ENV used in `config/puma.rb` too.
    def puma_threads
      Integer(ENV.fetch("WEB_MAX_THREADS", 5))
    end

    # https://github.com/mperham/sidekiq/blob/master/lib/sidekiq/redis_connection.rb#L12
    def sidekiq_reserved
      5
    end

    # This is added to bring down the value of Concurrency
    # so that there's leeway to grow
    def paranoid_divisor
      2
    end
end
