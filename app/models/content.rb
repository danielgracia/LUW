class Content < ActiveRecord::Base
  belongs_to :user

  has_many :votes, as: :votable

  def upvote_by(user)
    self.votes.find_or_initialize_by(user: user).upvote!
  end

  def downvote_by(user)
    self.votes.find_or_initialize_by(user: user).downvote!
  end

  def novote_by(user)
    self.votes.find_or_initialize_by(user: user).novote!
  end

end
