Rails.application.routes.draw do
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :msas, only: [] do
        collection do
          get :by_zip
        end
      end
    end
  end
  resources :home, only: :index
  resources :msas, only: [] do
    collection do
      get :by_zip
      post :by_zip
    end
  end
end
