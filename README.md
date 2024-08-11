# SQL Case Study Report: Paintings & Museum 
## Introduction
This report provides a comprehensive analysis of various aspects related to paintings, museums, and artists. Each problem statement is addressed with a concise description of the objective.

## Objective
Understanding the relationships between paintings, museums, and artists, and uncovering insights through SQL queries.

## Data Overview
### Files and Columns
1. artist.csv
   - artist_id: Unique id of artist.
   - full_name: Complete name of artist.
   - first_name: First name of artist.
   - middle_names: Middle name of artist.
   - last_name: Last name of artist.
   - nationality: Nationality of artist.
   - style: Artistic style of artist.
   - birth: Birth date of artist.
   - death: Death date of artist.
2. canvas_size.csv
   - size_id: Unique id of canvas.
   - width: Width of canvas.
   - height: Height of canvas.
   - label: Label of canvas.
3. image_link.csv
   - work_id: Id for the painting. 
   - url: URL of image.
   - thumbnail_small_url: URL for the small thumbnail. 
   - thumbnail_large_url: URL for the large thumbnail
4. museum.csv
   - museum_id: Unique id of museum.
   - name: Name of museum.
   - address: Address of museum. 
   - city: City where museum is located.
   - state: State where the museum is located.
   - postal: Postal code of museum.
   - country: Country where museum is located. 
   - phone: Contact number of museum.
   - url: Website link of museum.
5. museum_hours.csv
   - museum_id: Unique id for the museum.
   - day: Day of week.
   - open: Opening time.
   - close: Closing time.
6. product_size.csv
   - work_id: Id for the painting.
   - size_id: Id for the canvas size.
   - sale_price: Sale price of painting.
   - regular_price: Regular price of painting.
7. subject.csv
   - work_id: Id for the painting.
   - subject: Subject of the painting.
8. work.csv
   - work_id: Unique Id for the painting.
   - name: Name of the painting.
   - artist_id: Id for the artist.
   - style: Artistic style of the painting.
   - museum_id: Id for the museum.

There are total 8 files & 41 columns.

### Data Sources: For this analysis, we used dataset available at: [link of dataset](https://data.world/atlas-query/paintings)
  
## Analysis Methodology
### Approach: 
SQL queries were crafted to address each problem statement, leveraging joins, aggregations, and filtering techniques.

### Tools and Techniques: 
Analysis was performed using MySQL Workbench. SQL functions such as JOIN, GROUP BY, and WHERE clauses were employed.

## Problem Statements and Descriptions
These are the list of problem to be indentified:
1. Fetch All Paintings Not Displayed in Any Museums
- List all paintings not displayed in any museums.
2. Museums Without Any Paintings
- Identify museums that have no paintings.
3. Paintings with Asking Price Greater Than Regular Price
- Count paintings where the asking price exceeds the regular price.
4. Paintings with Asking Price Less Than 50% of Regular Price
- Find paintings with an asking price less than 50% of the regular price.
5. Most Expensive Canvas Size
- Determine the most expensive canvas size.
6. Find Duplicate Records
- Detect duplicate records from specified tables.
7. Museums with Invalid City Information
- Detect museums with invalid city information.
8. Invalid Entry in Museum_Hours Table
- Locate and delete the invalid entry in the Museum_Hours table.
9. Top 10 Most Famous Painting Subjects
- Retrieve the top 10 most famous painting subjects.
10. Museums Open on Both Sunday and Monday
- List museums open on both Sunday and Monday.
11. Museums Open Every Single Day
- Count museums open every day of the week.
12. Top 5 Most Popular Museums
- Identify the top 5 museums based on the number of paintings.
13. Top 5 Most Popular Artists
- Find the top 5 artists with the most paintings.
14. Three Least Popular Canvas Sizes
- Display the 3 least popular canvas sizes.
15. Museum Open for the Longest Duration in a Day
- Identify the museum with the longest daily opening hours.
16. Museum with the Most Popular Painting Style
- Find the museum with the most popular painting style.
17. Artists with Paintings Displayed in Multiple Countries
- Identify artists whose paintings are displayed in multiple countries.
18. City and Country with Most Museums
- Find the city and country with the most museums.
19. Artist and Museum for Most and Least Expensive Paintings
- Locate the artist and museum for both the most and least expensive paintings.
20. Country with the 5th Highest Number of Paintings
- Determine the country with the 5th highest number of paintings.
21. Three Most and Three Least Popular Painting Styles
-Identify the 3 most and 3 least popular painting styles.
22. Artist with Most Portrait Paintings Outside the USA
- Find the artist with the most portraits outside the USA.

## Analysis and Findings
1. Paintings Not Displayed in Museums
- Every paintings are currently displayed in any museum. 

2. Museums Without Paintings
- There are total 16 museums that do not have any paintings associated with them.

3. Paintings with Sale Price Higher than Regular Price
-  Found that 0 paintings are listed with a sale price that exceeds their regular price.

4. Paintings with Sale Price Less than 50% of Regular Price
- The analysis highlighted paintings offered at less than 50% of their regular price, indicating significant discounts or pricing errors.

  ![image](https://github.com/user-attachments/assets/389edaa8-b710-4a8f-a937-8c1e30b74797)

5. Most Expensive Canvas Size
- The canvas size commanding the highest price was "48 x 96"(122 cm x 244 cm)' with price of $1115.

6. Duplicate Records
- Duplicate records were detected and removed from the work, product_size, subject, and image_link.

7. Museums with Invalid City Information
- There're total 6 Museums with invalid city data, such as numeric values.

8. Invalid Entry in Museum Hours Table
- Invalid entry in the museum_hours table was identified and removed.

9. Top 10 Most Famous Painting Subjects
- The top 10 painting subjects based on the number of associated paintings were : 

![image](https://github.com/user-attachments/assets/39f5005f-52ca-4b03-aa5f-07c3b12e29b1)

10. Museums Open on Both Sunday and Monday
- Museums that are open on both Sunday and Monday were:

  ![image](https://github.com/user-attachments/assets/d122020c-bdb1-4e91-a43e-dc143817216c)

11. Museums Open Every Day
- The number of museums open every day of the week was 17.

12. Top 5 Most Popular Museums
- The top 5 museums were identified based on the number of paintings they display.

  ![image](https://github.com/user-attachments/assets/b5410496-7e16-43dd-888b-38569a768779)

13. Top 5 Most Popular Artists
- The analysis revealed the top 5 artists with the highest number of paintings.

  ![image](https://github.com/user-attachments/assets/8944cfdc-a959-417a-976d-1add0f2d0a3f)

14. Least Popular Canvas Sizes
- The 3 least popular canvas sizes were identified based on the number of paintings associated with each size.

  ![image](https://github.com/user-attachments/assets/e66b2a1f-26e4-45df-a320-c3f29285c378)

15. Museum with the Longest Daily Opening Duration
- The museum with the longest daily opening hours was:

  ![image](https://github.com/user-attachments/assets/703fa331-ba66-4f43-bc86-ff58ecaa7861)

16. Museum with Most Popular Painting Style
- The museum featuring the highest number of the most popular painting styles was:

  ![image](https://github.com/user-attachments/assets/36b104d0-3a8d-41f4-a1d5-cfdbbce22a1d)

17. Artists Displayed in Multiple Countries
- Artists whose paintings are exhibited in multiple countries were:

  ![image](https://github.com/user-attachments/assets/00e83b8f-11df-46aa-88b4-8b750b0a3461)

18. Country and City with Most Museums
- The country and city with the highest number of museums were USA & New York.

19. Most and Least Expensive Paintings
- The artist and museum associated with both the most expensive was

![image](https://github.com/user-attachments/assets/4a221f59-15b4-4b1d-afd0-8201f3845d45)

- And least expensive paintings was

![image](https://github.com/user-attachments/assets/fa822b29-8c9e-4742-a47a-61597b0f1fea)

20. Country with the 5th Highest Number of Paintings
- The country with the fifth highest number of paintings was UK.

21. Most and Least Popular Painting Styles
- The 3 most popular

  ![image](https://github.com/user-attachments/assets/20a74d0c-6df9-45d9-bbd4-53e94e83a55f)

- And 3 least popular painting styles 

  ![image](https://github.com/user-attachments/assets/6dc69d23-1b08-465e-89f5-885c148d4d21)

22. Artist with Most Portrait Paintings Outside the USA
- The artist with the highest number of portrait paintings displayed outside the USA was

  ![image](https://github.com/user-attachments/assets/8f6b36c8-8bb1-417f-a6cb-8f369f49ecc3)

### SQL Queries
For detailed reference, the SQL queries used for each analysis can be found at the following link: [SQL Queries for Analysis](https://github.com/SaileshBasnet/SQL-Case-Study---Paintings/blob/main/painting.sql)

## Conclusion
The analysis provided valuable insights into various aspects of paintings, museums, and artists. Key findings include the identification of the most and least popular painting styles, the museums with the most and least paintings, and artists with the highest number of paintings displayed in multiple countries. The report highlights areas such as pricing anomalies, museum operating hours, and popular subjects, offering a comprehensive overview of the dataset.

