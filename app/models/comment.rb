class Comment < ActiveRecord::Base

	belongs_to :user
	belongs_to :post
	
	validates :body, presence:true

# By validating :user and :post, we validate based on associated objects. 
# Another way is to validate using the foreign keys: :user_id and post_id, 
# I read from another student this is not as robust as the validations below.

	validates :user, presence:true
	validates :post, presence:true

# Validating :user and :post will check that associated object exists, 
# while validating on foreign key will only check that a key was entered, 
# but not whether that :user_id or :post_id actually exist in the other models.

end
