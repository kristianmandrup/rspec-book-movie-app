class AddTitleToMovies < ActiveRecord::Migration
  def self.up
    add_column :movies, :title, :string
  end

  def self.down
    remove_column :movies, :title
  end
end
