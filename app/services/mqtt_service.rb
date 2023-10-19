require 'mqtt'

class MqttService
  MQTT_TIMEOUT = 10

  def initialize
    @client = MQTT::Client.connect(
      host: ENV['MQTT_HOST'], 
      port: ENV['MQTT_PORT'], 
      username: ENV['MQTT_USERNAME'], 
      password: ENV['MQTT_PASSWORD'], 
      ssl: ENV['MQTT_SSL'])
  end

  def publish(topic, message)
    result = nil
    Timeout.timeout(MQTT_TIMEOUT) do
      @client.publish(topic, message, retain: true)
      result = "Message '#{message}' published to '#{topic}'"
    end
    result
  rescue Timeout::Error
    raise "MQTT publish operation timed out"
  rescue StandardError => e
    raise "MQTT publish error: #{e.message}"
  end

end
