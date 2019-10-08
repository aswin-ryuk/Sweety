class ReportGenerationsController < ApplicationController

	load_and_authorize_resource

	def generate_report
		if ((params.dig(:report, :type).present? && params.dig(:report, :date).present?) || params[:page].present?)
			params[:page].present? ? page_params : report_params
			session[:r_type], session[:r_date]  = params[:report][:type], params[:report][:date] if params.dig(:report, :type).present?
			if session[:r_type] == 'daily'
				reports = Report.includes(:user).where(user_id: helpers.current_user.id).where('reports.created_at::date = :date', date: session[:r_date])
			elsif session[:r_type] == 'month_to_date'
				reports = Report.includes(:user).where(user_id: helpers.current_user.id).where('reports.created_at::date between :from and :to', from: session[:r_date].to_date.beginning_of_month, to: session[:r_date].to_date)
			else
				reports = Report.includes(:user).where(user_id: helpers.current_user.id).where('reports.created_at::date <= :date', date: session[:r_date])
			end
			@report_max_g_level = reports.maximum(:glucose_level)
			@report_min_g_level = reports.minimum(:glucose_level)
			@report_avg_g_level = reports.average(:glucose_level).to_i		
			@result = reports.order('reports.created_at DESC').paginate :per_page => PER_PAGE, :page => params[:page]
			@report_type = session[:r_type]
			session[:report] = reports
			session[:report_type] = [@report_type, @report_max_g_level, @report_min_g_level, @report_avg_g_level, reports.first.try(:user).try(:username)]
			@data = []
			reports.each do |r|
				@data << [r.created_at.strftime('%m-%d-%Y %H:%M:%S'), r.glucose_level]
			end
			refresh_table
		else
			flash[:error] = t('report_generation.req_fields')
			render :index
		end
	end

	def export_csv
		content = generate_report_list(session[:report], view_context.reports_list_columns.collect{ |r| r[:label] }, session[:report_type])
		filename = "#{session[:report_type][0]}_report.csv"
		send_data  content, :type => 'text/csv', :filename =>  filename, :disposition => 'attachment'
	end

	private

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
    	params.require(:report).permit(:type,:date)
    end

    def page_params
    	params.permit(:page)
    end

end
