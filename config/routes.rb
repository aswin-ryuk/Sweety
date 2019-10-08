Rails.application.routes.draw do
 
  devise_for :users, controllers: { registrations: 'registrations'}, path_names: {sign_in: 'login', sign: 'logout'}

	concern :export_csv do  	
  		get :export_csv, on: :collection 
	end
  
  resources :abouts, only: :index
 
  resources :reports, except: [:show] do
		collection do
			get :destroy_record
		end
  end
 
   resources :report_generations, concerns: [:export_csv], only:  [:index] do
		collection do
			post :generate_report
			get  :generate_report
		end
  end


	#root to: "devise/sessions#new"

	#root :to => redirect("/users/login")
	root :to => "reports#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
