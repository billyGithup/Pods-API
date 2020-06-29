class ChangeColumnTypeBackToBoolean < ActiveRecord::Migration[6.0]
  def change
    change_column :teams, :active, :boolean
    change_column :memberships, :active, :boolean
  end
end
