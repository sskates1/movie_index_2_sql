CREATE TABLE articles (
  id serial PRIMARY KEY,
  title varchar(255) NOT NULL,
  url varchar(255) NOT NULL,
  user_id int NOT NULL,
  description text,
  score int NOT NULL,
);

CREATE TABLE comments (
  id serial PRIMARY KEY,
  user_id varchar(255) NOT NULL,
  article_id int NOT NULL FOREIGN KEY REFERENCES articles(id),
  parent_id int FOREIGN KEY REFERENCES comments(id),
  comment text NOT NULL
);

CREATE TABLE users(
  id serial PRIMARY KEY,
  user_name varchar(255) NOT NULL,
  password varchar(25) NOT NULL


);
