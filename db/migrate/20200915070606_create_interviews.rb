class CreateInterviews < ActiveRecord::Migration[6.0]
  def change
    create_table :interviews do |t|
      t.datetime :startTime
      t.datetime :endTime

      t.timestamps
    end
  end
end
