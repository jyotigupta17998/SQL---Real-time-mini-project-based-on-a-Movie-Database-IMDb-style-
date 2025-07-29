-- DROP IF EXIST (for re-running)
DROP TABLE IF EXISTS ratings, movie_actors, movie_genres, actors, users, genres, movies CASCADE;

-- MOVIES
CREATE TABLE movies (
  movie_id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  release_year INTEGER,
  duration INTEGER
);

-- GENRES
CREATE TABLE genres (
  genre_id SERIAL PRIMARY KEY,
  genre_name TEXT
);

-- MOVIE-GENRE RELATION
CREATE TABLE movie_genres (
  movie_id INTEGER REFERENCES movies(movie_id),
  genre_id INTEGER REFERENCES genres(genre_id),
  PRIMARY KEY(movie_id, genre_id)
);

-- ACTORS
CREATE TABLE actors (
  actor_id SERIAL PRIMARY KEY,
  name TEXT
);

-- MOVIE-ACTOR RELATION
CREATE TABLE movie_actors (
  movie_id INTEGER REFERENCES movies(movie_id),
  actor_id INTEGER REFERENCES actors(actor_id),
  PRIMARY KEY(movie_id, actor_id)
);

-- USERS
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  name TEXT,
  country TEXT
);

-- RATINGS
CREATE TABLE ratings (
  rating_id SERIAL PRIMARY KEY,
  movie_id INTEGER REFERENCES movies(movie_id),
  user_id INTEGER REFERENCES users(user_id),
  rating NUMERIC(2,1),
  review TEXT,
  rating_date DATE
);

-- INSERT GENRES
INSERT INTO genres (genre_name) VALUES
('Drama'), ('Action'), ('Comedy'), ('Romance'),
('Thriller'), ('Crime'), ('Animation'), ('Biography');

-- INSERT USERS
INSERT INTO users (name, country) VALUES
('Aarav', 'India'), ('Sophie', 'UK'), ('Carlos', 'Spain'),
('Emily', 'USA'), ('Priya', 'India');


-- INSERT ACTORS (Subset)
INSERT INTO actors (name) VALUES
('Leonardo DiCaprio'), ('Shah Rukh Khan'), ('Aamir Khan'),
('Alia Bhatt'), ('Brad Pitt'), ('Ranbir Kapoor'),
('Tom Hanks'), ('Deepika Padukone'), ('Morgan Freeman'),
('Priyanka Chopra');

-- INSERT MOVIES (50 REAL MOVIES)
INSERT INTO movies (title, release_year, duration) VALUES
('Inception', 2010, 148),
('3 Idiots', 2009, 170),
('The Shawshank Redemption', 1994, 142),
('Dangal', 2016, 161),
('The Dark Knight', 2008, 152),
('Lagaan', 2001, 224),
('Pulp Fiction', 1994, 154),
('Swades', 2004, 210),
('Interstellar', 2014, 169),
('Taare Zameen Par', 2007, 165),
('The Godfather', 1972, 175),
('PK', 2014, 153),
('Zindagi Na Milegi Dobara', 2011, 155),
('Forrest Gump', 1994, 142),
('Barfi!', 2012, 151),
('The Matrix', 1999, 136),
('Black', 2005, 122),
('The Pursuit of Happyness', 2006, 117),
('Dil Chahta Hai', 2001, 183),
('The Social Network', 2010, 120),
('Chak De! India', 2007, 153),
('Fight Club', 1999, 139),
('Jab We Met', 2007, 142),
('Sholay', 1975, 204),
('Gone Girl', 2014, 149),
('Gully Boy', 2019, 154),
('Titanic', 1997, 195),
('Uri: The Surgical Strike', 2019, 138),
('12 Angry Men', 1957, 96),
('Slumdog Millionaire', 2008, 120),
('Haider', 2014, 160),
('Avengers: Endgame', 2019, 181),
('Rockstar', 2011, 159),
('Queen', 2013, 146),
('Raazi', 2018, 139),
('The Wolf of Wall Street', 2013, 180),
('Drishyam', 2015, 163),
('The Revenant', 2015, 156),
('Andhadhun', 2018, 139),
('The Lunchbox', 2013, 104),
('Don', 2006, 171),
('MS Dhoni: The Untold Story', 2016, 190),
('Munna Bhai M.B.B.S.', 2003, 156),
('Batman Begins', 2005, 140),
('The Irishman', 2019, 209),
('Tumbbad', 2018, 104),
('The Great Gatsby', 2013, 143),
('Kahaani', 2012, 122),
('Jawan', 2023, 169),
('Oppenheimer', 2023, 180);

-- MOVIE-GENRES (sample 10)
INSERT INTO movie_genres (movie_id, genre_id) VALUES
(1, 2), (1, 5),
(2, 1), (2, 3),
(3, 1), (3, 6),
(4, 1), (4, 8),
(5, 2), (5, 5),
(6, 1), (6, 6),
(7, 2), (7, 5),
(8, 1), (8, 4),
(9, 1), (9, 2),
(10, 1), (10, 3);

-- MOVIE-ACTORS (sample 10)
INSERT INTO movie_actors (movie_id, actor_id) VALUES
(1, 1),
(2, 3),
(3, 9),
(4, 3),
(5, 1),
(6, 3),
(7, 5),
(8, 2),
(9, 1),
(10, 3);

-- SAMPLE RATINGS
INSERT INTO ratings (movie_id, user_id, rating, review, rating_date) VALUES
(1,1,9.0,'Incredible visuals and concept','2025-01-01'),
(2,2,9.5,'Funny and emotional','2025-01-05'),
(3,3,9.8,'Best movie ever','2025-01-12'),
(4,4,9.1,'Very inspiring','2025-01-20'),
(5,1,9.0,'Iconic Batman performance','2025-01-25'),
(6,2,8.9,'Epic story with emotion','2025-02-01'),
(7,3,8.5,'Crazy timeline','2025-02-05'),
(8,4,8.8,'Simple but powerful','2025-02-10'),
(9,5,9.3,'Time bending story','2025-02-15'),
(10,1,9.4,'Heart-touching and emotional','2025-02-18');








SELECT * FROM movies;
SELECT * FROM ratings;
SELECT * FROM users;
SELECT * FROM genres;
SELECT * FROM movie_genres;
SELECT * FROM actors;
SELECT * FROM movie_actors;


-- 1.What are the top 5 highest-rated movies based on rating?
SELECT m.title, r.rating
FROM movies AS m
JOIN ratings r ON m.movie_id = r.movie_id 
ORDER BY r.rating DESC
LIMIT 5;

-- 2. Which movies have been rated above 9 by users from India?
SELECT m.title, r.rating
FROM movies as m
JOIN ratings r ON m.movie_id = r.movie_id
JOIN users u ON r.user_id = u.user_id
WHERE r.rating >= 9 AND u.country = 'India';

-- 3. How many movies belong to each genre?
SELECT g.genre_name, count(m.title) AS TotalMovies
FROM genres AS g
JOIN movie_genres mg ON g.genre_id = mg.genre_id
JOIN movies m ON mg.movie_id = m.movie_id
GROUP BY g.genre_name;

-- 4. Which actor has acted in the highest number of movies?
SELECT a.name, COUNT(m.title) AS HighestMovies
FROM actors AS a
JOIN movie_actors ma ON a.actor_id = ma.actor_id
JOIN movies m ON m.movie_id = ma.movie_id
GROUP BY a.name
--ORDER BY COUNT(m.title) DESC
LIMIT 1;

-- 5. What is the average rating given by each user?
SELECT u.name, ROUND(AVG(r.rating), 2) AS AVGRating
FROM ratings AS r
JOIN users u ON r.user_id = u.user_id
GROUP BY u.name;

-- 6. Assign a release rank to each movie using its release year.
SELECT title, release_year, RANK() OVER(ORDER BY release_year)
FROM movies;

-- 7. Classify movies as 'Classic', 'Modern', or 'New' based on release year. 
SELECT title, release_year,
	CASE
		 	 WHEN release_year < 2000 THEN 'Classic'
		 	 WHEN release_year > 2000 AND release_year < 2020 THEN 'Modern '
			 ELSE 'New'
		END AS ERABUCKET
FROM movies;

-- 8. Recommended Movie of the Day
SELECT m.title AS NAME, m.release_year AS YEAR, g.genre_name AS GENRE, a.name AS ACTOR , r.rating AS RATING 
FROM movies AS m
JOIN movie_genres mg ON m.movie_id = mg.movie_id
JOIN genres g ON mg.genre_id = g.genre_id
JOIN movie_actors ma ON m.movie_id = ma.movie_id
JOIN actors a ON ma.actor_id = a.actor_id
JOIN ratings r ON m.movie_id = r.movie_id
ORDER BY RANDOM()
LIMIT 1;