workers Integer(ENV['WEB_CONCURRENCY'] || 2)  
threads_count = Integer(ENV['MAX_THREADS'] || 1)  
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup  
port        ENV['PORT']     || 3000  
environment ENV['RACK_ENV'] || 'development'

# Because we are using preload_app, an instance of our app is created by master process (calling our initializers) and then memory space
# is forked. So we should close DB connection in the master process to avoid connection leaks.
# https://github.com/puma/puma/issues/303
# http://stackoverflow.com/questions/17903689/puma-cluster-configuration-on-heroku
# http://www.rubydoc.info/gems/puma/2.14.0/Puma%2FDSL%3Abefore_fork
# Dont have to worry about Sidekiq's connection to Redis because connections are only created when needed. As long as we are not
# queuing workers when rails is booting, there will be no redis connections to disconnect, so it should be fine.
before_fork do  
  puts "Puma master process about to fork. Closing existing Active record connections."
  ActiveRecord::Base.connection.disconnect!
end

on_worker_boot do  
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end  
