class Appliance < ApplicationRecord
	enum state: { off: false, on: true }
end
