require 'pg'
require 'sinatra'

def db_connection
  begin
    connection = PG.connect(dbname: 'movies')

    yield(connection)

  ensure
    connection.close
  end
end

def get_movies()
  querry = "SELECT id, title, year, rating, genres.name as genre, stuidos.name as studio
            FROM movies
            LEFT JOIN sudios on studios.id = movies.stuido_id
            LEFT JOIN genres on genres.id = movies.genre_id"
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
  querry = "SELECT id, name FROM actors"
  actors = db_connection do |conn|
    conn.exec(querry)
  end
  actors = actors.to_a
  actors = actors.sort_by do |actor|
    actors["name"]
  end
  return actors
end

def get_actor(actor_id)
  querry = "SELECT actors.id as actorID, movies.id as movieID, actors.name as name, movies.title, character
            FROM actors
            JOIN cast_members on cast_members.actor_id = actors.id
            JOIN movies on movies.id = cast_members.movie_id
            WHERE actors.id = $1 "
  actor = db_connection do |conn|
    conn.exec_params(querry, [actor_id])
  end

  querry = "SELECT movies.id as movieID, movies.title, character
            FROM actors
            JOIN cast_members on cast_members.actor_id = actors.id
            JOIN movies on movies.id = cast_members.movie_id
            WHERE actors.id = $1 "
  movies = db_connection do |conn|
    conn.exec_params(querry, [actor_id])
  end

  return actor, movies
end

def get_movie(movie_id)
  querry = "SELECT actors.id as actorID, movies.id as movieID, actors.name as actor_name, movies.title, character
            FROM movies
            JOIN cast_members on cast_members.movie_id = movie.id
            JOIN actors on actors.id = cast_members.actor_id
            WHERE movies.id = $1 "



