Rails.application.routes.draw do
  root 'static_pages#home'
  get  'post_new',       to: 'posts#new',    as: 'p_new'
  post 'post_create',    to: 'posts#create', as: 'p_create'
  get  'post_index',     to: 'posts#index',  as: 'p_index'
  get  'post_like',      to: 'posts#like',   as: 'p_like'
  get  'post_show/:id',  to: 'posts#show',   as: 'p_show'
  get  'post_edit/:id',  to: 'posts#edit',   as: 'p_edit'
  patch  'post_update/:id',    to: 'posts#update',  as: 'p_up'
  delete 'post_delete/:id',    to: 'posts#destroy', as: 'p_des'
  delete 'pic1_delete/:id',    to: 'posts#pic_des1', as: 'pic1_des'
  delete 'pic2_delete/:id',    to: 'posts#pic_des2', as: 'pic2_des'
  delete 'pic3_delete/:id',    to: 'posts#pic_des3', as: 'pic3_des'
  delete 'pic4_delete/:id',    to: 'posts#pic_des4', as: 'pic4_des'
  delete 'pic5_delete/:id',    to: 'posts#pic_des5', as: 'pic5_des'
  delete 'mov_delete/:id',     to: 'posts#mov_des',  as: 'mov_des'
  post  'posts/:post_id/comment',    to: 'comments#create', as: 'p_com'
  delete 'comment_delete/:id',    to: 'comments#destroy', as: 'com_des'
  post  'posts/:user_id/comment/:comment_id', to: 'replies#create', as: 'reply'
  delete 'reply_delete/:id',    to: 'replies#destroy', as: 'rep_des'
  resources :posts do
    resources :likes, only: [:create, :destroy]
  end
  
  resources :relationships,       only: [:create, :destroy]
  
  get  'user/new',       to: 'users#new',    as: 'u_new'
  post 'user/create',    to: 'users#create', as: 'u_create'
  get  'user/index',     to: 'users#index',  as: 'u_index'
  get  'user/show/:id',  to: 'users#show',   as: 'u_show'
  get  'user/status/:id',    to: 'users#status',  as: 'u_sts'
  get  'user/edit',      to: 'users#edit',   as: 'u_edit'
  patch'user/update',    to: 'users#update', as: 'u_up'
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  get    '/login',         to: 'sessions#new',       as: 'login'
  post   '/login',         to: 'sessions#create'
  delete '/logout',        to: 'sessions#destroy'
  get    '/edit',          to: 'sessions#edit',      as: 're_log'
  patch  '/update/login',        to: 'sessions#update',    as: 'log_upd'

  get  'room/index/:id',               to: 'rooms#index',   as: 'room'
  get  'chat/:room_id',                to: 'rooms#chat',    as: 'exist_room'
  get  'chat/:sender_id/:receiver_id', to: 'rooms#chat',    as: 'chat'
  delete 'room_delete/:id',            to: 'rooms#destroy', as: 'room_des'
  post 'message/send',                 to: 'messages#sending', as: 'm_send'
  delete 'message_delete/:id',         to: 'messages#destroy', as: 'mes_des'
  
  get 'search_func', to: 'search#search',  as: 'search_func'
  get 'result', to: 'search#result'
  
  resources :notifications, only: :index
  
  delete 'user_delete/:id', to: 'users#destroy', as: 'u_des'
  
  get  'consultation',      to: 'consultations#new',   as: 'consultation'
  post 'consultation_send', to: 'consultations#create',  as: 'cons_create'
  get  'acceptance',        to: 'consultations#accep', as: 'accep'
end