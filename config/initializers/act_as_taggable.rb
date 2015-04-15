module ActsAsTaggableOn
	class Tagging < ::ActiveRecord::Base
	  after_save :reindex


	  def reindex
	    taggable.reload.reindex
	  end
	end
end
	  
