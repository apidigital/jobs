class Antiword
  
  def initialize(file)
    case file.class.to_s
    when "String"
      @file = file if File.exists?(file)
    when "File"
      @file = file.path
    end
    if File.extname(@file) == ".doc"
      @text = `antiword -t #{@file}`
    else
      raise ArgumentError, "Must be a Word 97-2003 Document"
    end
  end
  
  def to_s
    @text
  end
  
end
