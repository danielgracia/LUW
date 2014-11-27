class Content < ActiveRecord::Base
  include Votable
  include ActionView::Helpers::SanitizeHelper

  MAX_CHARS_ON_PREVIEW = 200

  attr_accessor :raw_tags

  belongs_to :user
  has_many :comments, -> { order(created_at: :asc) }
  has_and_belongs_to_many :tags

  before_save :process_tags

  def process_tags
    if self.raw_tags.present?
      self.tags = self.raw_tags.split(",").map do |tag|
        Tag.find_or_create_by(body: tag)
      end
    else
      self.tags = []
    end
  end

  def preview
    self.strip_tags(self.body)[0,MAX_CHARS_ON_PREVIEW]
  end
end
