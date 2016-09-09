Sidekiq.logger = Rails.logger

Sidekiq.default_worker_options = { 'backtrace' => true }

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDISCLOUD_URL'] }

  dbconfig = ActiveRecord::Base.configurations[Rails.env] || Rails.application.config.database_configuration[Rails.env]
  dbconfig['reaping_frequency'] = ENV['DB_REAP_FREQ'] || 10 # seconds
  dbconfig['pool']              = Sidekiq.options[:concurrency] + 2
  ActiveRecord::Base.establish_connection(dbconfig)
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDISCLOUD_URL'] }
end
