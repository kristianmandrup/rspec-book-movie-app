class Movie < ActiveRecord::Base 
  has_and_belongs_to_many :genres
    
  def showtime 
    "#{formatted_date} (#{formatted_time})"
  end

  def formatted_date 
    showtime_date.strftime("%B %d, %Y")
  end

  def formatted_time 
    format_string = showtime_time.min.zero? ? "%l%p" : "%l:%M%p" 
    showtime_time.strftime(format_string).strip.downcase
  end
end
