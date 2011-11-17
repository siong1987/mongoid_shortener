Rails.application.routes.draw do
  mount MongoidShortener::Engine => "/mongoid_shortener"
end
