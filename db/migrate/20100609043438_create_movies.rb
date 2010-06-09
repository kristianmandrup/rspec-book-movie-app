class CreateMovies < ActiveRecord::Migration
  def self.up
    create_table :movies do |t|
      t.date :showtime_date
      t.time :showtime_time

      t.timestamps
    end
  end

  def self.down
    drop_table :movies
  end
end
