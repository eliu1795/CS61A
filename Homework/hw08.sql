CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT a.name, b.size
  FROM dogs as a, sizes as b
  WHERE a.height > b.min 
    and a.height <= b.max; 

-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT a.child 
  FROM parents as a, dogs as b 
  WHERE a.parent = b.name 
  ORDER BY b.height DESC;

-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT x.child AS one, y.child AS two, p.size AS size 
  FROM parents AS x, parents AS y, size_of_dogs AS p, size_of_dogs AS q 
  WHERE x.parent = y.parent
    and x.child < y.child
    and x.child = p.name
    and y.child = q.name
    and p.size = q.size
  ORDER BY x.child;


-- Sentences about siblings that are the same size
CREATE TABLE sentences AS  
  SELECT one || " and " || two || " are " || size || " siblings"
  FROM siblings;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks_helper(dogs, stack_height, last_height, n);

-- Add your INSERT INTOs here
INSERT INTO stacks_helper 
  SELECT name, height, height, 1 
  FROM dogs;

INSERT INTO stacks_helper 
  SELECT name ||', '|| dogs, stack_height + height, height, n + 1 
  FROM dogs, stacks_helper 
  WHERE height < last_height 
    and n = 1;

INSERT INTO stacks_helper 
  SELECT name ||', '|| dogs, stack_height + height, height, n + 1 
  FROM dogs,stacks_helper 
  WHERE height < last_height 
    and n = 2;

INSERT INTO stacks_helper 
  SELECT name ||', '|| dogs, stack_height + height, height, n + 1 
  FROM dogs, stacks_helper 
  WHERE height < last_height 
    and n = 3;

CREATE TABLE stacks AS
  SELECT dogs, stack_height 
  FROM stacks_helper
  WHERE stack_height >= 170 
  ORDER BY stack_height;


