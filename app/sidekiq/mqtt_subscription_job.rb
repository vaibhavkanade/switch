class MqttSubscriptionJob
  include Sidekiq::Job
  sidekiq_options queue: 'mqtt_subcribe'

  def perform

    loop do
      Appliance.all.each do |appliance|
        handle_mqtt_subscription(appliance)
      end
      sleep 1
    end
  end

  def handle_mqtt_subscription(appliance)
    mqtt_service = MqttService.new

    begin
      topic, message = mqtt_service.get(appliance.mqtt_topic)
      if appliance.state.downcase != message.downcase
        appliance.toggle
      end
    rescue StandardError => e
      puts "An unexpected error occurred : MqttSubscriptionJob#{}handle_mqtt_subscription : #{e.message}"
    end
  end
end
