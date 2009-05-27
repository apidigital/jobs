class Resume < ActiveRecord::Base
  belongs_to :user
  has_attachment :content_type => ['application/pdf', 'application/msword', 'text/plain', 'text/rtf', 'application/vnd.oasis.opendocument.text'],
                 :storage => :file_system, :path_prefix => 'public/files',
                 :size => 1.megabyte
  validates_presence_of :filename
  #validates_as_attachment
  
  def neat
	  case File.extname(RAILS_ROOT + "/public" + self.public_filename)
    when ".doc"
      @resume = Antiword.new(RAILS_ROOT + "/public" + self.public_filename).to_s 
    when ".txt"
      @resume = File.open(RAILS_ROOT + "/public" + self.public_filename).readlines.to_s
    when ".rtf"
      @resume = Unrtf.new(RAILS_ROOT + "/public" + self.public_filename).to_s
    end
  end
end
