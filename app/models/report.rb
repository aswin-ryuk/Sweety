class Report < ApplicationRecord
	
	validates :glucose_level, :created_at, presence: true

	belongs_to :user

    validate :check_report_count, on: :create

    def check_report_count
        if  Report.includes(:user).where(user_id: self.user_id).where('reports.created_at::date = :date', date: self.created_at.try(:to_date).try(:to_s)).count >= 4
            self.errors.add(:glucose_level, "Already entered maximum records count for the selected date")
    	end
    end

end