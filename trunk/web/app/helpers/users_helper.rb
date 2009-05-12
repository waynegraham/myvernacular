module UsersHelper
  
  # for dynamically rendering the "account" view fields
  def user_content_fields
    %W(
    login
    flickr_username
    first_name
    last_name
    email
    bio
    )
  end
  
end