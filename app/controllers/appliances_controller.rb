class AppliancesController < ApplicationController
  def index
    @appliances = Appliance.all
  end

  def toggle
    @appliance = Appliance.find(params[:id])

    mqtt_service = MqttService.new

    if @appliance.on?
      mqtt_service.publish(@appliance.mqtt_topic, 'Off')
      @appliance.off!
    else
      mqtt_service.publish(@appliance.mqtt_topic, 'On')
      @appliance.on!
    end

    respond_to do |format|
      format.turbo_stream 
    end
  end
end
