class CreateJoinTableInterviewUser < ActiveRecord::Migration[6.0]
  def change
    create_join_table :interviews, :users do |t|
      # t.index [:interview_id, :user_id]
      # t.index [:user_id, :interview_id]
    end
    add_foreign_key :interviews_users, :interviews
    add_foreign_key :interviews_users, :users
  end
end
