class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true

  def upvote!
    self.value = 1
    save
  end

  def downvote!
    self.value = -1
    save
  end

  def novote!
    self.value = 0
    save
  end

end