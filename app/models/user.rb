class User < ActiveRecord::Base
  has_many :contents
  has_many :comments
  has_many :invites
  has_many :votes
  
  has_secure_password

  attr_accessor :invite_token

  validate :must_have_valid_invite, on: :create, unless: ->{ Rails.env.development? }

  before_create :use_invite_token, unless: ->{ Rails.env.development? || self.invite_token.blank? }
  
  def update_reputation
    content_reputation = self.contents.sum(:score)
    comment_reputation = self.comments.sum(:score)
    self.reputation = content_reputation + comment_reputation
    self.save
  end

  def ban!
    self.update_columns(banned: true)
  end

  protected
  def must_have_valid_invite
    invite = Invite.find_by(token: self.invite_token)
    if invite.blank? || invite.used?
      errors.add(:base, "Você não tem um convite!")
    end
  end

  def use_invite_token
    Invite.find_by(token: self.invite_token).use!
  end

end
