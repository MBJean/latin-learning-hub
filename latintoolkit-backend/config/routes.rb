Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # API routes
  namespace :api do
    namespace :v1 do
    	get '/dictionary/:lemma/', to: 'dictionary#show'
      resources :annotation, except: [:index]
      get "text_lookup" => "text_lookup#index", as: :author_path
      get "text_lookup/:short_name" => "text_lookup#by_short_name"
      get "text_lookup/:short_name/:text" => "text_lookup#by_text"
      get "text_lookup/:short_name/:text/:book" => "text_lookup#by_book"
      get "text_lookup/:short_name/:text/:book/:section" => "text_lookup#by_section"
      get "text_lookup/:short_name/:text/:book/:section/:line" => "text_lookup#by_line"
      get 'section/:id/' => 'section#show'
    end
  end
end
