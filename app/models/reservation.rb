class Reservation < ActiveRecord::Base

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	# 
	validates :plan_id, presence: true , inclusion: { in: 1..20 }
	validates :people_num, presence: true, inclusion: { in: 1..5 }
	validates :payment_type, presence: true, inclusion: { in: 0..2 }
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
	validates :first_name, presence: true
	validates :last_name, presence: true
	validate :date_before_start, on: :create
	validate :date_before_end, on: :create
	validates :url_hash, presence: true
	validates :price, presence: true, inclusion: { in: 3000..1000000 }

	def start_time
		self.start_date
	end
	def end_time
		self.end_date
	end

	def date_before_start
	    return if start_date.blank?
	    errors.add(:start_date, "は今日以降のものを選択してください") if start_date < Date.today
	  end

	  def date_before_end
	    return if end_date.blank? || start_date.blank?
	    errors.add(:end_date, "は開始日以降のものを選択してください") if end_date < start_date
	  end

end
