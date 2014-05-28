require pg
require sinatra

def db_connection
  begin
    connection = PG.connect(dbname: 'movies')

    yield(connection)

  ensure
    connection.close
  end
end

def get_movies()
  querry = "SELECT * FROM movies"
  movies = db_connection do |conn|
    conn.exec(querry)
  end
  movies = movies.to_a
  movies = movies.sort_by do |movie|
    movie["title"]
  end
  return movies
end

def get_actors()
  querry = "SELECT name FROM actors"
  actors = db_connection do |conn|
    conn.exec(querry)
  end
  actors = actors.to_a
  actors = actors.sort
  return actors
end


