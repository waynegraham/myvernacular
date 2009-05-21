require 'rubygems'
require 'test/unit'
require 'flickr'

class FlickrClientTest < Test::Unit::TestCase
  
  def client
    @client ||= Flickr::Client
  end
  
  def test_respond_to_default_params
    assert client.respond_to? :default_params
  end
  
  def test_default_params_are_blank
    assert_equal({}, client.default_params)
  end
  
  def test_default_params_can_be_set
    settings = {:api_key => 'blah'}
    client.default_params settings
    assert_equal settings, client.default_params
  end
  
  def test_format
    assert_equal :json, client.default_options[:format]
  end
  
  def test_base_uri
    assert_equal 'http://api.flickr.com/services/rest', client.default_options[:base_uri]
  end
  
  def test_the_flickrize_params_method
    expected = {:method=>'flickr.photos.search', :text=>'blah'}
    flickrized_params = client.flickrize_params('photos.search', :text=>'blah')
    assert_equal expected, flickrized_params
  end
  
  # send out a request to flickr, this will fail because there is no api_key set
  # a mock connection would be better here...
  def test_a_request
    response = client.get 'test.echo'
    assert response =~ /stat="fail"/
    assert response =~ /code="100"/
    assert response =~ /msg="Invalid API Key \(Key not found\)"/
  end
  
end