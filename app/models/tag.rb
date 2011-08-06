class Tag < ActiveRecord::Base
  attr_accessible :tag_name
  
  has_and_belongs_to_many :articles
end