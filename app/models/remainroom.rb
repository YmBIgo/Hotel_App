class Remainroom < ActiveRecord::Base

	# 10部屋以上の場合は、下。
	# /\{([1-9]{0,1}[0-9]\=\>[1-9]{0,1}[0-9](,\s)*){1,20}\}/
	ROOM_IDS_REGEX = /\{([1-9]{0,1}[0-9]\=\>[0-9](,\s)*){#{Plan.count-2},#{Plan.count+3}}\}/
	ROOM_PRICES_REGEX = /\{([1-9]{0,1}[0-9]\=\>\s([1-9]){0,1}[0-9][0-9]00(,)*){#{Plan.count-2},#{Plan.count+3}}\}/

	validates :room_prices, presence: true
	validate :check_room_date
	validates :room_ids, presence: true, format: { with: ROOM_IDS_REGEX }
	validates :room_prices, presence: true, format: { with: ROOM_PRICES_REGEX }

	def start_time
		self.room_date
	end

	def check_room_date
		return if room_date.blank?
		error.add(:room_date, "日付が間違っています") if room_date < Date.today
	end

end
