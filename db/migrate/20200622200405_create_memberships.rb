class CreateMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :memberships do |t|
      t.references :team, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
