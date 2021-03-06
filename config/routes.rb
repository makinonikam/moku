Rails.application.routes.draw do

  #top
  get root to: 'top#index'
  get "top/about" => "top#about"
  get 'terms_of_service' => 'top#terms_of_service'
  get 'bye' => 'top#bye'
  get 'thanks' => 'top#thanks'
  get 'privacy' => 'top#privacy'
  get 'check' => 'top#mailcheck'
  get 'how_to' => 'top#how_to'

  # accounts
  get 'accounts/:user_id' => 'accounts#edit'
  patch 'accounts/:user_id' => 'accounts#update'
  get 'accounts/:user_id/check' => 'accounts#check_delete'
  patch 'accounts/:user_id/delete' => 'accounts#delete'

  # announcements
  get 'announcements' => 'announcements#index'
  get 'announcements/new' => 'announcements#new'
  get 'announcements/:id' => 'announcements#show'
  post 'announcements/create' => 'announcements#create'
  get 'announcements/:id/edit' => 'announcements#edit'
  patch 'announcements/:id/update' => 'announcements#update'
  delete 'announcements/:id' => 'announcements#destroy'

  #book_marks
  get 'users/:user_id/book_marks' => 'book_marks#index'
  post '/users/:user_id/works/:work_id/book_marks' => 'book_marks#create'
  delete '/users/:user_id/works/:work_id/book_marks' => 'book_marks#destroy'

  #faqs
  get 'tags/:tag'=> 'faqs#index', as: :tag
  get 'faqs'          => 'faqs#index'
  get 'faqs/new'      => 'faqs#new'
  get 'faqs/:id'      => 'faqs#show'
  get 'faqs/:id/edit' => 'faqs#edit'
  post 'faqs'         => 'faqs#create'
  patch 'faqs/:id'    => 'faqs#update'
  delete 'faqs/:id'   => 'faqs#destroy'

  # mokus
  get '/users/:user_id/mokus/new' => 'mokus#new'
  get '/users/:user_id/mokus/:id/day' => "mokus#day_by_index"
  get '/ajax/justnow' => 'mokus#justnow'
  post '/ajax/mokus/create' => 'mokus#ajax_create'
  patch '/mokus/:id/finish' => 'mokus#finish'

  get 'users/:user_id/mokus/:moku_id/check' => 'mokus#check_delete'
  patch 'users/:user_id/mokus/:moku_id/delete' => 'mokus#delete'

  #moku_types
  get 'users/:user_id/moku_type/:moku_type_id/check' => 'moku_type#check_delete'
  patch 'users/:user_id/moku_type/:moku_type_id/delete' => 'moku_type#delete'

  #mypage
  get 'mypage/:user_id/edit' => 'mypage#edit'
  get 'mypage/:user_id' => 'mypage#show'
  get 'mypage' => 'mypage#index'
  # ↑application_controllerのafter_sign_in_path_for(resource)メソッドでログイン後はここがデフォになってるからuser_idはなくても大丈夫
  patch 'mypage/:user_id' => 'mypage#update'

  #works
  get '/users/:user_id/mokus/:moku_id/works/new' => 'works#new'
  post '/users/:user_id/mokus/:moku_id/works' => 'works#create'

  get 'users/:user_id/works/:work_id/check' => 'works#check_delete'
  patch 'users/:user_id/works/:work_id/delete' => 'works#delete'


  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
    :confirmations => 'users/confirmations'
   }

  get 'users/:user_id/works/:work_id/public' => 'works#for_public'
  delete 'works/:id/images/:image_id' => 'works#delete_image'

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end

  # regstrations/editでrootではなくmypageへ戻るための記述
  as :user do
    get 'mypage', :to => 'devise/registrations#edit', :as => :user_root
  end

  resources :users do
    resources :mokus,:moku_type,:works,:book_marks
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmls
end
