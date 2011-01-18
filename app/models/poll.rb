class Poll < ActiveRecord::Base
	belongs_to :category
	has_attached_file :photo,
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => "/:style/:filename",
                    :styles =>{
                        :large => "480x320"
                    }



  
  has_attached_file :photo2,
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => "/:style/:filename",
                    :styles =>{
                        :large => "480x320"
                    }
end
