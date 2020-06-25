class ChangeColumnType < ActiveRecord::Migration[6.0]
  def change
    change_column :teams, :active, :string
    change_column :memberships, :active, :string
  end
end
