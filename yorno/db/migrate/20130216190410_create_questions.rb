class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :question_text
      t.boolean :question_ans

      t.timestamps
    end
  end
end
