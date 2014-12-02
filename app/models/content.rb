class Content < ActiveRecord::Base
  include Votable
  include PgSearch
  include ActionView::Helpers::SanitizeHelper

  MAX_CHARS_ON_PREVIEW = 200

  attr_accessor :raw_tags

  NEWEST_RANKING = <<-SQL
    1 - LEAST(1, EXTRACT(EPOCH FROM (NOW() - contents.created_at))/7776000.0) * :tsearch
  SQL

  OLDEST_RANKING = <<-SQL
    (EXTRACT(EPOCH FROM (NOW() - contents.created_at))/7776000.0) * :tsearch
  SQL

  belongs_to :user
  has_many :comments, -> { order(created_at: :asc) }
  has_and_belongs_to_many :tags

  pg_search_scope :search, ->(query, rank_by: nil) {
    case rank_by
    when :best
      { ranked_by: "contents.score * :tsearch", order_within_rank: "contents.score DESC" }
    when :worst
      { ranked_by: "-contents.score * :tsearch", order_within_rank: "contents.score ASC" }
    when :newest
      { ranked_by: NEWEST_RANKING, order_within_rank: "contents.created_at DESC" }
    when :oldest
      { ranked_by: OLDEST_RANKING, order_within_rank: "contents.created_at ASC" }
    else
      {}
    end.merge({
      against: [:title, :body],
      query: query,
      ignoring: :accents,
      using: {
        tsearch: {
          dictionary: 'portuguese',
          tsvector_column: 'fulltext'
        }
      }
    })
  }

  scope :by_tags, ->(*tags){
    return where('') if tags.blank?
    includes(:tags).where(tags: { id: Tag.search(*tags).ids })
  }

  before_create :default_upvote
  before_save :process_tags

  def default_upvote
    self.upvote_by(self.user)
    self.update_score
  end

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
