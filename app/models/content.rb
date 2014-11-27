class Content < ActiveRecord::Base
  include Votable

  attr_accessor :raw_tags

  belongs_to :user
  has_and_belongs_to_many :tags

  before_save :process_tags

  def process_tags
    self.tags = self.raw_tags.split(",").map do |tag|
      Tag.find_or_create_by(body: tag)
    end
  end

end
