class Image < ActiveRecord::Base
  attr_accessible :image_file_name, :image_content_type, :image_file_size, :image_width, :image_height, :article_id, :image, :image_alt_text
  
  belongs_to :article
  
  has_many :article_images
  has_many :articles, :through => :article_images
  
  validates :image_alt_text, :presence => true
  
  has_attached_file :image,
                    :storage => :s3,
                    :bucket => 'media.kellysmithholbourn.com',
                    :s3_credentials => {
                      :access_key_id => ENV['S3_KEY'],
                      :secret_access_key => ENV['S3_SECRET']
                    },
                    :styles => {
                          :thumb  => "100x100>",
                          :small  => "450x450>" 
                          },
                    :path => "/public/system/:attachment/:style/:id.:extension",
                    :default_url => "/images/:style/raccoon.jpg"
end
