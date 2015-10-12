class API::V1::DevicesController < ApplicationController
 skip_before_filter :verify_authenticity_token

 def index
  devices = Device.all
  render json: devices
 end

 def create
  device = Device.new(device_params)
	if device.save
  render json: device, status: 201
	else
	render json: 'device already registered'
	end
 end

 private

 def device_params
  params.require(:device).permit(
   :token,
   :platform,
   :enabled,
   :user_id
  )
 end
end
