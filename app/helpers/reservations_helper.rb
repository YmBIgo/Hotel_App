module ReservationsHelper
	def calc_price_array(p_array)
		d_array = []
			p_array.each do |d_p|
				d_p_amount = 0
				d_p.each do |each_d_p|
					d_p_amount += each_d_p.price
				end
				d_array.push(d_p_amount)
			end
		return d_array
	end
	def date_array(type)
		date_array = []
		if type == "day"
			0.upto(6) do |d|
				date_array.push((Date.today + d).to_s)
			end
		elsif type == "week"
			0.upto(6) do |d|
				date_array.push((Date.today + d*7).to_s)
			end
		elsif type == "month"
			0.upto(6) do |d|
				date_array.push((Date.today + d*30).to_s)
			end
		end
		return date_array
	end
end
