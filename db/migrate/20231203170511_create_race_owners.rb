class CreateRaceOwners < ActiveRecord::Migration[7.1]
  def change
    create_table :race_owners do |t|
      t.references :user, null: false, foreign_key: true
      t.references :race, null: false, foreign_key: true

      t.timestamps
    end
  end
end
