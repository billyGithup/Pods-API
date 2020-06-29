class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :lead, :active, :created_at, :updated_at
  has_many :employees
end
