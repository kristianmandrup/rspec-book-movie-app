class AddReleaseYearToMovies < ActiveRecord::Migration
  def self.up
    add_column :movies, :release_year, :date
  end

  def self.down
    remove_column :movies, :release_year
  end
end
