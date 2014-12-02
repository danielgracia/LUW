class Tag < ActiveRecord::Base
  include PgSearch

  has_and_belongs_to_many :contents
  
  scope :search, ->(*tags) { where(body: tags) }

  pg_search_scope :autocomplete, ignoring: :accents,
    against: [:body],
    using: {
      tsearch: {
        prefix: true,
        dictionary: 'portuguese',
        tsvector_column: 'fulltext'
      }
    }
    
end