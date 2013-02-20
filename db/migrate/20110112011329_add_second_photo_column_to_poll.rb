class AddSecondPhotoColumnToPoll < ActiveRecord::Migration
  def self.up
    add_column :polls, :photo2_file_name, :string, :null => true
    add_column :polls, :photo2_content_type, :string, :null => true
    add_column :polls, :photo2_file_size, :integer, :null => true
    add_column :polls, :photo2_updated_at, :datetime, :null => true
  end

  def self.down
    remove_column :polls, :photo2_file_name
    remove_column :polls, :photo2_content_type
    remove_column :polls, :photo2_file_size
    remove_column :polls, :photo2_updated_at
  end
end
