class CreateWods < ActiveRecord::Migration
  def change
    create_table :wods do |t|
      t.string :content
      t.string :exercise_details
      t.integer :user_id
    end
  end
end
