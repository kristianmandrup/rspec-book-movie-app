Given /^a genre named Comedy$/ do 
  @comedy = Genre.create!(:name => "Comedy")
end