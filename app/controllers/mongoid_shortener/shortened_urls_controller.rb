module MongoidShortener
  class ShortenedUrlsController < ApplicationController
    # find the real link for the shortened link key and redirect
    def translate
      # pull the link out of the db
      sl = ShortenedUrl.where(:unique_key => params[:unique_key][1..-1]).first

      if sl
        sl.inc(:use_count, 1)
        # do a 301 redirect to the destination url
        head :moved_permanently, :location => sl.url
      else
        # if we don't find the shortened link, redirect to the root
        # make this configurable in future versions
        head :moved_permanently, :location => main_app.root_url
      end
    end
  end
end
