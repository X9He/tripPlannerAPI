Rails.application.routes.draw do
  get 'gen/generate', to: 'gen#generate'
  resources :trips do
    resources :locations
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
