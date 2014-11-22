class User < ActiveRecord::Base
  has_many :contents
  has_many :comments
  has_many :invites
  
  has_secure_password
  
  def update_reputation
    content_reputation = self.contents.sum(:score)
    comment_reputation = self.comments.sum(:score)
    self.reputation = content_reputation + comment_reputation
    self.save
  end

  def ban!
    self.update_columns(banned: true)
  end
  
end
