MongoidShortener::Engine.routes.draw do
  get '/:unique_key', :to => 'shortened_urls#translate', :constraints => { :unique_key => /~.+/ }
end
