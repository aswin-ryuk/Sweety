class ReportsController < ApplicationController

    load_and_authorize_resource

    def index
        unless  params[:id].present?
          @report = Report.new 
        else
          @report = Report.where(id: params[:id]).first
        end
        user_report
        refresh_table
    end

    def create
        @report = Report.new(report_params)
        @report.user_id = helpers.current_user.id
        if @report.save
          flash[:notice] = t('common.created',model_name: Report.model_name)
          redirect_to reports_path
        else
          user_report
          render :index
        end
    end

    def update
        if @report.update_attributes(report_params)
          flash[:notice] = t('common.updated',model_name: Report.model_name)
          redirect_to reports_path
        else
          user_report
          render :index
        end
    end

    def destroy_record
        if @report.present? && @report.destroy
          flash[:notice] = t('common.deleted',model_name: Report.model_name)
        end    
        render js: "window.location = '#{reports_path}'"
    end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
        params.require(:report).permit(:glucose_level, :created_at)
    end

    def user_report
        @reports = Report.includes(:user).where(user_id: helpers.current_user.id).order('reports.created_at DESC').paginate :per_page => PER_PAGE, :page => params[:page]
    end

  end
