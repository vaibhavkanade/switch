class MqttSubscriptionJob
  include Sidekiq::Job
  sidekiq_options queue: 'mqtt_subcribe'

  def perform
    puts "started ---------------------"

    loop do
      Appliance.all.each do |appliance|
        puts "Called --------------------- #{appliance.mqtt_topic}"
        handle_mqtt_subscription(appliance.mqtt_topic, appliance.state)
      end
    end
  end

  def handle_mqtt_subscription(mqtt_topic, appliance_state)
    mqtt_service = MqttService.new

    begin
      puts "begin --------------------- mqtt_topic}"
      topic, message = mqtt_service.get(mqtt_topic)
      puts "Received '#{topic} --------------------- #{message}"
      unless condition
        # update the state    
      end   
    rescue Timeout::Error
      puts "Timeout reached."
    rescue StandardError => e
      puts "An unexpected error occurred: #{e.message}"
    end
  end
end
