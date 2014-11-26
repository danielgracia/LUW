Rails.application.routes.draw do
  # Root should go to home
  root 'contents#home'

  # Login screen
  get '/login', to: 'logins#index'

  post '/login', to: 'logins#login'
  post '/logout', to: 'logins#logout'
  post '/registrar', to: 'logins#register'

  # Content screens
  get '/postagens', to: 'contents#browse'
  get '/postagens/busca', to: 'contents#search'
  get '/postagem/nova', to: 'contents#new'
  get '/postagem/:id', to: 'contents#show'
  get '/postagem/:id/editar', to: 'contents#edit'

  post '/postagem/criar', to: 'contents#create'
  post '/postagem/:id/salvar', to: 'contents#update'

  ['upvote', 'downvote', 'novote'].each do |action|
    post "/postagem/:id/#{action}", to: "contents\##{action}"
  end

  # Comment inside content screens
  post '/postagem/:content_id/comentario/criar', to: 'contents#comment'
  post '/postagem/:content_id/comentario/:comment_id/deletar', to: 'contents#delete_comment'

  # Invite
  post '/convidar', to: 'invites#invite'

end
