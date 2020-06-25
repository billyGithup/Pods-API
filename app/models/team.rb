class Team < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :employees, dependent: :destroy, through: :memberships

  validates_presence_of :name, :lead, :active
  validates :name, :lead, format: {with: /\A^[[:alpha:]\.\'[:blank:]]+$\z/}
  validates :active, format: {with: /\A^(?:Yes\b|No\b)\z/}
end
