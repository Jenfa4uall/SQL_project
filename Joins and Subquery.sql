-- Welcome!!!

-- This project is focused on using Joins and Subquery 
-- This project will be using sports_booking database, the data can be found on my previous project on DDL and DML. To follow along, you might need to check 
-- that and replicate the tables.

-- Joins are used to merge two or more tables together from different databases or within the same database.
USE sports_booking;

 ALTER TABLE bookings
 RENAME COLUMN id to book_id; -- renaming id column in bookings table. 
 
-- USING INNER JOIN
-- Task 1 Looking for members who booked on the day they become a member.
-- Inner join returns records where the values in the columns used in joining the tables intersect.
 SELECT * FROM bookings b 
 JOIN members m 
 ON b.datetime_of_booking = m.member_since; -- This returns empty records, because no member booked a room the same day they become a member 
 
 -- Joining bookings,members, and rooms tables together
 SELECT * FROM bookings b JOIN members m ON b.member_id = m.id
 JOIN rooms r ON b.room_id = r.id;
 
 -- Join can go alomg with filter
 SELECT b.member_id,
        r.room_type FROM bookings b JOIN members m ON b.member_id = m.id
 JOIN rooms r ON b.room_id = r.id
 WHERE payment_status = 'Unpaid' OR 'Cancelled';
 
 -- Working with Left join
 -- Left join returns all the records on the left table and returns records from the right table where the values matches the left table. 
 
  SELECT * FROM bookings b LEFT JOIN members m 
 ON b.member_id = m.id; -- Running this query will return the all the records from bookings table even if there is no matches in the members table.

 -- Let us try to update member table with a new record 
 INSERT INTO members(id, password, email)
 VALUE('jst001', 'sweet_y21', 'may_ju@mysql.com');
 
 -- Let us view the record inserted
 SELECT * FROM members WHERE id = 'jst001';
 
 -- Using the Right join 
 -- All records on the members table are returned and returns null for records that can't be matched on bookings table. 
  SELECT * FROM bookings b
  RIGHT JOIN members m 
 ON b.member_id = m.id; -- This result shows members that have not booked before including our newly added member(jst001)
 
 -- We can filter the table
  SELECT * FROM bookings b RIGHT JOIN members m 
 ON b.member_id = m.id
 WHERE b.book_id IS NULL; -- This shows 5 records
 
 -- Cross join returns all records from both tables
  SELECT count(*) FROM bookings CROSS JOIN members; -- This returns large records
 
 -- Applying ON keyword in Cross join will produce result as INNER JOIN
 SELECT count(*) FROM bookings b CROSS JOIN members m 
 ON b.member_id = m.id; -- This returns 21 records
 
  SELECT count(*) 
  FROM bookings b 
  JOIN members m 
	ON b.member_id = m.id; -- This also returns 21 records.
 
 -- SUBQUERY
 -- Checking the date when room(s) in badminton court was booked.
 SELECT booked_date
 FROM bookings 
 WHERE room_id IN(
			SELECT id FROM rooms WHERE room_type= 'Badminton Court'
            )
 ORDER BY booked_date DESC;
 
  -- Checking the date when room type that contain "co" was booked.
  SELECT booked_date
 FROM bookings 
 WHERE room_id = ANY (
			SELECT id FROM rooms WHERE room_type LIKE '%Co%'
            )
 ORDER BY booked_date DESC;
 
 -- CHECKING for members who have booked a room with average price equal or greater than 80. 
 SELECT k.member_id
 FROM (
 SELECT * FROM bookings b, rooms r
 WHERE b.room_id = r.id) k
  GROUP BY k.room_type, k.member_id
 HAVING AVG(price) >= 80;
 
 -- Subquery and Joins are very important in data manipulation as displayed in the project. 
 -- Thanks for following along. 


 

 
 
 
 