class AddDefaultToActive < ActiveRecord::Migration[6.0]
  def change
    change_column_default :teams, :active, from: true, to: false
    change_column_default :memberships, :active, from: true, to: false
  end
end
