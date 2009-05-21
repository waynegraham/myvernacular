# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # stores items for the layout to render at the top of the page (in the head tag)
  # ...for css link tags
  def html_top_items
    @html_top_items ||= []
  end
  
  # stores items for the layout to render at the bottom of the page (after the html tag)
  # ...for script tags
  def html_bottom_items
    @html_bottom_items ||= []
  end
  
end