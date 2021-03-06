require 'pg'

def db_connection
  begin
    connection = PG.connect(dbname: 'movies')

    yield(connection)

  ensure
    connection.close
  end
end

def get_movies()
  query = "SELECT movies.id, title, year, rating, genres.name as genre, studios.name as studio
            FROM movies
            LEFT JOIN studios on studios.id = movies.studio_id
            LEFT JOIN genres on genres.id = movies.genre_id"
  movies = db_connection do |conn|
    conn.exec(query)
  end
  movies = movies.to_a
  movies = movies.sort_by do |movie|
    movie["title"]
  end
  return movies
end

def get_actors()
  query = "SELECT id, name FROM actors"
  actors = db_connection do |conn|
    conn.exec(query)
  end
  actors = actors.to_a
  actors = actors.sort_by do |actor|
    actor["name"]
  end
  return actors
end

def get_actor(actor_id)
  query = "SELECT actors.id as actorID, actors.name as name, character
          FROM actors
          JOIN cast_members on cast_members.actor_id = actors.id
          JOIN movies on movies.id = cast_members.movie_id
          WHERE actors.id = $1 "
  actor = db_connection do |conn|
    conn.exec_params(query, [actor_id])
  end

  query = "SELECT movies.id as movieID, movies.title, character
            FROM actors
            JOIN cast_members on cast_members.actor_id = actors.id
            JOIN movies on movies.id = cast_members.movie_id
            WHERE actors.id = $1 "
  movies = db_connection do |conn|
    conn.exec_params(query, [actor_id])
  end
  actor = actor.to_a
  movies = movies.to_a
  return actor, movies
end

def get_movie(movie_id)
  query = "SELECT movies.id, title, year, rating, genres.name as genre, studios.name as studio, movies.synopsis
            FROM movies
            LEFT JOIN studios on studios.id = movies.studio_id
            LEFT JOIN genres on genres.id = movies.genre_id
            WHERE movies.id = $1"
  movie = db_connection do |conn|
    conn.exec_params(query, [movie_id])
  end
  query = "SELECT actors.id as actorID, actors.name as actor_name, character
            FROM movies
            JOIN cast_members on cast_members.movie_id = movies.id
            JOIN actors on actors.id = cast_members.actor_id
            WHERE movies.id = $1"
  cast = db_connection do |conn|
    conn.exec_params(query, [movie_id])
  end
  movie = movie.to_a
  cast = cast.to_a
  return movie, cast
end

