module ReportsHelper
  def reports_list_columns
    header = [
      {label: t('report.name')},
      {label: t('report.glucose_level')},
      {label: t('report.created_at')},
    ]
    header << [{label: ''} ] if params[:controller] == 'reports'   	
  	return header.flatten
  end
end