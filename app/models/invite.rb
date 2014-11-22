class Invite < ActiveRecord::Base
  def use!
    self.used = true
    self.save!
  end
  
end
