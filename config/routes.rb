Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      root "movies#index"

      resources :movies, only: %i[index] do
        get :availability, on: :member
        get :recommendations, on: :collection
        get :search, on: :collection
      end

      resources :rentals, only: %i[create] do
        put :bring_back, on: :member
        get :history_by_user, on: :collection
        get :active_by_user, on: :collection
      end
    end
  end
end
