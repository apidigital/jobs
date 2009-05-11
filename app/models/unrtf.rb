class Unrtf
  
  def initialize(file)
    case file.class.to_s
    when "String"
      @file = file if File.exists?(file)
    when "File"
      @file = file.path
    end
    if File.extname(@file) != ".rtf"
      raise ArgumentError, "Must be a Rich Text Document"
    end
  end
  
  def to_s
    `unrtf -n --noremap --text #{@file}`
  end
  
  def to_html
    `unrtf --html #{@file}`
  end
  
  def to_latex
    `unrtf --latex #{@file}`
  end
  
  def to_vt
    `unrtf --vt #{@file}`
  end
  
end
