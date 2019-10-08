class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :authenticate_user!

  PER_PAGE = 10

  include ExportCsv

  def refresh_table
    respond_to do |format|
      format.html {} # Do nothing, so Rails will render the view list.html
      format.js do
        @element_id, @partial, @params = "#{params[:controller]}_div", 'list', params
        render 'shared/replace_data'
      end
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

end
