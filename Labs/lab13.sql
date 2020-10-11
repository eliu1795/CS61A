.read data.sql


CREATE TABLE bluedog AS
  SELECT color, pet
  FROM students
  WHERE color = 'blue' and pet = 'dog';

CREATE TABLE bluedog_songs AS
  SELECT color, pet, song
  FROM students 
  WHERE color = 'blue' and pet = 'dog';


CREATE TABLE matchmaker AS
  SELECT a.pet, a.song, a.color, b.color
  FROM students as a, students as b
  WHERE b.time > a.time
    and a.pet = b.pet
    and a.song = b.song;


CREATE TABLE sevens AS
  SELECT a.seven
  FROM students as a, numbers as b
  WHERE a.number = 7
    and a.time = b.time
    and b.'7' = 'True';


CREATE TABLE favpets AS
  SELECT pet, COUNT(*)
  FROM students
  GROUP BY pet
  ORDER BY COUNT(*) DESC
  LIMIT 10;


CREATE TABLE dog AS
  SELECT pet, COUNT(*)
  FROM students
  WHERE pet = 'dog';


CREATE TABLE bluedog_agg AS
  SELECT song, COUNT(*)
  FROM bluedog_songs as students
  GROUP BY song;


CREATE TABLE instructor_obedience AS
  SELECT seven, instructor, COUNT(*)
  FROM students
  WHERE seven = '7'
  GROUP BY instructor;

