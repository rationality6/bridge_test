Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  scope module: :v1, path: '/api/v1' do
    get "/copy", to: 'airtables#copy'
    get "/copy/refresh", to: 'airtables#refresh'
    get "/copy/intro.created_at", to: 'airtables#copy_with_key_created_at'
    get "/copy/intro.updated_at", to: 'airtables#copy_with_key_updated_at'
    get "/copy/:key", to: 'airtables#copy_with_key'

  end
end
