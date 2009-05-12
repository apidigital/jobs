module PositionsHelper
	def fields_for_question(question, &block)
		prefix = question.new_record? ? 'new' : 'existing'
		fields_for("position[#{prefix}_question_attributes][]", question, &block)
	end
	
	def add_question_link(name)
		link_to_function name do |page| 
			page.insert_html :bottom, :questions, :partial => "question", :object => Question.new
		end
	end
end
