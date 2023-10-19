class AppliancesController < ApplicationController
  def index
    @appliances = Appliance.all
  end

  def toggle
    @appliance = Appliance.find(params[:id])
    @appliance.on? ? @appliance.off! : @appliance.on!
    respond_to do |format|
      format.turbo_stream 
    end
  end
end
