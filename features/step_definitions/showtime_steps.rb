Given /^a movie$/ do 
  @movie = Movie.create!
end

When /^I set the showtime to "([^\"]*)" at "([^\"]*)"$/ do |date, time| 
  @movie.update_attribute(:showtime_date, Date.parse(date)) 
  @movie.update_attribute(:showtime_time, time)
end

Then /^the showtime description should be "([^\"]*)"$/ do |showtime| 
  @movie.showtime.should == showtime
end