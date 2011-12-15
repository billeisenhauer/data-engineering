module Indestructable
  extend ActiveSupport::Concern
  
  included do
    before_destroy :prevent_deletion
  end
  
  module InstanceMethods

    def prevent_deletion
      errors.add(:base, "Record cannot be removed")
      false
    end
    private :prevent_deletion
  
  end
  
end