class PlansController < ApplicationController

	before_action :authenticate_user!, :only => [:edit, :update, :new, :create, :delete]

	def show
		@plan = Plan.find(params[:id])
		@reservations = Reservation.where(:plan_id => @plan.id)
	end
	def index
		if params["tags"]
			tag_id = params["tags"].to_i
			@tag = Tag.find_by(:id => tag_id)
			if @tag != nil
				tag_content = @tag.plan_ids.split(",").map {|m| m.to_i}
			else
				tag_content = Plan.all.map {|m| m.id}
			end
			@plans = Plan.where(:id => tag_content)
		else
			@plans = Plan.all
		end
	end
	# 以降は、Devise 制限
	def new
		@plan = Plan.new
	end
	def create
		@plan = Plan.new(plan_params)
		if @plan.valid?
			@plan.save!
		else
			redirect_to "/plans/new"
		end
	end
	def edit
		@plan = Plan.find(params[:id])
	end
	def update
		@plan = Plan.find(params[:id])
		@plan.update(plan_params)
		update_tags(params, @plan)
		redirect_to "/plans/#{@plan.id}"
	end
	def delete
	end

	private
	def plan_params
		params.require(:plan).permit(:title, :price, :start_date, :end_date,
			:people_num, :room_num, :explanation, :html_content, :photo_url)
	end
	def update_tags(params, plan)
		tag_ids = params[:plan][:tag_ids]
		# tag_array = eval("[#{tag_ids}]")
		plan.update(:tag_ids => tag_ids)
		check_tags(plan)
	end
	def check_tags(plan)
		tag_id_hash = {}
		Tag.all.each do |tag|
			tag_id_hash[tag.id] = []
		end
		logger.debug("---------")
		logger.debug(tag_id_hash)
		Plan.all.each do |plan|
			tag_ids = eval("[#{plan.tag_ids}]")
			tag_ids.each do |t_id|
				tag_id_hash[t_id].append(plan.id)
			end
		end
		# logger.debug(tag_id_hash)
		tag_id_hash.each do |k, v|
			if v != []
				t_value = v.to_s.gsub("[", "").gsub("]", "")
				Tag.find(k).update(:plan_ids => t_value)
				logger.debug(k.to_s + t_value)
			end
		end
		# Tag.all.each do |t|
		# 	t_array = eval("[#{t.plan_ids}]")
		# 	if plan_array.include?(t.id)
		# 		plan_array.each do |p_id|
		# 			unless t_array.include?(p_id)
		# 				tag_string = t.plan_ids + p_id.to_s + ","
		# 				t.update(:plan_ids => tag_string)
		# 				logger.debug("----------")
		# 				logger.debug(tag_string)
		# 			end
		# 		end
		# 	else
		# 		plan_array.each do |p_id|
		# 			if t_array.include?(p_id)
		# 				tag_string = t.plan_ids.gsub("#{p_id},", "")
		# 				# t.update(:plan_ids => tag_string)
		# 				logger.debug("----------")
		# 				logger.debug(tag_string)
		# 			end
		# 		end
		# 	end
		# end
	end

end
