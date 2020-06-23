class Team < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :employees, dependent: :destroy, through: :memberships

  validates_presence_of :name, :lead
  validates :name, :lead, format: {with: /\A[[:alpha:][:space:]]+\z/}
end
