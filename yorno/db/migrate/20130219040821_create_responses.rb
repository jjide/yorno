class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :yes
      t.integer :no
      t.integer :count

      t.timestamps
    end
  end
end
