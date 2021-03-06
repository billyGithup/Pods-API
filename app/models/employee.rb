class Employee < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships, dependent: :destroy

  validates_presence_of :first_name, :last_name, :email
  validates :first_name, :last_name, format: {with: /\A^[[:alpha:]\.\'[:blank:]]+$\z/}
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}
end
