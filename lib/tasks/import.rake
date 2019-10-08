namespace :import do
  
  desc "Importing collection details to database"
  	task :collections => :environment do  		
  		errors = Array.new
      begin
    		file = "#{Rails.root}/public/collections.json"
    		collections = JSON.parse(File.read(file))
    		collections.each do |collection|
    			if Collection.new(collection.to_h).valid?
    				Collection.create(collection.to_h)
    			else
    				errors << collection
    			end
        end
        puts errors.inspect 
      rescue Exception => e
        puts e.inspect
      end
    end


  desc "Importing invoices details to database"
  	task :invoices => :environment do
      errors = Array.new
      begin
        file = "#{Rails.root}/public/invoices.json"
        invoices = JSON.parse(File.read(file))
        invoices.each do |invoice|
          if Invoice.new(invoice.to_h).valid?
            Invoice.create(invoice.to_h)
          else
            errors << invoice
          end
        end
        puts errors.inspect 
      rescue Exception => e
        puts e.inspect
      end
    end

end