class FlickrController < ApplicationController
  
  layout false
  
  DEFAULT_TERM = 'vernacular architecture'
  
  # an action that performs a flickr.photos.search lookup
  def photos
    response = photo_search
    photos_response = response['photos']
    @photos = photos_response['photo'].each{|p| p.extend Flickr::PhotoHelper }
    @per_page = photos_response['perpage']
    @total = photos_response['total']
    @pages = photos_response['pages']
    @page = photos_response['page']
  end
  
  protected
  
  # queries flickr using the photos.search method.
  # uses the :q, :page
  def photo_search
    user_id = username_to_userid(params[:username])
    plain_response = Flickr::Client.get('photos.search', {
      :text=>((params[:q].blank? and user_id.blank?) ? DEFAULT_TERM : params[:q]),
      :per_page=>20,
      :page => params[:page],
      :user_id => user_id,
      :privacy_filter => 1,
      #:has_geo => true,
      :sort => 'relevance'
    })
    # remove the callback method wrapper:
    hash_response = js_to_ruby plain_response
    raise hash_response['message'] unless hash_response['stat']=='ok'
    hash_response
  end
  
  def username_to_userid(name)
    return nil if name.blank?
    @username_lookups ||= {}
    @username_lookups[name] ||= (
      response = js_to_ruby Flickr::Client.get('people.findByUsername', :username=>name)
      response['stat'] == 'ok' ? response['user']['id'] : nil
    )
  end
  
  def js_to_ruby(response)
    ActiveSupport::JSON.decode response.sub(/^\w+\(/, '').sub(/\)$/, '')
  end
  
end