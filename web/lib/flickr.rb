require 'rubygems'

# http://github.com/jnunemaker/httparty/tree/master
require 'httparty'

# http://github.com/tenderlove/nokogiri/tree/master
require 'json'

class Flickr
  
  class Client
    
    include HTTParty
    
    format :json
    
    base_uri 'http://api.flickr.com/services/rest'
    
    class << self
      
      # http://www.flickr.com/services/api/flickr.people.getPublicPhotos.html
      def user_photos(userid)
        get '', :query=>{:method => 'flickr.people.getPublicPhotos', :user_id => userid}
      end
      
      # http://www.flickr.com/services/api/flickr.photos.getSizes.html
      def photo_sizes(photo_id)
        get '', :query=>{:method => 'flickr.photos.getSizes', :photo_id => photo_id}
      end
      
      # http://www.flickr.com/services/api/flickr.photos.getWithGeoData.html
      def photo_location(photo_id)
        get '', :query=>{:method => 'flickr.photos.geo.getLocation', :photo_id => photo_id}
      end
      
    end
    
  end
  
end