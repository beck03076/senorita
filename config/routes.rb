Rails.application.routes.draw do
  resources :searches
  get 'favorito' => 'application#favorito'
  root to: 'searches#index'
end
