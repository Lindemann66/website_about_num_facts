Rails.application.routes.draw do
  root to: 'number_facts#index'

  get 'number_facts/index'
end
