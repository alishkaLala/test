Traking::Application.routes.draw do
 
  resources :tickets, :only => [:new,:create]
  resources :comments, :only =>[:create]
  
  root :to => "tickets#new"
  
  match '/show_ticket/:reference' => 'tickets#show_ticket_by_reference', :as => :show_ticket_by_reference
  
   
  namespace :staff do
    resources :ticket_departments, :ticket_statuses, :only => [:index,:create,:destroy] 
    resources :ticket_histories
    
    
    resources :tickets, :except => [:new, :create, :destroy] do
      member do
        put :update_fields
      end
    
    end
    
    root :to => "tickets#index"
  end
  
  namespace :admin do
    resources :staffs, :only => [:index, :new, :create, :destroy]
    root :to => "staffs#index"
  end
  
  
  
  controller :sessions do
    get 'log' => :new
    post 'log' => :create
    delete 'logout' => :destroy
  end    

end
