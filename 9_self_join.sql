-- Self join

-- 1.
-- How many stops are in the database. 
SELECT count(*)
FROM stops;

-- 2.
-- Find the id value for the stop 'Craiglockhart' 
SELECT id
FROM stops
WHERE name = 'Craiglockhart';

-- 3.
-- Give the id and the name for the stops on the '4' 'LRT' service. 
SELECT id, name
FROM stops
JOIN route ON stops.id = route.stop
WHERE route.num = '4' AND company = 'LRT'

-- 4.
-- The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). 
-- Run the query and notice the two services that link these stops have a count of 2. 
-- Add a HAVING clause to restrict the output to these two routes. 
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2;

-- 5.
-- Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart,
--  without changing routes. Change the query so that it shows the services from Craiglockhart to London Road. 
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop = (
SELECT id
FROM stops
WHERE name='London Road'
);

-- 6.
-- The query shown is similar to the previous one, however by joining two copies of the stops table we can 
-- refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart'
--  and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross' 
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a 
JOIN route b ON (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'London Road'

-- 7.
-- Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith') 
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.id=115 AND stopb.id = 137;

-- 8.
-- Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross' 
SELECT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name = 'Tollcross';

-- 9.
-- 10.


/*
Quiz Answers:

1. SELECT DISTINCT a.name, b.name
  FROM stops a JOIN route z ON a.id=z.stop
  JOIN route y ON y.num = z.num
  JOIN stops b ON y.stop=b.id
 WHERE a.name='Craiglockhart' AND b.name ='Haymarket'


2. SELECT S2.id, S2.name, R2.company, R2.num
  FROM stops S1, stops S2, route R1, route R2
 WHERE S1.name='Haymarket' AND S1.id=R1.stop
   AND R1.company=R2.company AND R1.num=R2.num
   AND R2.stop=S2.id AND R2.num='2A'


3. SELECT a.company, a.num, stopa.name, stopb.name
  FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
 WHERE stopa.name='Tollcross'

*/
