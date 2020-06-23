class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :lead, null: false
      t.boolean :active, null: false

      t.timestamps
    end
  end
end
