Rails.application.routes.draw do
  # Root should go to home
  root 'users#home'

  # Login screen
  get '/login', to: 'login#index'

  post '/login', to: 'login#login'
  post '/login/logout', to: 'login#logout'
  post '/login/registrar', to: 'login#register'

  # Content screens
  get '/postagens', to: 'content#index'
  get '/postagens/busca', to: 'content#search'
  get '/postagem/nova', to: 'content#new'
  get '/postagem/:id', to: 'content#show'
  get '/postagem/:id/editar', to: 'content#edit'

  post '/postagem/criar', to: 'content#create'
  post '/postagem/:id/salvar', to: 'content#update'

  ['upvote', 'downvote', 'novote'].each do |action|
    post "/postagem/:id/#{action}", to: "content\##{action}"
  end

  # Comment inside content screens
  post '/postagem/:id/comentario/criar', to: 'content#comment'
  post '/postagem/:id/comentario/:comment_id/deletar', to: 'content#delete_comment'

  # Invite
  post '/convidar', to: 'invite#invite'

end
