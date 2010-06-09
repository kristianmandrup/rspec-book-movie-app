When /^I create a movie Caddyshack in the Comedy genre$/ do 
  visit movies_path 
  click_link "Add Movie"
  fill_in "Title", :with => "Caddyshack" 
  select "1980", :from => "Release Year" 
  check "Comedy" 
  click_button "Save"
end

Then /^Caddyshack should be in the Comedy genre$/ do
  visit genres_path 
  click_link "Comedy" 
  page.should have_content("1 movie")
  page.should have_content("Caddyshack")
end
  