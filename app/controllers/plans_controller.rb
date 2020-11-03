class PlansController < ApplicationController

	before_action :authenticate_user!, :only => [:edit, :update, :new, :create, :delete, :admin_index]

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
	def admin_index
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
		if @plan.html_content != ""
			@update_array = parse_update_html(@plan)
		else
			@update_array = ["", "", "", "", "", ""]
		end
	end
	def update
		@plan = Plan.find(params[:id])
		@plan.update(plan_params)
		update_html(params, @plan)
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

	def update_html(params, plan)
		if plan.html_content == ""
			plan.html_content = '<div class="row">
<div class="col-4"><div class="card" style="padding:7px;margin-bottom:10px;margin-right:20px;width:90%;">
  <p><i class="fa fa-bed"></i> ベッド</p>
  <p style="margin-left:20px">ベッド１ cm * cm</p>
</div>
</div>
<div class="col-4"><div class="card" style="padding:7px;margin-bottom:10px;margin-right:20px;width:90%;">
  <p><i class="fa fa-wifi"></i> Wifi</p>
  <p style="margin-left:20px">全客室、共用エリア（無料）</p>
</div>
</div>
<div class="col-4"><div class="card" style="padding:7px;margin-bottom:10px;margin-right:20px;width:90%;">
  <p><i class="fa fa-shower"></i> 水回り</p>
  <p style="margin-left:20px">バスタブ、バス・トイレ・洗面台別、洗浄機能付きトイレ</p>
</div>
</div>
<div class="col-4"><div class="card" style="padding:7px;margin-bottom:10px;width:90%;">
  <p><i class="fa fa-inbox"></i> 設備・アメニティ</p>
  <p style="margin-left:20px">禁煙、Bluetoothプレーヤー、読書灯、加湿空気清浄機、電気ケトル、ミニバー、金庫、完全遮光幕、作務衣、パジャマ、サンダル、歯ブラシ、バスアメニティ、化粧水、タオル、ドライヤー</p>
</div>
</div>
<div class="col-4"><div class="card" style="padding:7px;margin-bottom:10px;margin-right:20px;width:90%;">
  <p><i class="fa fa-child"></i> 子供・添い寝</p>
  <p style="margin-left:20px">お部屋の定員数と同数を上限に、12歳未満のお子様の添い寝（お食事・寝具なし）を承ります。</p>
</div>
</div>
<div class="col-4"><div class="card" style="padding:7px;margin-bottom:10px;width:90%;">
  <p><i class="fa fa-circle-o-notch"></i> その他</p>
  <p style="margin-left:20px">※写真・間取りは一例です。<br>※特定のお部屋指定は承りかねます。<br>※ご予約後の人数変更は承りかねます。</p>
</div>
</div>
</div>'
		else
			result_html = '<div class="row">'
			partial_html1_1 = '<div class="col-4"><div class="card" style="padding:7px;margin-bottom:10px;margin-right:20px;width:90%;">
  <p><i class="fa fa-' 
  			partial_html1_2 = '"></i> '
  			partial_html2 = '</p>
  <p style="margin-left:20px">'
  			partial_html3 = '</p>
</div>
</div>'
			params_japanese = {:bed => "ベッド", :wifi => "Wifi", :water => "水回り", :faculity => "設備・アメニティ", :baby => "子供・添い寝", :other => "その他" }
			params_japanese.each do |k, c|
				result_html += partial_html1_1 + k.to_s + partial_html1_2
				result_html += c.to_s + partial_html2
				result_html += params[k] + partial_html3
			end
			result_html += "</div>"
			plan.html_content = result_html
		end
		plan.save!
	end

	def parse_update_html(plan)
		plan_html = plan.html_content
		plan_html_array = []
		plan_html_splited = plan_html.split('margin-left:20px">')
		plan_html_splited[1..-1].each do |plan_d|
			puts plan_d.split("</p>")[0]
			plan_html_array.push(plan_d.split("</p>")[0])
		end
		return plan_html_array
	end

end
