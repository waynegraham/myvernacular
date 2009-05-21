require 'rubygems'

# http://github.com/jnunemaker/httparty/tree/master
require 'httparty'

class Flickr
  
  class Client
    
    include HTTParty
    
    base_uri 'http://api.flickr.com/services/rest'
    
    format :plain
    
    class << self
      
      # "service_method" is the name of a flickr service, "photos.search"
      # params is a hash
      # get 'photos.search', :text=>'some text to search on'
      def get(service_method, params={})
        super('', :query => flickrize_params(service_method, params))
      end
      
      # adds the method query params and prepends "flickr."
      # returns a new hash
      def flickrize_params(service_method, params)
        params.merge :method => "flickr.#{service_method}"
      end
      
    end
    
  end
  
  # response['photos'].first.extend Flickr::PhotoHelper
  # response['photos'].first.thumb
  # response['photos'].first.full
  module PhotoHelper
    
    def thumb(size='s')
      t = "http://farm#{self['farm']}.static.flickr.com"
  		t += "/#{self['server']}"
  		t += "/#{self['id']}_#{self['secret']}_#{size}.jpg"
    end
    
    def full(size='s')
  		h = "http://farm#{self['farm']}.static.flickr.com"
  		h += "/#{self['server']}"
  		h += "/#{self['id']}_"
      case size
  			when 'm'
  				h += "#{self['secret']}_m.jpg"
  			when 'b'
  				h += "#{self['secret']}_b.jpg"
        when 'o'
  				if self['originalsecret'] and self['originalformat']
  					h += self['originalsecret'] + '_o.' + self['originalformat']
  				else
  					h += self['secret'] + '_b.jpg'
  				end
  			else
  				h += self['secret'] + '.jpg'
  			end
  		h
    end
    
  end
  
end