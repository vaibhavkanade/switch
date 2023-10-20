class Appliance < ApplicationRecord
	enum state: { off: false, on: true }

	def mqtt_topic
		"Home/#{self.name}"
	end
end
