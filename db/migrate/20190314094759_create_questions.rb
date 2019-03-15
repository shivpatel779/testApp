class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.integer :pri
      t.string :question
      t.string :teaming_stages
      t.integer :appears_day
      t.integer :frequency
      t.string :question_type
      t.string :conditions
      t.integer :mapping_id
      t.string :required?
      t.timestamps
    end
  end
end
