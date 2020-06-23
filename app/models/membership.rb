class Membership < ApplicationRecord
  belongs_to :team
  belongs_to :employee

  validates_presence_of :active
end
