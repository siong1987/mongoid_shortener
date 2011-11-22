Rails.application.routes.draw do
  match '/:unique_key' => 'mongoid_shortener/shortened_urls#translate', :via => :get, :constraints => { :unique_key => "~.+" }
end
