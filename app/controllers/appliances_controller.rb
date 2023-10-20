class AppliancesController < ApplicationController
  def index
    @appliances = Appliance.all
  end

  def toggle
    @appliance = Appliance.find(params[:id])

    mqtt_service = MqttService.new
    mqtt_service.publish(@appliance.mqtt_topic, @appliance.value)
  end
end
