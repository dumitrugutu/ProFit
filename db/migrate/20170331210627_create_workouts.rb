class CreateWorkouts < ActiveRecord::Migration[5.0]
  def change
    create_table :workouts do |t|
      t.integer :duration
      t.text :type
      t.date :date
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
