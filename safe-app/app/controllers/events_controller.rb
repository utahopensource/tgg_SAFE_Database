class EventsController < ApplicationController

	def create
		@my_event = Event.find_by(refugeeventid: '1')
		p @my_event.nil?
		respond_to do |format|
			format.json { 
	        	render json: @my_event
	      	}
      	end

	end

end
