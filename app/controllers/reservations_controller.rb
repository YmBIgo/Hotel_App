require "digest/md5"
class ReservationsController < ApplicationController

	before_action :authenticate_user!, :only => [:index]
	skip_before_action :verify_authenticity_token, :only => [:pay]

	def show
		@reservation = Reservation.find(params[:id])
		@reservation_hash = params["reservation_hash"]
		if user_signed_in?
			@email = @reservation.email
		else
			if @reservation_hash != @reservation.url_hash
				redirect_to "/"
				return
			end
		end
		@plan = Plan.find(@reservation.plan_id)
	end
	def index
		@reservations = Reservation.all
	end
	def new
		@people_num = params["people_num"].to_i
		@start_date = params["start_date"]
		@end_date   = params["end_date"]
		check_accurate_date(@start_date, @end_date)
		@plans = list(params)
		@prices_hash = cal_price(@plans, @start_date, @end_date)
	end
	def create
		# int の 0, 1 以外処理
		start_date  = params[:start_date]
		end_date    = params[:end_date]
		check_accurate_date(start_date, end_date)
		@reservation = register(params)
		if @reservation == false
			redirect_to "/reservation/new"
		else
			if @reservation.valid?
				# hash生成して、cookieなしで認証できるように
				r_hash = generate_hash(params[:email], params[:start_date], params[:plan_id])
				@reservation.update(:url_hash => r_hash)
				@reservation_url = root_url + "reservations/" + @reservation.id.to_s + "?reservation_hash=" + r_hash
				send_mail(params[:email], @reservation_url)
				@reservation.save!
			else
				redirect_to "/reservation/new"
			end
		end
	end
	def delete
		@reservation = Reservation.find(params[:id])
		# reservation 削除 ・ RemainRoomの編集
	end
	def confirm
		@start_date = params["start_date"]
		@end_date   = params["end_date"]
		check_accurate_date(@start_date, @end_date)
		@plan = Plan.find(params["plan_id"])
		@prices_hash = cal_price([@plan], @start_date, @end_date)
	end
	def check
		@id = params[:id]
		@reservation = Reservation.find(@id)
		@email = params[:email]
		@reservation_hash = params[:reservation_hash]
		unless user_signed_in?
			if @reservation_hash != @reservation.url_hash
				redirect_to "/"
				return
			elsif @email != @reservation.email
				redirect_to "/reservations/#{@id}?reservation_hash=#{@reservation_hash}"
				return
			end
		end
		@plan = Plan.find(@reservation.plan_id)
	end
	def pay
		id = params[:id]
		reservation_hash = params[:reservation_hash]
		reservation = Reservation.find(id)
	# }bnaBN

		if reservation.url_hash == reservation_hash
			Payjp.api_key = "sk_test_bb26886048e8a974df00e02c"
			charge = Payjp::Charge.create(
			    amount: reservation.price,
			    card: params['payjp-token'],
			    currency: 'jpy')
			reservation.update(has_paid => true)
		else
		end

		redirect_to "/reservations/#{id}?reservation_hash=#{reservation_hash}"
	end

	private
	def register(params)
		reservation_params = params
		start_date  = Date.parse(reservation_params[:start_date])
		end_date    = Date.parse(reservation_params[:end_date])
		plan_id		= reservation_params[:plan_id]
		plan 		= Plan.find(plan_id)
		remainrooms = []; room_ids_array = [];
		(start_date..end_date).each do |d|
			remainroom	= Remainroom.find_by(:room_date => d)
			# plan_id=>部屋数
			# {:1=>1, :2=>3, :3=>0}
			room_ids = eval("#{remainroom.room_ids}")
			# 部屋数未満 => true / 部屋数以上 => false
			if plan.room_num <= room_ids[plan.id]
				return false
			end
			remainrooms.push(remainroom); room_ids_array.push(room_ids);
		end
		0.upto(remainrooms.length-1) do |num|
			r_r = remainrooms[num]; room_id = room_ids_array[num];
			room_id[plan.id] += 1
			r_r.update(:room_ids => room_id.to_s)
		end
		# user_id は、current_user から？
		p_price = cal_price([plan], start_date.to_s, end_date.to_s)[plan_id.to_i]
		reservation = Reservation.new(:start_date => start_date, :end_date => end_date, :price => p_price,
			:plan_id => plan_id, :payment_type => reservation_params[:payment_type], :email => reservation_params[:email],
			:first_name => reservation_params[:first_name], :last_name => reservation_params[:last_name], :people_num => reservation_params[:people_num])
		return reservation
	end
	def list(params)
		reservation_params = params
		start_date  = Date.parse(reservation_params[:start_date])
		end_date    = Date.parse(reservation_params[:end_date])
		people_num  = reservation_params[:people_num]
		plans 		= Plan.where(people_num: people_num.to_i..20)
		confirmed_plans = []
		(start_date..end_date).each do |d|
			remainroom	= initialize_or_find_remainroom(d)
			# plan_id=>部屋数
			# {:1=>1, :2=>3, :3=>0}
			room_ids = eval("#{remainroom.room_ids}")
			plans.each do |plan|
				if plan.people_num <= room_ids[plan.id]
					plans.delete(plan)
				end
			end
		end
		return plans
	end
	# check date
	def check_accurate_date(s_date, e_date)
		if s_date.to_s == "" || e_date.to_s == ""
			redirect_to "/"
			return
		else
			if Date.parse(s_date) > Date.parse(e_date)
				redirect_to "/"
				return
			elsif Date.parse(s_date) < Date.today || Date.parse(e_date) < Date.today
				redirect_to "/"
				return
			end
		end
	end
	# generate hash
	def generate_hash(email, s_date, plan_id)
		rand_string = rand(1..100000000000).to_s
		hash_seed = email + s_date + plan_id + rand_string
		digest = Digest::MD5.new
		digest.update(hash_seed)
		reservation_digest = digest.hexdigest
		return reservation_digest
	end
	# cal price useing plans
	def cal_price(plans, s_date, e_date)
		start_date = Date.parse(s_date)
		end_date   = Date.parse(e_date)
		remainrooms = Remainroom.where(room_date: start_date..end_date)
		plan_ids    = plans.map {|p| p.id }
		result_hash = {}
		remainrooms.each do |r_room|
			r_room_ids = r_room.room_prices
			r_room_hash = eval("#{r_room_ids}")
			plan_ids.each do |p_id|
				if result_hash[p_id] == nil
					result_hash[p_id] = 0
				end
				result_hash[p_id] += r_room_hash[p_id].to_i
			end
		end
		return result_hash
	end
end
