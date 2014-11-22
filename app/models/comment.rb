class Comment < ActiveRecord::Base
  include Votable

  belongs_to :user
  belongs_to :content
  
end
