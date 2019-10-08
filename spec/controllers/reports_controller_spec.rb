require 'rails_helper'
require_relative "../support/devise"

RSpec.describe ReportsController, type: :controller do

	context "Access reports controller" do
		before(:each) do
			sign_in FactoryGirl.create(:user)
			id = User.last.id
			@report = FactoryGirl.create(:report, created_at: Date.today-10, user_id: id)  
		end

		describe "GET #index" do             
			it "should render all the reports" do        
				get :index  
				expect(response).to be_success
			end
		end

		describe "Create report" do             
			it "should not create invalid report" do
				post :create, params: { report: {glucose_level: '', created_at: Date.today-10} }
				expect(response).to render_template('reports/index')
			end

			it "should create a valid report" do
				post :create, params: { report: {glucose_level: 150, created_at: Date.today-15} }
				expect(response).to redirect_to(reports_path)   
			end
		end

		describe "Update report" do             
			it "should update a valid report" do
				put :update,params: { id: @report.id,  report: {glucose_level: 160} }
				expect(response).to redirect_to(reports_path)
			end

			it "should not update invalid report" do
				put :update, params: { id: @report.id,  report: {glucose_level: ''} }
				expect(response).to render_template('reports/index')
			end
		end

		describe "Delete report" do             
			it "should delete the report" do 
				get :destroy_record, xhr: true ,params: { id: @report.id}
				expect(response).to be_success  
			end
		end

	end

end
