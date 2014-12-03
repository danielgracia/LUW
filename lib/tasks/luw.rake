namespace :luw do

  desc "Populate default tags"
  task tags: :environment do
    IO.readlines(Rails.root.join('lib', 'tags.txt').to_s).each do |tag|
      Tag.create! body: tag.strip
    end
  end

end
