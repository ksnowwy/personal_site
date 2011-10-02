#AWS::S3::Base.establish_connection!(
#  :access_key_id     => ENV['S3_KEY'],
#  :secret_access_key => ENV['S3_SECRET']
   #:bucket => 'media.kellysmithholbourn.com',
#)

#if Rails.env == "production"
   #set credentials from ENV hash
#  S3_CREDENTIALS = { :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'] }
#else
   #get credentials from YML file
#  S3_CREDENTIALS = Rails.root.join("config/s3.yml")
#end

AWS::S3::Base.establish_connection!(
  S3_CREDENTIALS = { :access_key_id => 'AKIAJ62KHQE7H422ZMWA',
  :secret_access_key => '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' }
)