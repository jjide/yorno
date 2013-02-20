class CreatePolls < ActiveRecord::Migration
  def self.up
    create_table :polls do |t|
      t.string :question
      t.integer :yeses
      t.integer :nos

      t.timestamps
    end
  end

  def self.down
    drop_table :polls
  end
end
