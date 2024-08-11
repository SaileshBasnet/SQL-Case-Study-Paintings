-- Solve the below SQL problems using the Famous Paintings & Museum dataset:

1) Fetch all the paintings which are not displayed on any museums?
	select * from work where museum_id is null;

2) Are there museuems without any paintings?
	select * from museum m
	where not exists (select 1 from work w
					 where w.museum_id=m.museum_id);

3) How many paintings have an asking price of more than their regular price? 
select * from product_size p where sale_price > regular_price ;

4) Identify the paintings whose asking price is less than 50% of its regular price
select * from product_size p where sale_price < (0.5 * regular_price);

5) Which canva size costs the most?
select size_id from canvas_size c join product_size p on p.size_id=c.size_id group by sale_price desc 
limit 1;

6) Delete duplicate records from work, product_size, subject and image_link tables
select distinct * from work;
select distinct * from product_size;
select distinct * from subject;
select distinct * from image_link;



7) Identify the museums with invalid city information in the given dataset
select * from museum where city regexp '^[0-9]';

8) Museum_Hours table has 1 invalid entry. Identify it and remove it.
DELETE m1
FROM museum_hours m1
JOIN museum_hours m2 ON m1.museum_id = m2.museum_id AND m1.day = m2.day
WHERE m1.museum_id >  m2.museum_id;


9) Fetch the top 10 most famous painting subject
select subject,count(subject) as cnt from subject group by subject order by cnt desc limit 10;

select * 
	from (
		select s.subject,count(1) as no_of_paintings
		,rank() over(order by count(1) desc) as ranking
		from work w
		join subject s on s.work_id=w.work_id
		group by s.subject ) x
	where ranking <= 10;
10) Identify the museums which are open on both Sunday and Monday. Display museum name, city.
select m.name,m.city from museum_hours m1
join museum_hours m2 on m2.museum_id=m1.museum_id
join museum m on m.museum_id=m1.museum_id
where m1.day='Sunday' and m2.day='Monday'

select m.name,m.city from museum m
join museum_hours m1 on m1.museum_id =m.museum_id
join museum_hours m2 on m2.museum_id =m1.museum_id
where m1.day='Sunday' and m2.day='Monday'

11) How many museums are open every single day?
select count(*) as cnt from
(select museum_id from museum_hours group by museum_id having count(*)=7) as c;

12) Which are the top 5 most popular museum? (Popularity is defined based on most no of paintings in a museum)
select m.name,m.city,count(w.work_id) as NoOfPainting from museum m
join work w on m.museum_id=w.museum_id 
group by m.name,m.city order by NoOfPainting desc limit 5;

13) Who are the top 5 most popular artist? (Popularity is defined based on most no of paintings done by an artist)
select a.full_name,a.nationality,count(w.work_id) as NoOfPainting from artist a 
join work w on a.artist_id=w.artist_id group by a.full_name,a.nationality order by NoOfPainting desc limit 5;

14) Display the 3 least popular canva sizes
select w.name,c.label,count(w.work_id) as cnt from work w
join product_size p on p.work_id=w.work_id 
join canvas_size c on c.size_id=p.size_id
group by w.name,c.label order by cnt asc limit 3;

15) Which museum is open for the longest during a day. Dispay museum name, state and hours open and which day?
select m.name,m.state,mh.day,open,close,TIMEDIFF(close,open) AS duration
from museum m 
join museum_hours mh on m.museum_id=mh.museum_id
order by duration desc limit 1;

16) Which museum has the most no of most popular painting style?
select m.name,w.style,count(*) as cnt from work w 
join museum m on m.museum_id=w.museum_id 
group by m.name,w.style order by cnt desc limit 1;

17) Identify the artists whose paintings are displayed in multiple countries
select distinct a.full_name,a.nationality,a.style,count(*) as cnt
from museum m join work w on m.museum_id=w.museum_id
join artist a on a.artist_id=w.artist_id
group by a.full_name,a.nationality,a.style
having count(*) >1 order by cnt desc;


18) Display the country and the city with most no of museums. Output 2 seperate columns to mention the city 
and country. If there are multiple value, seperate them with comma.
select m.country,m.city,count(museum_id) as Museum from museum m
group by m.country,m.city order by Museum desc;

SELECT
    (
        SELECT GROUP_CONCAT(country)
        FROM (
            SELECT country
            FROM museum
            GROUP BY country
            ORDER BY COUNT(*) DESC
            LIMIT 1
        ) AS countries
    ) AS country_with_most_museums,
    (
        SELECT GROUP_CONCAT(city)
        FROM (
            SELECT city
            FROM museum
            WHERE country = (
                SELECT country
                FROM (
                    SELECT country
                    FROM museum
                    GROUP BY country
                    ORDER BY COUNT(*) DESC
                    LIMIT 1
                ) AS top_country
            )
            GROUP BY city
            ORDER BY COUNT(*) DESC
            LIMIT 1
        ) AS cities
    ) AS city_with_most_museums;

19) Identify the artist and the museum where the most expensive and least expensive painting is placed. 
Display the artist name, sale_price, painting name, museum name, museum city and canvas label
select a.full_name,p.sale_price,w.name,m.name,m.city,c.label
from museum m 
join work w on m.museum_id=w.museum_id 
join product_size p on w.work_id=p.work_id
join canvas_size c on c.size_id=p.size_id
join  artist a on a.artist_id=w.artist_id
order by sale_price desc limit 1;

select a.full_name,p.sale_price,w.name,m.name,m.city,c.label
from museum m 
join work w on m.museum_id=w.museum_id 
join product_size p on w.work_id=p.work_id
join canvas_size c on c.size_id=p.size_id
join  artist a on a.artist_id=w.artist_id
order by sale_price asc limit 1;

20) Which country has the 5th highest no of paintings?
select m.country,count(*) as cnt from museum m 
join work w on w.museum_id=m.museum_id 
group by m.country
order by cnt desc
limit 1 offset 4;

21) Which are the 3 most popular and 3 least popular painting styles?
select a.style,count(w.work_id) as cnt from artist a
join work w on w.artist_id=a.artist_id
group by a.style order by cnt desc limit 3;

select a.style,count(w.work_id) as cnt from artist a
join work w on w.artist_id=a.artist_id
group by a.style order by cnt asc limit 3;


22) Which artist has the most no of Portraits paintings outside USA?. Display artist name, 
no of paintings and the artist nationality.
select a.full_name,count(*)as NoOfPainting,a.nationality
from artist a
join work w on w.artist_id=a.artist_id
join museum m on m.museum_id=w.museum_id
join subject s on s.work_id=w.work_id
where s.subject='Portraits' and  m.country !='USA'
group by a.full_name,a.nationality
order by NoOfPainting desc limit 1;	


SQL Case Study - Paintings
 Problem Statements
 1. Fetch all the paintings which are not displayed on any museums?
 2. Are there museums without any paintings?
 3. How many paintings have an asking price of more than their regular price?
 4. Identify the paintings whose asking price is less than 50% of its regular price
 5. Which canva size costs the most?
 6. Delete duplicate records from work, product_size, subject and image_link tables
 7. Identify the museums with invalid city information in the given dataset
 8. Museum_Hours table has 1 invalid entry. Identify it and remove it.
 9. Fetch the top 10 most famous painting subject
 10. Identify the museums which are open on both Sunday and Monday. Display 
museum name, city.
 11. How many museums are open every single day?
 12. Which are the top 5 most popular museum? (Popularity is defined based on most 
no of paintings in a museum)
 13. Who are the top 5 most popular artist? (Popularity is defined based on most no of 
paintings done by an artist)
 14. Display the 3 least popular canva sizes
 15. Which museum is open for the longest during a day. Dispay museum name, state 
and hours open and which day?
 16. Which museum has the most no of most popular painting style?
 17. Identify the artists whose paintings are displayed in multiple countries
18. Display the country and the city with most no of museums. Output 2 seperate 
columns to mention the city and country. If there are multiple value, seperate them 
with comma.
 19. Identify the artist and the museum where the most expensive and least expensive 
painting is placed. Display the artist name, sale_price, painting name, museum 
name, museum city and canvas label
 20. Which country has the 5th highest no of paintings?
 21. Which are the 3 most popular and 3 least popular painting styles?
 22. Which artist has the most no of Portraits paintings outside USA?. Display artist 
name, no of paintings and the artist nationality

