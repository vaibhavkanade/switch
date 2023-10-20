require_relative '../../app/sidekiq/mqtt_subscription_job'

if defined?(Rails::Server)
  MqttSubscriptionJob.perform_async
  puts "started MqttSubscriptionJob----------------------------"
end
