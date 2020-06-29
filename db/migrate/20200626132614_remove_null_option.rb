class RemoveNullOption < ActiveRecord::Migration[6.0]
  def change
    change_column_null :teams, :active, false
    change_column_null :memberships, :active, false
  end
end
