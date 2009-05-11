class Resume < ActiveRecord::Base
  belongs_to :user
  has_attachment :content_type => ['application/pdf', 'application/msword', 'text/plain', 'text/rtf', 'application/vnd.oasis.opendocument.text'],
                 :storage => :file_system, :path_prefix => 'public/files',
                 :size => 1.megabyte
  validates_presence_of :filename
  #validates_as_attachment
end
