Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  scope module: :v1, path: '/api/v1' do
    get "/copy", to: 'airtables#copy'
    get "/copy/:key", to: 'airtables#copy_with_key'
  end
end
