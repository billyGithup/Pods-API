class Team < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :employees, through: :memberships, dependent: :destroy

  validates_presence_of :name, :lead
  validates :name, :lead, format: {with: /\A^[[:alpha:]\.\'[:blank:]]+$\z/}
end
