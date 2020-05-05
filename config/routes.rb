Rails.application.routes.draw do
  root 'home#index'

  resources :home, only: :index do
    collection do
      post :index
    end
  end

  resources :reports, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :msas, only: [] do
        collection do
          get :by_zip
        end
      end
    end
  end
end
