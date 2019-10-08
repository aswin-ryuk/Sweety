module ApplicationHelper

	def submit_btn_text(object)
		return  object.new_record? ? 'Add' : 'Update'
	end

	def get_title(type)
		if type == 'monthly'
			"Monthly Report"
		elsif type == 'daily'
			"Daily Report"
		else
			"Month to Date Report"
		end			
	end
	
end
