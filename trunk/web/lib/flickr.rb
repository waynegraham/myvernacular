require 'rubygems'
require 'httparty'
require 'nokogiri'

class Flickr
  
  class Client
    
    include HTTParty
    
    format :xml
    base_uri 'http://api.flickr.com/services/rest'
    
    class << self
      
      def user_photos(userid)
        get '', :query=>{:method => 'flickr.people.getPublicPhotos', :user_id => userid}
      end
      
      def photo(photo_id)
        get '', :query=>{:method => 'flickr.people.getPublicPhotos', :photo_id => photo_id}
      end
      
      def photo_location(photo_id)
        get '', :query=>{:method => 'flickr.photos.geo.getLocation', :photo_id => photo_id}
      end
      
    end
    
  end
  
end