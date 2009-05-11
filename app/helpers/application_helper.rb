# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def sidebar(collection, options={})
    raise 'link option required' unless options[:link]
    
    options[:title] ||= lambda {|item| item.name.to_s }
    
    render :partial => "shared/sidebar",
           :locals => { :collection => collection,
                        :title => options[:title],
                        :after_link => options[:after_link] || nil,
                        :link => options[:link] }
  end
  
  def nice_date(date)
    h date.strftime("%A %d %B %Y - %H:%M %p")
  end


end
