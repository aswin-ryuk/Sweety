require 'rails_helper'
require_relative "../support/devise"

RSpec.describe ReportGenerationsController, type: :controller do

	context "Access report generation controller" do
		before(:each) do
			sign_in FactoryGirl.create(:user)
			id = User.last.id
			@report = FactoryGirl.create(:report, created_at: Date.today-20, user_id: id)  
		end

		describe "Generate report" do             
			it "should generate report for daily report type" do        
				post :generate_report, params: { report: {type: 'daily', date: Date.today-10}}
				expect(response).to be_success
			end
			it "should generate report for month to date report type" do        
				post :generate_report,  params: { report: {type: 'month_to_date', date: Date.today-10} }
				expect(response).to be_success
			end
			it "should generate report for monthly report type" do        
				post :generate_report,  params: { report: {type: 'monthly', date: Date.today-10} }
				expect(response).to be_success
			end
			it "should not generate report with in valid params " do        
				post :generate_report,   params: { report: {type: '', date: Date.today} }
				expect(response).to render_template('report_generations/index')
			end
		end

		describe "Generate csv report" do             
			it "should generate csv report" do
				post :generate_report,  params: { report: {type: 'monthly', date: Date.today-10}}
				get :export_csv
				expect(response).to be_success  
			end
		end

	end

end

