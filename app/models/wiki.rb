class Wiki < ApplicationRecord
  #updating user association with optional: true fixed the failure error, User must exist
  belongs_to :user, optional: true

end
