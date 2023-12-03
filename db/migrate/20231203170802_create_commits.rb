class CreateCommits < ActiveRecord::Migration[7.1]
  def change
    create_table :commits do |t|
      t.references :participant, null: false, foreign_key: true
      t.string :message

      t.timestamps
    end
  end
end
