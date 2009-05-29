class BuildingsController < ApplicationController
  
  resource_controller
  
  before_filter :require_user, :except => [:index, :show, :feed]
  
  def feed
    @buildings = Building.find(:all)
  end
  
end