module MongoidShortener
  class ShortenedUrl
    include Mongoid::Document
    include Mongoid::Timestamps

    field :url,        :type => String
    field :unique_key, :type => String
    field :use_count,  :type => Integer, :default => 0

    index({ url: 1 }, { unique: true })
    index({ unique_key: 1 }, { unique: true })

    URL_PROTOCOL_HTTP = "http://"

    REGEX_HTTP_URL = /^\s*(http[s]?:\/\/)?[a-z0-9]+([-.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\s*$/i
    REGEX_LINK_HAS_PROTOCOL = Regexp.new('\Ahttp:\/\/|\Ahttps:\/\/', Regexp::IGNORECASE)

    validates_format_of :url, :with => REGEX_HTTP_URL

    validates_presence_of :url
    validates_uniqueness_of :url

    validates_presence_of :unique_key
    validates_uniqueness_of :unique_key

    attr_accessible :url

    before_validation :clean_destination_url, :init_unique_key, :on => :create

    # ensure the url starts with it protocol
    def clean_destination_url
      if !self.url.blank? and self.url !~ REGEX_LINK_HAS_PROTOCOL
        self.url.insert(0, URL_PROTOCOL_HTTP)
      end
    end

    def init_unique_key
      # generate a unique key for the link
      begin
        self.unique_key = ShortenedUrl::count.encode62
      end while ShortenedUrl::where(:unique_key => self.unique_key).first
    end

    # generate a shortened link from a url
    # link to a user if one specified
    # throw an exception if anything goes wrong
    def self.generate!(orig_url)
      if !orig_url.blank? and orig_url !~ REGEX_LINK_HAS_PROTOCOL
        orig_url.insert(0, URL_PROTOCOL_HTTP)
      end

      # don't want to generate the link if it has already been generated
      # so check the datastore
      sl = ShortenedUrl.where(:url => orig_url).first

      return MongoidShortener.prefix_url + sl.unique_key if sl

      # create the shortened link, storing it
      sl = ShortenedUrl.create!(:url => orig_url)

      # return the url
      return MongoidShortener.prefix_url + sl.unique_key
    end

    # return shortened url on success, nil on failure
    def self.generate(orig_url)
      sl = nil

      begin
        sl = ShortenedUrl::generate!(orig_url)
      rescue
        sl = nil
      end

      return sl
    end
  end
end
