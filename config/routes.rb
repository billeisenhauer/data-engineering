Lschallenge::Application.routes.draw do
  
  ### ROOT ###
  
  root :to => "subsidiary_imports#new"
  
  ### RESOURCES ###
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources  :users, :only => :show  
  resources  :subsidiary_imports, :except => [:index, :edit, :destroy]

end
