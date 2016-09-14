redis_url = ENV['REDIS_URL'] || "redis://redis:6379/0"
sidekiq_config = { url: redis_url }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end
