Rails.application.routes.draw do
  # Root should go to home
  root 'users#home'

  # Login screen
  get '/login', to: 'logins#index'

  post '/login', to: 'logins#login'
  post '/login/logout', to: 'logins#logout'
  post '/login/registrar', to: 'logins#register'

  # Content screens
  get '/postagens', to: 'contents#index'
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
  post '/postagem/:id/comentario/criar', to: 'contents#comment'
  post '/postagem/:id/comentario/:comment_id/deletar', to: 'contents#delete_comment'

  # Invite
  post '/convidar', to: 'invites#invite'

end
