----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                                        SQL Case Study - Paintings
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                                            Problem Statements
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------											
 1. Fetch all the paintings which are not displayed on any museums?
 2. Are there museums without any paintings?
 3. How many paintings have an asking price of more than their regular price?
 4. Identify the paintings whose asking price is less than 50% of its regular price
 5. Which canva size costs the most?
 6. Identify duplicate records from work, product_size, subject and image_link tables
 7. Identify the museums with invalid city information in the given dataset
 8. Museum_Hours table has 1 invalid entry. Identify it and remove it.
 9. Fetch the top 10 most famous painting subject
 10. Identify the museums which are open on both Sunday and Monday. Display museum name, city.
 11. How many museums are open every single day?
 12. Which are the top 5 most popular museum? (Popularity is defined based on most no of paintings in a museum)
 13. Who are the top 5 most popular artist? (Popularity is defined based on most no of paintings done by an artist)
 14. Display the 3 least popular canva sizes
 15. Which museum is open for the longest during a day. Dispay museum name, state and hours open and which day?
 16. Which museum has the most no of most popular painting style?
 17. Identify the artists whose paintings are displayed in multiple countries
 18. Display the country and the city with most no of museums. 
 19. Identify the artist and the museum where the most expensive and least expensive painting is placed. Display the artist name, sale_price, painting name, museum name, museum city and canvas label
 20. Which country has the 5th highest no of paintings?
 21. Which are the 3 most popular and 3 least popular painting styles?
 22. Which artist has the most no of Portraits paintings outside USA?. Display artist name, no of paintings and the artist nationality

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                                            Solving the above SQL problems using the Famous Paintings & Museum dataset
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
1) Fetch all the paintings which are not displayed on any museums?
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
SELECT 
    *
FROM
    work
WHERE
    museum_id IS NULL;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
2) Are there museuems without any paintings?
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
SELECT 
    *
FROM
    museum m
WHERE
    NOT EXISTS( SELECT 
            1
        FROM
            work w
        WHERE
            w.museum_id = m.museum_id);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
3) How many paintings have an asking price of more than their regular price? 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    COUNT(*)
FROM
    product_size p
WHERE
    sale_price > regular_price;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
4) Identify the paintings whose asking price is less than 50% of its regular price
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    *
FROM
    product_size p
WHERE
    sale_price < (0.5 * regular_price);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
5) Which canva size costs the most?
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    c.label, MAX(p.sale_price) AS max_price
FROM
    canvas_size c
        JOIN
    product_size p ON c.size_id = p.size_id
GROUP BY c.label
ORDER BY max_price DESC
LIMIT 1;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
6) Find duplicate records from work, product_size, subject and image_link tables
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT
    *
FROM
    work;
SELECT DISTINCT
    *
FROM
    product_size;
SELECT DISTINCT
    *
FROM
    subject;
SELECT DISTINCT
    *
FROM
    image_link;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
7) Identify the museums with invalid city information in the given dataset
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    *
FROM
    museum
WHERE
    city REGEXP '^[0-9]';
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
8) Museum_Hours table has 1 invalid entry. Identify it and remove it.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELETE m1 FROM museum_hours m1
        JOIN
    museum_hours m2 ON m1.museum_id = m2.museum_id
        AND m1.day = m2.day 
WHERE
    m1.museum_id > m2.museum_id;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
9) Fetch the top 10 most famous painting subject
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    subject, COUNT(subject) AS total
FROM
    subject
GROUP BY subject
ORDER BY total DESC
LIMIT 10;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
10) Identify the museums which are open on both Sunday and Monday. Display museum name, city.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    m.name, m.city
FROM
    museum_hours m1
        JOIN
    museum_hours m2 ON m2.museum_id = m1.museum_id
        JOIN
    museum m ON m.museum_id = m1.museum_id
WHERE
    m1.day = 'Sunday' AND m2.day = 'Monday'
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
11) How many museums are open every single day?
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    COUNT(*) AS total_museum
FROM
    (SELECT 
        museum_id
    FROM
        museum_hours
    GROUP BY museum_id
    HAVING COUNT(DISTINCT day) = 7) AS c;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
12) Which are the top 5 most popular museum? (Popularity is defined based on most no of paintings in a museum)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    m.name, m.city, COUNT(w.work_id) AS No_Of_Painting
FROM
    museum m
        JOIN
    work w ON m.museum_id = w.museum_id
GROUP BY m.name , m.city
ORDER BY No_Of_Painting DESC
LIMIT 5;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
13) Who are the top 5 most popular artist? (Popularity is defined based on most no of paintings done by an artist)
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    a.full_name,
    a.nationality,
    COUNT(w.work_id) AS No_Of_Painting
FROM
    artist a
        JOIN
    work w ON a.artist_id = w.artist_id
GROUP BY a.full_name , a.nationality
ORDER BY No_Of_Painting DESC
LIMIT 5;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
14) Display the 3 least popular canva sizes
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    w.name, c.label, COUNT(w.work_id) AS total
FROM
    work w
        JOIN
    product_size p ON p.work_id = w.work_id
        JOIN
    canvas_size c ON c.size_id = p.size_id
GROUP BY w.name , c.label
ORDER BY total ASC
LIMIT 3;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
15) Which museum is open for the longest during a day. Dispay museum name, state and hours open and which day?
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    m.name,
    m.state,
    mh.day,
    open,
    close,
    TIMEDIFF(close, open) AS duration
FROM
    museum m
        JOIN
    museum_hours mh ON m.museum_id = mh.museum_id
ORDER BY duration DESC
LIMIT 1;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
16) Which museum has the most no of most popular painting style?
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    m.name, w.style, COUNT(*) AS cnt
FROM
    work w
        JOIN
    museum m ON m.museum_id = w.museum_id
GROUP BY m.name , w.style
ORDER BY cnt DESC
LIMIT 1;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
17) Identify the artists whose paintings are displayed in multiple countries
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    a.full_name,
    a.nationality,
    a.style,
    COUNT(DISTINCT m.country) AS num_countries
FROM
    artist a
        JOIN
    work w ON a.artist_id = w.artist_id
        JOIN
    museum m ON w.museum_id = m.museum_id
GROUP BY a.full_name , a.nationality , a.style
HAVING COUNT(DISTINCT m.country) > 1
ORDER BY num_countries DESC;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
18) Display the country and the city with most no of museums. 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    m.country, m.city, COUNT(museum_id) AS Museum
FROM
    museum m
GROUP BY m.country , m.city
ORDER BY Museum DESC
LIMIT 1;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
19) Identify the artist and the museum where the most expensive and least expensive painting is placed. Display the artist name, sale_price, painting name, museum name, museum city and canvas label.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Most Expensive Painting
SELECT 
    a.full_name, p.sale_price, w.name, m.name, m.city, c.label
FROM
    museum m
        JOIN
    work w ON m.museum_id = w.museum_id
        JOIN
    product_size p ON w.work_id = p.work_id
        JOIN
    canvas_size c ON c.size_id = p.size_id
        JOIN
    artist a ON a.artist_id = w.artist_id
ORDER BY sale_price DESC
LIMIT 1;

-- Least Expensive Painting
SELECT 
    a.full_name, p.sale_price, w.name, m.name, m.city, c.label
FROM
    museum m
        JOIN
    work w ON m.museum_id = w.museum_id
        JOIN
    product_size p ON w.work_id = p.work_id
        JOIN
    canvas_size c ON c.size_id = p.size_id
        JOIN
    artist a ON a.artist_id = w.artist_id
ORDER BY sale_price ASC
LIMIT 1;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
20) Which country has the 5th highest no of paintings?
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    m.country, COUNT(*) AS cnt
FROM
    museum m
        JOIN
    work w ON w.museum_id = m.museum_id
GROUP BY m.country
ORDER BY cnt DESC
LIMIT 1 OFFSET 4;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
21) Which are the 3 most popular and 3 least popular painting styles?
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Most Popular Styles
SELECT 
    a.style, COUNT(w.work_id) AS total_painting
FROM
    artist a
        JOIN
    work w ON w.artist_id = a.artist_id
GROUP BY a.style
ORDER BY total_painting DESC
LIMIT 3;

-- Least Popular Styles
SELECT 
    a.style, COUNT(w.work_id) AS total_painting
FROM
    artist a
        JOIN
    work w ON w.artist_id = a.artist_id
GROUP BY a.style
ORDER BY total_painting ASC
LIMIT 3;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
22) Which artist has the most no of Portraits paintings outside USA?. Display artist name, no of paintings and the artist nationality.
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 
    a.full_name, COUNT(*) AS No_Of_Painting, a.nationality
FROM
    artist a
        JOIN
    work w ON w.artist_id = a.artist_id
        JOIN
    museum m ON m.museum_id = w.museum_id
        JOIN
    subject s ON s.work_id = w.work_id
WHERE
    s.subject = 'Portraits'
        AND m.country != 'USA'
GROUP BY a.full_name , a.nationality
ORDER BY No_Of_Painting DESC
LIMIT 1;	
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
