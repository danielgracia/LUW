Rails.application.routes.draw do
  # Root should go to home
  root 'contents#home'

  # Login screen
  get '/login', to: 'logins#index', as: :login_index

  post '/login', to: 'logins#login', as: :login
  post '/logout', to: 'logins#logout', as: :logout
  post '/registrar', to: 'logins#register', as: :register

  # Content screens
  get '/postagens', to: 'contents#browse'
  get '/postagens/busca', to: 'contents#search'
  get '/postagem/nova', to: 'contents#new', as: :new_content
  get '/postagem/:id', to: 'contents#show', as: :show_content
  get '/postagem/:id/editar', to: 'contents#edit', as: :edit_content

  post '/postagem/criar', to: 'contents#create'
  post '/postagem/:id/salvar', to: 'contents#update'

  # Comment inside content screens
  post '/postagem/:content_id/comentario/criar', to: 'contents#comment'
  post '/postagem/:content_id/comentario/:comment_id/deletar', to: 'contents#delete_comment'

  ['upvote', 'downvote', 'novote'].each do |action|
    post "/postagem/:id/#{action}",
      to: "contents\##{action}",
      as: "content_#{action}"

    post "/comentario/:id/#{action}", 
      to: "contents\##{action}_comment",
      as: "comment_#{action}"
  end

  # Tags
  get '/sugestoes', to: 'tags#suggest'

  # Invite
  post '/convidar', to: 'invites#invite'

  # About
  get '/sobre', to: 'about#about'

end
