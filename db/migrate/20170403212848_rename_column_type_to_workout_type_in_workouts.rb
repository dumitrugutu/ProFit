class RenameColumnTypeToWorkoutTypeInWorkouts < ActiveRecord::Migration[5.0]
  def change
    rename_column :workouts, :type, :workout_type
  end
end
