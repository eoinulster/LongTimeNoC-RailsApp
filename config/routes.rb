Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root to: redirect('/session/new')

    resource :session, only: [:new, :create, :destroy]

    resources :users, only: [:show, :new, :create] do
      resources :events, only: [:index, :show]
      resources :closecontacts, only: [:index, :show]
    end
    
    resources :events, only: [:new, :create, :edit, :update, :destroy]
    resources :closecontacts, only: [:new, :create, :edit, :update, :destroy]


  end
