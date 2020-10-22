class PlansController < ApplicationController

	before_action :authenticate_user!, :only => [:edit, :update, :new, :create, :delete]

	def show
		@plan = Plan.find(params[:id])
		@reservations = Reservation.where(:plan_id => @plan.id)
	end
	def index
		@plans = Plan.all
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
		redirect_to "/plans/#{@plan.id}"
	end
	def delete
	end

	private
	def plan_params
		params.require(:plan).permit(:title, :price, :start_date, :end_date,
			:people_num, :room_num, :explanation, :html_content, :photo_url)
	end

end
