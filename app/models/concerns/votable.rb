module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable  
  end

  def upvote_by(user)
    self.votes.find_or_initialize_by(user: user).upvote!
  end

  def downvote_by(user)
    self.votes.find_or_initialize_by(user: user).downvote!
  end

  def novote_by(user)
    self.votes.find_or_initialize_by(user: user).novote!
  end

  def update_score
    self.update_columns(score: self.votes.sum(:value))
  end

end