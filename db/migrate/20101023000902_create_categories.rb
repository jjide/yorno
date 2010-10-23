class CreateCategories < ActiveRecord::Migration
	def self.up
		create_table :categories do |t|
			t.string :name

			t.timestamps
		end

		add_column :polls, :category_id, :integer, :default=> 1
	end

	def self.down
		drop_table :categories
	end
end
