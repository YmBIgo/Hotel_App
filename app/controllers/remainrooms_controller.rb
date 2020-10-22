class RemainroomsController < ApplicationController

	before_action :authenticate_user!

	def show
		@remainroom = Remainroom.find(params[:id])
		plans_remainrooms  = @remainroom.room_ids
		@plans_remainrooms = eval("#{plans_remainrooms}")
		if @remainroom.room_prices == ""
			@remainroom = create_price(@remainroom)
		end
		price_remainrooms  = @remainroom.room_prices
		@price_remainrooms = eval("#{price_remainrooms}")
		# @reservations = Reservation.where(room_date:  )
		reservation_before = Reservation.where("start_date <= ?", @remainroom.room_date)
		@reservations 	   = reservation_before.where("end_date >= ?", @remainroom.room_date)
	end
	def index
		@reservations = Reservation.all
		@remainrooms = Remainroom.all
	end
	def new
		room_date = Date.parse(params["room_date"])
		remainroom = initialize_or_find_remainroom(room_date)
		redirect_to "/remainrooms/#{remainroom.id}"
	end
	def create
		@remainroom = Remainroom.new(room_params)
		if @remainroom.valid?
			@remainroom.save!
			redirect_to "/remainrooms/#{@remainroom.id}"
		else
			redirect_to "/remainrooms"
		end
	end
	def edit
		@remainroom = Remainroom.find(params[:id])
		plans_remainrooms  = @remainroom.room_ids
		@plans_remainrooms = eval("#{plans_remainrooms}")
		price_remainrooms  = @remainroom.room_prices
		@price_remainrooms = eval("#{price_remainrooms}")
	end
	def update
		@remainroom = Remainroom.find(params[:id])
		parse_plan_price(@remainroom, params)
		if @remainroom.valid?
			@remainroom.save!
			redirect_to "/remainrooms/#{@remainroom.id}"
		else
			redirect_to "/remainrooms/#{@remainroom.id}"
		end
	end
	def delete
	end

	private
	def room_params
		params.require(:remainroom).permit(:reservation_ids, :room_date, :room_ids)
	end
	def create_price(remainroom)
		plan_ids = Plan.all.map {|m| m.id}
		price_hash = {}
		plan_ids.each do |pr|
			price_hash[pr] = 5000
		end
		remainroom.update(:room_prices => price_hash.to_s)
		return remainroom
	end
	def parse_plan_price(remainroom, params)
		remainroom_params_keys = params["remainroom"].keys
		remainroom_hash = {}
		remainroom_params_keys.each do |r_key|
			 r_room_k = r_key.gsub("remainroom_", "")
			 remainroom_hash[r_room_k] = params["remainroom"][r_key]
		end
		remainroom.update(:room_prices => remainroom_hash.to_s)
		return remainroom
	end

end
