module ExportCsv 
  require 'csv'

  def generate_report_list(conditions, header, type)
    rows = []
    # CSV header
    rows << ["Maximum Glucose level","Minimum Glucose level","Average Glucose level"]
    rows << [type[1], type[2],type[3]]
    rows << [""]
    rows << header
    # CSV data's rows
    conditions.each do |c| 
      rows << [ type[4], c["glucose_level"], c["created_at"].to_datetime.strftime('%d-%m-%Y %H:%M:%S') ]
    end
    # Convert array into csv string    
    create_csv(rows)
  end
  
  def create_csv(rows, enable_quote=false)
    CSV.generate(:col_sep => ";", force_quotes: enable_quote, encoding: 'ISO-8859-1') do |csv|
      rows.each do |r|
        csv << r
      end
    end
  end

end