# Cucumber BDD Recipe for Movie App # 

<code>$ cucumber -t @focus</code>

## Create Movie model ##
<pre><code>
$ rails g model movie showtime_date:date showtime_time:time
$ rake db:migrate && rake db:test:prepare 
</code></pre>

<pre><code>
class Movie < ActiveRecord::Base
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
</code></pre>

## Create Genre model ##
<pre><code>
$ rails g model genre name:string
$ rake db:migrate && rake db:test:prepare
</code></pre>

## Create Movies controller ##
<code>$ rails g controller Movies index new</code>

*movies_controller.rb*
<pre><code>
class MoviesController < ApplicationController
  def index
  end

  def new
    @movie = Movie.new
    @genres = Genre.all
  end
  
  def create
    redirect_to movies_path
  end
end
</code></pre>


## Create Movies views ##
<pre><code>
<%= link_to "Add Movie", new_movie_path %>
</code></pre>

*movies/new.html.erb*
<pre><code>
<%= form_for @movie do |f| %>
  <label>
    Title
    <%= f.text_field :title %>
  </label>
  
  <label>
    Release Year
    <%= f.select :release_year, (1900..2009).to_a.map(&:to_s) %>
  </label>
  
  <% @genres.each do |genre| %>
    <label>
      <%=h genre.name %>
      <%= check_box_tag "genres[]", genre.id %>
    </label>
  <% end %>
  
  <%= f.submit "Save"   %>
<% end %>
</code></pre>

## Add movies REST resources to routes ##
*routes.rb*
<pre><code>
  resources :movies
</code></pre>

## Add more attributes to movies ##
<pre><code>
$ rails g migration add_title_to_movies title:string
$ rails g migration add_release_year_to_movies release_year:date
$ rake db:migrate && rake db:test:prepare
</code></pre>

## Create GenresMovies join table ##
<code>$ rails g migration create_genres_movies</code>

<pre><code>
class CreateGenresMovies < ActiveRecord::Migration
  def self.up
    create_table :genres_movies, :id => false, :force => true do |t|
      t.integer :genre_id
      t.integer :movie_id
      t.timestamps
    end
  end

  def self.down
    drop_table :genres_movies
  end
end
</code></pre>

## Create Genres controller ##
<code>$ rails g controller Genres index show</code>

<pre><code>
class GenresController < ApplicationController  
  def index
    @genres = Genre.all
  end
  
  def show
    @genre = Genre.find(params[:id])
  end  
end
</code></pre>

## Add genres REST resources to routes ##
*routes.rb*
<pre><code>
  resources :products, :movies, :genres 
</code></pre>

## Create Genre views ##

*genres/index.html.erb*
<pre><code><% @genres.each do |genre| %>
  <%= link_to genre.name, genre %>
<% end %>
</code></pre>

*genres/show.html.erb*
<pre><code><%=h @genre.name %>
<%= @genre.movies.count %> movie
<% @genre.movies.each do |movie| %>
  <%= link_to movie.title, movie %>
<% end %>
</code></pre>

## Implement create movies controller action ##
*movies_controller.rb*
<pre><code>def create
  movie = Movie.create!(params[:movie]) # create movie
  genres = Genre.find(params[:genres]) # find genres
  movie.genres = genres # add genres to movie
  movie.save! # save movie
  redirect_to movies_path # go to movie index page
end
</code></pre>

## Add Movies to Genre ##

*models/genre.rb*
<pre><code>class Genre < ActiveRecord::Base
  has_and_belongs_to_many :movies
end
</code></pre>

## Add Genres to movies ##

*models/movie.rb*
<pre><code>class Movie < ActiveRecord::Base
  has_and_belongs_to_many :genres
  # ...
end
</code></pre>

## Create 'Comedy' Genre in Database

<pre><code>$ rails c
> Genre.create(name:"Comedy")
> exit
</code></pre>

## Change DSL to Capybara syntax ##

*movie_steps.rb*
<pre><code>Then /^Caddyshack should be in the Comedy genre$/ do
  visit genres_path 
  click_link "Comedy" 
  page.should have_content("1 movie")     # Capybara DSL
  page.should have_content("Caddyshack")  
end                                                     
</code></pre>




  
