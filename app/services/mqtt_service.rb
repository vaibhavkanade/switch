require 'mqtt'

class MqttService
  MQTT_TIMEOUT = 10
  attr_accessor :client

  def initialize
    @client = MQTT::Client.connect(
      host: ENV['MQTT_HOST'], 
      port: ENV['MQTT_PORT'], 
      username: ENV['MQTT_USERNAME'], 
      password: ENV['MQTT_PASSWORD'], 
      ssl: ENV['MQTT_SSL'])
  end

  def publish(topic, message)
    begin
      result = nil
      @client.publish(topic, message, retain: true)
      result = "Message '#{message}' published to '#{topic}'"
    rescue StandardError => e
      raise "MQTT publish error: #{e.message}"
    ensure
      client.disconnect
    end
  end

  def get(mqtt_topic)
    begin
      topic, message = client.get(mqtt_topic)
      return topic, message
    rescue StandardError => e
      puts "An unexpected error occurred: MqttService#get #{e.message}"
    ensure
      client.disconnect
    end
  end

end
