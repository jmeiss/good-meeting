GoodMeeting::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }


  authenticated do
    root :to => 'users#my_account'
  end


  root :to => 'pages#index'

end
