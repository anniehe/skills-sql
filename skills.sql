-- Note: Please consult the directions for this assignment 
-- for the most explanatory version of each question.

-- 1. Select all columns for all brands in the Brands table.

    cars=# SELECT * FROM brands;
     id |    name    | founded |            headquarters            | discontinued 
    ----+------------+---------+------------------------------------+--------------
      1 | Ford       |    1903 | Dearborn, MI                       |             
      2 | Chrysler   |    1925 | Auburn Hills, Michigan             |             
      3 | Citroën    |    1919 | Saint-Ouen, France                 |             
      4 | Hillman    |    1907 | Ryton-on-Dunsmore, England         |         1981
      5 | Chevrolet  |    1911 | Detroit, Michigan                  |             
      6 | Cadillac   |    1902 | New York City, NY                  |             
      7 | BMW        |    1916 | Munich, Bavaria, Germany           |             
      8 | Austin     |    1905 | Longbridge, England                |         1987
      9 | Fairthorpe |    1954 | Chalfont St Peter, Buckinghamshire |         1976
     10 | Studebaker |    1852 | South Bend, Indiana                |         1967
     11 | Pontiac    |    1926 | Detroit, MI                        |         2010
     12 | Buick      |    1903 | Detroit, MI                        |             
     13 | Rambler    |    1901 | Kenosha, Washington                |         1969
     14 | Plymouth   |    1928 | Auburn Hills, Michigan             |         2001
     15 | Tesla      |    2003 | Palo Alto, CA                      |             
    (15 rows)


-- 2. Select all columns for all car models made by Pontiac in the Models table.

    cars=# SELECT * FROM models WHERE brand_name = 'Pontiac';
     id | year | brand_name |    name    
    ----+------+------------+------------
     25 | 1961 | Pontiac    | Tempest
     27 | 1962 | Pontiac    | Grand Prix
     36 | 1963 | Pontiac    | Grand Prix
     42 | 1964 | Pontiac    | GTO
     43 | 1964 | Pontiac    | LeMans
     44 | 1964 | Pontiac    | Bonneville
     45 | 1964 | Pontiac    | Grand Prix
    (7 rows)


-- 3. Select the brand name and model 
--    name for all models made in 1964 from the Models table.

    cars=# SELECT brand_name, name AS model_name FROM models WHERE year = 1964;
     brand_name | model_name  
    ------------+-------------
     Chevrolet  | Corvette
     Ford       | Mustang
     Ford       | Galaxie
     Pontiac    | GTO
     Pontiac    | LeMans
     Pontiac    | Bonneville
     Pontiac    | Grand Prix
     Plymouth   | Fury
     Studebaker | Avanti
     Austin     | Mini Cooper
    (10 rows)


-- 4. Select the model name, brand name, and headquarters for the Ford Mustang 
--    from the Models and Brands tables.

    cars=# SELECT models.name AS model_name, brand_name, headquarters 
    cars=# FROM models JOIN brands ON (models.brand_name=brands.name) 
    cars=# WHERE brand_name='Ford' AND models.name='Mustang';
     model_name | brand_name | headquarters 
    ------------+------------+--------------
     Mustang    | Ford       | Dearborn, MI
    (1 row)


-- 5. Select all rows for the three oldest brands 
--    from the Brands table (Hint: you can use LIMIT and ORDER BY).

    cars=# SELECT * FROM brands ORDER BY founded LIMIT 3;
     id |    name    | founded |    headquarters     | discontinued 
    ----+------------+---------+---------------------+--------------
     10 | Studebaker |    1852 | South Bend, Indiana |         1967
     13 | Rambler    |    1901 | Kenosha, Washington |         1969
      6 | Cadillac   |    1902 | New York City, NY   |             
    (3 rows)


-- 6. Count the Ford models in the database (output should be a number).

    cars=# SELECT COUNT(*) FROM models WHERE brand_name='Ford';
     count 
    -------
         6
    (1 row)


-- 7. Select the name of any and all car brands that are not discontinued.

    cars=# SELECT name FROM brands WHERE discontinued IS NULL;
       name    
    -----------
     Ford
     Chrysler
     Citroën
     Chevrolet
     Cadillac
     BMW
     Buick
     Tesla
    (8 rows)


-- 8. Select rows 15-25 of the DB in alphabetical order by model name.

    cars=# SELECT * FROM models ORDER BY name OFFSET 14 LIMIT 11;
     id | year | brand_name |   name   
    ----+------+------------+----------
     28 | 1962 | Chevrolet  | Corvette
     10 | 1956 | Chevrolet  | Corvette
     17 | 1959 | Chevrolet  | Corvette
      8 | 1955 | Chevrolet  | Corvette
      6 | 1954 | Chevrolet  | Corvette
     20 | 1960 | Chevrolet  | Corvette
     26 | 1961 | Chevrolet  | Corvette
     39 | 1964 | Chevrolet  | Corvette
     38 | 1963 | Chevrolet  | Corvette
      5 | 1953 | Chevrolet  | Corvette
     34 | 1963 | Ford       | E-Series
    (11 rows)


-- 9. Select the brand, name, and year the model's brand was 
--    founded for all of the models from 1960. Include row(s)
--    for model(s) even if its brand is not in the Brands table.
--    (The year the brand was founded should be NULL if 
--    the brand is not in the Brands table.)

    cars=# SELECT brand_name, models.name AS model_name, founded
    cars-# FROM models LEFT JOIN brands ON (models.brand_name=brands.name)
    cars-# WHERE year=1960;
     brand_name | model_name | founded 
    ------------+------------+---------
     Chevrolet  | Corvette   |    1911
     Chevrolet  | Corvair    |    1911
     Fairthorpe | Rockette   |    1954
     Fillmore   | Fillmore   |        
    (4 rows)



-- Part 2: Change the following queries according to the specifications. 
-- Include the answers to the follow up questions in a comment below your
-- query.

-- 1. Modify this query so it shows all brands that are not discontinued
-- regardless of whether they have any models in the models table.
-- before:
    -- SELECT b.name,
    --        b.founded,
    --        m.name
    -- FROM Model AS m
    --   LEFT JOIN brands AS b
    --     ON b.name = m.brand_name
    -- WHERE b.discontinued IS NULL;

    cars=# SELECT b.name AS brand_name, b.founded, m.name AS model_name
    cars-# FROM brands AS b
    cars-# LEFT JOIN models AS m
    cars-# ON b.name = m.brand_name
    cars-# WHERE b.discontinued IS NULL;
     brand_name | founded | model_name  
    ------------+---------+-------------
     Ford       |    1903 | Model T
     Chrysler   |    1925 | Imperial
     Citroën    |    1919 | 2CV
     Chevrolet  |    1911 | Corvette
     Chevrolet  |    1911 | Corvette
     Cadillac   |    1902 | Fleetwood
     Chevrolet  |    1911 | Corvette
     Ford       |    1903 | Thunderbird
     Chevrolet  |    1911 | Corvette
     Chevrolet  |    1911 | Corvette
     BMW        |    1916 | 600
     Chevrolet  |    1911 | Corvette
     BMW        |    1916 | 600
     Ford       |    1903 | Thunderbird
     Chevrolet  |    1911 | Corvette
     BMW        |    1916 | 600
     Chevrolet  |    1911 | Corvair
     Chevrolet  |    1911 | Corvette
     Chevrolet  |    1911 | Corvette
     Chevrolet  |    1911 | Corvette
     Buick      |    1903 | Special
     Ford       |    1903 | E-Series
     Chevrolet  |    1911 | Corvair 500
     Chevrolet  |    1911 | Corvette
     Chevrolet  |    1911 | Corvette
     Ford       |    1903 | Mustang
     Ford       |    1903 | Galaxie
     Tesla      |    2003 | 
    (28 rows)


-- 2. Modify this left join so it only selects models that have brands in the Brands table.
-- before: 
    -- SELECT m.name,
    --        m.brand_name,
    --        b.founded
    -- FROM Models AS m
    --   LEFT JOIN Brands AS b
    --     ON b.name = m.brand_name;

    cars=# SELECT m.name AS model_name, m.brand_name, b.founded
    cars-# FROM models as m
    cars-# JOIN brands as b
    cars-# ON b.name = m.brand_name;
        model_name    | brand_name | founded 
    ------------------+------------+---------
     Model T          | Ford       |    1903
     Imperial         | Chrysler   |    1925
     2CV              | Citroën    |    1919
     Minx Magnificent | Hillman    |    1907
     Corvette         | Chevrolet  |    1911
     Corvette         | Chevrolet  |    1911
     Fleetwood        | Cadillac   |    1902
     Corvette         | Chevrolet  |    1911
     Thunderbird      | Ford       |    1903
     Corvette         | Chevrolet  |    1911
     Corvette         | Chevrolet  |    1911
     600              | BMW        |    1916
     Corvette         | Chevrolet  |    1911
     600              | BMW        |    1916
     Thunderbird      | Ford       |    1903
     Mini             | Austin     |    1905
     Corvette         | Chevrolet  |    1911
     600              | BMW        |    1916
     Corvair          | Chevrolet  |    1911
     Corvette         | Chevrolet  |    1911
     Rockette         | Fairthorpe |    1954
     Mini Cooper      | Austin     |    1905
     Avanti           | Studebaker |    1852
     Tempest          | Pontiac    |    1926
     Corvette         | Chevrolet  |    1911
     Grand Prix       | Pontiac    |    1926
     Corvette         | Chevrolet  |    1911
     Avanti           | Studebaker |    1852
     Special          | Buick      |    1903
     Mini             | Austin     |    1905
     Mini Cooper S    | Austin     |    1905
     Classic          | Rambler    |    1901
     E-Series         | Ford       |    1903
     Avanti           | Studebaker |    1852
     Grand Prix       | Pontiac    |    1926
     Corvair 500      | Chevrolet  |    1911
     Corvette         | Chevrolet  |    1911
     Corvette         | Chevrolet  |    1911
     Mustang          | Ford       |    1903
     Galaxie          | Ford       |    1903
     GTO              | Pontiac    |    1926
     LeMans           | Pontiac    |    1926
     Bonneville       | Pontiac    |    1926
     Grand Prix       | Pontiac    |    1926
     Fury             | Plymouth   |    1928
     Avanti           | Studebaker |    1852
     Mini Cooper      | Austin     |    1905
    (47 rows)

-- followup question: In your own words, describe the difference between 
-- left joins and inner joins.

    -- LEFT JOINS will show all rows from left table with corresponding
    -- data from the right table, even if there is no match from the right table.
    -- INNER JOINS will only show the overlap (matching rows) between the joined tables.


-- 3. Modify the query so that it only selects brands that don't have any models in the models table. 
-- (Hint: it should only show Tesla's row.)
-- before: 
    -- SELECT name,
    --        founded
    -- FROM Brands
    --   LEFT JOIN Models
    --     ON brands.name = Models.brand_name
    -- WHERE Models.year > 1940;

    cars=# SELECT brands.name, founded
    cars-# FROM brands LEFT JOIN models ON (brands.name = models.brand_name)
    cars-# WHERE models.name IS NULL;
     name  | founded 
    -------+---------
     Tesla |    2003
    (1 row)


-- 4. Modify the query to add another column to the results to show 
-- the number of years from the year of the model until the brand becomes discontinued
-- Display this column with the name years_until_brand_discontinued.
-- before: 
    -- SELECT b.name,
    --        m.name,
    --        m.year,
    --        b.discontinued
    -- FROM Models AS m
    --   LEFT JOIN brands AS b
    --     ON m.brand_name = b.name
    -- WHERE b.discontinued NOT NULL;

    cars=# SELECT b.name AS brand_name, m.name AS model_name, m.year, b.discontinued, (b.discontinued-m.year) AS years_until_brand_discontinued
    cars-# FROM models AS m
    cars-# LEFT JOIN brands AS b
    cars-# ON m.brand_name = b.name
    cars-# WHERE b.discontinued IS NOT NULL;
     brand_name |    model_name    | year | discontinued | years_until_brand_discontinued 
    ------------+------------------+------+--------------+--------------------------------
     Hillman    | Minx Magnificent | 1950 |         1981 |                             31
     Austin     | Mini Cooper      | 1964 |         1987 |                             23
     Austin     | Mini Cooper S    | 1963 |         1987 |                             24
     Austin     | Mini             | 1963 |         1987 |                             24
     Austin     | Mini Cooper      | 1961 |         1987 |                             26
     Austin     | Mini             | 1959 |         1987 |                             28
     Fairthorpe | Rockette         | 1960 |         1976 |                             16
     Studebaker | Avanti           | 1964 |         1967 |                              3
     Studebaker | Avanti           | 1963 |         1967 |                              4
     Studebaker | Avanti           | 1962 |         1967 |                              5
     Studebaker | Avanti           | 1961 |         1967 |                              6
     Pontiac    | Grand Prix       | 1964 |         2010 |                             46
     Pontiac    | Bonneville       | 1964 |         2010 |                             46
     Pontiac    | LeMans           | 1964 |         2010 |                             46
     Pontiac    | GTO              | 1964 |         2010 |                             46
     Pontiac    | Grand Prix       | 1963 |         2010 |                             47
     Pontiac    | Grand Prix       | 1962 |         2010 |                             48
     Pontiac    | Tempest          | 1961 |         2010 |                             49
     Rambler    | Classic          | 1963 |         1969 |                              6
     Plymouth   | Fury             | 1964 |         2001 |                             37
    (20 rows)



-- Part 3: Further Study

-- 1. Select the name of any brand with more than 5 models in the database.

    cars=# SELECT brand_name
    cars-# FROM models
    cars-# GROUP BY brand_name
    cars-# HAVING COUNT(name) > 5;
     brand_name 
    ------------
     Chevrolet
     Pontiac
     Ford
    (3 rows)


-- 2. Add the following rows to the Models table.

-- year    name       brand_name
-- ----    ----       ----------
-- 2015    Chevrolet  Malibu
-- 2015    Subaru     Outback

    cars=# INSERT INTO models (year, name, brand_name)
    cars-# VALUES (2015, 'Chevrolet', 'Malibu');
    INSERT 0 1
    cars=# INSERT INTO models (year, name, brand_name)
    cars-# VALUES (2015, 'Subaru', 'Outback');
    INSERT 0 1

    cars=# SELECT * FROM models ORDER BY id DESC LIMIT 2;
     id | year | brand_name |   name    
    ----+------+------------+-----------
     50 | 2015 | Outback    | Subaru
     49 | 2015 | Malibu     | Chevrolet
    (2 rows)


-- 3. Write a SQL statement to crate a table called `Awards`
--    with columns `name`, `year`, and `winner`. Choose
--    an appropriate datatype and nullability for each column
--   (no need to do subqueries here).

    cars=# CREATE TABLE Awards(
    cars(# name VARCHAR(50) NOT NULL,
    cars(# year INTEGER NOT NULL,
    cars(# winnter_id INTEGER PRIMARY KEY);
    CREATE TABLE

    cars=# SELECT * FROM Awards;
     name | year | winnter_id 
    ------+------+------------
    (0 rows)


-- 4. Write a SQL statement that adds the following rows to the Awards table:

--   name                 year      winner_model_id
--   ----                 ----      ---------------
--   IIHS Safety Award    2015      the id for the 2015 Chevrolet Malibu
--   IIHS Safety Award    2015      the id for the 2015 Subaru Outback

    cars=# INSERT INTO Awards VALUES ('IIHS Safety Award', 2015, 49);
    INSERT 0 1
    cars=# INSERT INTO Awards VALUES ('IIHS Safety Award', 2015, 50);
    INSERT 0 1

    cars=# SELECT * FROM Awards;
           name        | year | winnter_id 
    -------------------+------+------------
     IIHS Safety Award | 2015 |         49
     IIHS Safety Award | 2015 |         50
    (2 rows)


-- 5. Using a subquery, select only the *name* of any model whose 
-- year is the same year that *any* brand was founded.

    cars=# SELECT name 
    cars-# FROM models
    cars-# WHERE year IN
    cars-# (SELECT founded
    cars(# FROM brands);
       name    
    -----------
     Imperial
     Corvette
     Fleetwood
    (3 rows)



