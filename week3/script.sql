SELECT * FROM Species;
.tables
--SQL is case-insensitive
select * from species;
-- limiting rows
SELECT * FROM Species LIMIT 5;
SELECT * FROM Species LIMIT 5 OFFSET 5;
-- How many rows?
SELECT COUNT(*) FROM Species;
-- if put column name in count(), how many non-NULL values?
SELECT COUNT(Scientific_name) FROM Species;
-- How mant distinct values occur?
SELECT DISTINCT Species FROM Bird_nests;

-- Lecture 2 
.maxrow 6 
SELECT Location FROM Site;
SELECT * FROM Site WHERE Area < 200;
SELECT * FROM Site WHERE Area <200 AND Location LIKE '%USA';

--expressions 
SELECT Site_name, Area FROM Site; 
SELECT Site_name, Area*2.47 FROM Site; 
SELECT Site_name, Area*2.47 AS Area_acres FROM Site; 
SELECT Site_name || 'foo' FROM Site;

-- aggregation functions 
SELECT COUNT(*) FROM Site; 
SELECT COUNT(*) AS num_rows FROM Site; 
SELECT Site_name, Area*2.47 AS Area_acres FROM Site;
SELECT COUNT(Scientific_name) FROM Species;
SELECT DISTINCT Relevance FROM Species;
SELECT COUNT(DISTINCT Relevance) FROM Species;

--MIN, MAX, AVG
SELECT AVG(Area) FROM Site;

-- grouping 
SELECT * FROM Site; 
SELECT Location, MAX(Area)
    FROM Site
    GROUP BY Location;
SELECT Location, COUNT(*)
    FROM Site
    GROUP BY Location;
SELECT* FROM Species;
SELECT Relevance, COUNT(*) 
    FROM Species
    GROUP BY Relevance;
SELECT Location, MAX(Area)
    GROUP BY Location;
SELECT Location, MAX(Area)
    FROM Site
    WHERE Location LIKE '%Canada'
    GROUP BY Location;
SELECT Location, MAX(Area) AS Max_area
    FROM Site
    WHERE Location LIKE '%Canada'
    GROUP BY Location 
    HAVING Max_area>200;
-- relational algebra peeks through!
select count(*) FROM Site;
SELECT COUNT(*) FROM (SELECT COUNT(*) FROM Site );
select * from Bird_nests LIMIT 3;
SELECT COUNT(*) FROM Species;
SELECT * FROM Species
    WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);

--saving queries 
CREATE TEMP TABLE t AS
    SELECT * FROM Species
    WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);
--call the table 
SELECT * FROM t;
SELECT * FROM t_perm;
DROP TABLE t_perm;

-- NULL processing 
SELECT COUNT(*) FROM Bird_nests
    WHERE floatAge <= 5;
SELECT count(*) from Bird_nests;
--THIS IS THE INCORRECT SYNTAX WILL OUTPUT 0 
SELECT count(*) from Bird_nests WHERE floatAge = NULL;
-- SPECIFY 'IS NULL' 
SELECT COUNT(*) FROM Bird_nests WHERE floatAge IS NULL; 

--JOINS
SELECT * FROM Camp_assignment;
SELECT * from Personnel; 
select * from Camp_assignment JOIN Personnel
    ON Observer = Abbreviation;
SELECT * FROM Camp_assignment JOIN Personnel
    ON Camp_assignment.Observer = Personnel.Abbreviation;
SELECT * FROM Camp_assignment AS ca JOIN Personnel p
    ON ca.Observer = p.Abbreviation;
SELECT * FROM Camp_assignment ca JOIN Personnel p
    ON ca.Observer = p.Abbreviation
    JOIN Site s
    ON ca.Site = s.Code
    WHERE ca.Observer = 'lmckinnon'
    LIMIT 3;

--more on grouping 
SELECT Nest_ID, COUNT(*) FROM Bird_eggs GROUP BY Nest_ID;
