class Building < ActiveRecord::Base
  
  belongs_to :user
  
  has_many :notes, :class_name=>'BuildingNote'
  
  validates_presence_of :name
  validates_presence_of :country
  validates_numericality_of :lat, :allow_nil=>true
  validates_numericality_of :lon, :allow_nil=>true
  
end