class Appliance < ApplicationRecord
	enum state: { off: false, on: true }
	after_update_commit { broadcast_update }

	def mqtt_topic
		"Home/#{self.name}"
	end

	def toggle
		self.on? ? self.off! : self.on!
	end

	def value
		self.on? ? 'off' : 'on'
	end

end
