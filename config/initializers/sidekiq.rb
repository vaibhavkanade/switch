Sidekiq.configure_server do |config|
  config.logger = Logger.new("#{Rails.root}/log/sidekiq.log")
end
