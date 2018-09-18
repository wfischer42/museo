# Museo

## Setup

* Fork [this Repository](https://github.com/turingschool-examples/museo)
* Clone YOUR fork
* Complete the activity below
* Push your solution to your fork
* Submit a pull request from your repository to the turingschool-examples repository
  * Make sure to put your name in your PR!

### Iteration 1: Create Photograph Class

Use TDD to create a `Photograph` and an `Artist` class that respond to the following interaction pattern:

```ruby
pry(main)> require './lib/photograph'

pry(main)> require './lib/artist'

pry(main)> attributes = {
  id: "1",
  name: "Rue Mouffetard, Paris (Boy with Bottles)",
  artist_id: "4",
  year: "1954"
}      

pry(main)> photograph = Photograph.new(attributes)
#=> #<Photograph:0x00007fc2d1050c80...>

pry(main)> photograph.id
#=> "1"

pry(main)> photograph.name
#=> "Rue Mouffetard, Paris (Boy with Bottles)"

pry(main)> photograph.artist_id
#=> "4"

pry(main)> photograph.year
#=> "1954"

pry(main)> attributes = {
  id: "2",
  name: "Ansel Adams",
  born: "1902",
  died: "1984",
  country: "United States"
}

pry(main)> artist = Artist.new(attributes)
#=> #<Artist:0x00007fc2d0a6c080...>

pry(main)> artist.id
#=> "2"

pry(main)> artist.name
#=> "Ansel Adams"

pry(main)> artist.born
#=> "1902"

pry(main)> artist.died
#=> "1984"

pry(main)> artist.country
#=> "United States"
```

### Iteration 2

Use TDD to create a `Curator` class that responds to the following interaction pattern:

```ruby
pry(main)> require './lib/curator'

pry(main)> curator = Curator.new
#=> #<Curator:0x00007fd3a0383dc8...>

pry(main)> curator.artists
#=> []

pry(main)> curator.photographs
#=> []

pry(main)> photo_1 = {
  id: "1",
  name: "Rue Mouffetard, Paris (Boy with Bottles)",
  artist_id: "1",
  year: "1954"
}

pry(main)> photo_2 = {
  id: "2",
  name: "Moonrise, Hernandez",
  artist_id: "2",
  year: "1941"
}

pry(main)> curator.add_photograph(photo_1)

pry(main)> curator.add_photograph(photo_2)

pry(main)> curator.photographs
#=> [#<Photograph:0x00007fd3a10cda60...>, #<Photograph:0x00007fd3a1801278...>]

pry(main)> curator.photographs.first
#=> #<Photograph:0x00007fd3a10cda60 @artist_id="1", @id="1", @name="Rue Mouffetard, Paris (Boy with Bottles)", @year="1954">

pry(main)> curator.photographs.first.name
#=> "Rue Mouffetard, Paris (Boy with Bottles)"

pry(main)> artist_1 = {
  id: "1"
  name: "Henri Cartier-Bresson",      
  born: "1908",      
  died: "2004",      
  country: "France"      
}      

pry(main)> artist_2 = {
  id: "2",      
  name: "Ansel Adams",      
  born: "1902",      
  died: "1984",      
  country: "United States"      
}      

pry(main)> curator.add_artist(artist_1)

pry(main)> curator.add_artist(artist_2)

pry(main)> curator.artists
#=> [#<Artist:0x00007fd3a02a8890...>, #<Artist:0x00007fd3a02d3130...>]

pry(main)> curator.artists.first
#=> #<Artist:0x00007fd3a02a8890 @born="1908", @country="France", @died="2004", @id="1", @name="Henri Cartier-Bresson">

pry(main)> curator.artists.first.name
#=> "Henri Cartier-Bresson"

pry(main)> curator.find_artist_by_id("1")
#=> #<Artist:0x00007fd3a02a8890 @born="1908", @country="France", @died="2004", @id="1", @name="Henri Cartier-Bresson">

pry(main)> curator.find_photograph_by_id("2")
#=> #<Photograph:0x00007fd3a1801278 @artist_id="2", @id="2", @name="Moonrise, Hernandez", @year="1941">
```

### Iteration 3

Use TDD to update your `Curator` class so that is supports the following methods:

* `find_photographs_by_artist(artist)` - This method takes an `Artist` object and returns an Array of all the Artist's photographs. A `Photograph` is linked to an `Artist` by its `artist_id`
* `artists_with_multiple_photographs` - This method returns an Array of all `Artist`s who have more than one photograph
* `photographs_taken_by_artists_from(string)` - This method takes a String representing a country. It returns an Array of `Photograph`s that were taken by a photographer from that country.

The `Curator` class should now respond to the following interaction pattern:

```ruby
pry(main)> photo_1 = {
  id: "1",
  name: "Rue Mouffetard, Paris (Boy with Bottles)",
  artist_id: "1",
  year: "1954"
}

pry(main)> photo_2 = {
  id: "2",
  name: "Moonrise, Hernandez",
  artist_id: "2",
  year: "1941"
}

pry(main)> photo_3 = {
  id: "3",
  name: "Identical Twins, Roselle, New Jersey",
  artist_id: "3",
  year: "1967"
}

pry(main)> photo_4 = {
  id: "4",
  name: "Child with Toy Hand Grenade in Central Park",
  artist_id: "3",
  year: "1962"
}

pry(main)> artist_1 = {
  id: "1",
  name: "Henri Cartier-Bresson",
  born: "1908",
  died: "2004",
  country: "France"
}

pry(main)> artist_2 = {
  id: "2",
  name: "Ansel Adams",
  born: "1902",
  died: "1984",
  country: "United States"
}

pry(main)> artist_3 = {
  id: "3",
  name: "Diane Arbus",
  born: "1923",
  died: "1971",
  country: "United States"
}

pry(main)> curator = Curator.new
#=> #<Curator:0x00007fa3c182da18...>

pry(main)> curator.add_photograph(photo_1)

pry(main)> curator.add_photograph(photo_2)

pry(main)> curator.add_photograph(photo_3)

pry(main)> curator.add_photograph(photo_4)

pry(main)> curator.add_artist(artist_1)

pry(main)> curator.add_artist(artist_2)

pry(main)> curator.add_artist(artist_3)

pry(main)> diane_arbus = curator.find_artist_by_id("3")
#=> #<Artist:0x00007fa3c13eef88 @born="1923", @country="United States", @died="1971", @id="3", @name="Diane Arbus">

pry(main)> curator.find_photographs_by_artist(diane_arbus)
#=> [#<Photograph:0x00007fa3c13a4050...>, #<Photograph:0x00007fa3c110e4a8...>]

pry(main)> curator.artists_with_multiple_photographs
#=> [#<Artist:0x00007fa3c13eef88 @born="1923", @country="United States", @died="1971", @id="3", @name="Diane Arbus">]

pry(main)> curator.artists_with_multiple_photographs.length
#=> 1

pry(main)> diane_arbus == curator.artists_with_multiple_photographs.first
#=> true

pry(main)> curator.photographs_taken_by_artists_from("United States")
#=> [#<Photograph:0x00007fa3c286b088...>, #<Photograph:0x00007fa3c13a4050...>, #<Photograph:0x00007fa3c110e4a8...>]

pry(main)> curator.photographs_taken_by_artists_from("Argentina")
#=> []
```

### Iteration 4

Use TDD to add the following methods to your `Curator` class:

* `load_photographs(file)` - This method takes a path to a CSV file containing photographs and adds them to the `Curator`. You may find the included `FileIO` class useful.
* `load_artists(file)` - This method takes a path to a CSV file containing artists and adds them to the `Curator`. You may find the included `FileIO` class useful.
* `photographs_taken_between(range)` - This method takes a range and returns an array of all photographs with a year that falls in that range.
* `artists_photographs_by_age(artist)`- This method takes an `Artist` object and return a hash where the keys are the Artists age when the took a photograph, and the values are the names of the photographs.

````ruby
pry(main)> require './lib/curator'

pry(main)> curator = Curator.new
#=> #<Curator:0x00007fd98685b2b0...>

pry(main)> curator.load_photographs('./data/photographs.csv')

pry(main)> curator.load_artists('./data/artists.csv')

pry(main)> curator.photographs_taken_between(1950..1965)
=> [#<Photograph:0x00007fd986254740...>, #<Photograph:0x00007fd986254678...>]

pry(main)> diane_arbus = curator.find_artist_by_id("3")    

pry(main)> curator.artists_photographs_by_age(diane_arbus)
=> {44=>"Identical Twins, Roselle, New Jersey", 39=>"Child with Toy Hand Grenade in Central Park"}
```
