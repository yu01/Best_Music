Rails.application.routes.draw do
  devise_for :users

  get '/show', to:'user#show'
  get 'user/about'

  resources :posts do
    put :suit, on: :member
    put :day, on: :member
    put :toNew, on: :member
    member do
      put "like", to: "posts#upvote"
      put "dislike", to: "posts#downvote"
    end
  end

  root 'user#show'

  get '/admin', to:'tencet#index'
  get '/admin/all', to:'tencet#all'
  get '/admin/statistic', to:'tencet#statistic'
end
