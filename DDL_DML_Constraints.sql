-- This is a project of Data Definition and Manipulation Language
-- This will be an end to end process from database creation, tables creations, constaraints etc.

-- Creating a database named Sports_bookings
CREATE DATABASE Sports_booking;
-- Creating tables inside the database
-- creating bookings table
CREATE TABLE bookings(id INT NOT NULL auto_increment, room_id varchar(45) NOT NULL,
book_date DATE NOT NULL, booked_time timestamp NOT NULL DEFAULT NOW(), member_id varchar(45) NOT NULL,
datetime_of_booking DATETIME NOT NULL DEFAULT current_timestamp, payment_status varchar(45) NOT NULL,
PRIMARY KEY(id));

-- creating members table
CREATE TABLE members(id varchar(45) NOT NULL PRIMARY KEY, password varchar(250) NOT NULL, email varchar(250) NOT NULL,
member_since DATETIME NOT NULL DEFAULT current_timestamp, payment_due float NOT NULL DEFAULT 0); -- setting members with no due payment to default 0

-- creating termination table
CREATE TABLE pending_terminations(id varchar(45) NOT NULL PRIMARY KEY, email varchar(250) NOT NULL, 
request_date DATETIME NOT NULL DEFAULT current_timestamp, payment_due FLOAT NOT NULL);

-- creating rooms table
CREATE TABLE room(id varchar(45) NOT NULL PRIMARY KEY, room_type varchar(250) NOT NULL, price FLOAT NOT NULL);

-- Viewig tables created
SHOW TABLES IN Sports_booking;

-- renaming room table to rooms
ALTER TABLE room
rename to rooms;

-- adding foriengn keys constraints  to bookings table
ALTER TABLE bookings
ADD FOREIGN KEY(room_id) REFERENCES rooms(id) ON DELETE CASCADE ON UPDATE CASCADE;
-- When id from rooms is deleted, room id from booking should be deleted as well. Same as when update is done.
ALTER TABLE bookings
ADD FOREIGN KEY(member_id) REFERENCES members(id) ON DELETE CASCADE ON UPDATE CASCADE;

-- changing booked time column datatype on bookings table
ALTER TABLE bookings
MODIFY COLUMN booked_time TIME; 

-- renaming the book_date column in bookings table 
ALTER TABLE bookings
RENAME COLUMN book_date to booked_date;

-- Inserting values into the tables created
INSERT INTO members (id, password, email, member_since,
payment_due) VALUES
('afeil', 'feil1988<3', 'Abdul.Feil@hotmail.com', '2017-04-15 12:10:13', 0),
('amely_18', 'loseweightin18', 'Amely.Bauch91@yahoo.com', '2018-02-06 16:48:43', 0),
('bbahringer', 'iambeau17', 'Beaulah_Bahringer@yahoo.com', '2017-12-28 05:36:50', 0),
('little31', 'whocares31', 'Anthony_Little31@gmail.com', '2017-06-01 21:12:11', 10),
('macejkovic73', 'jadajeda12', 'Jada.Macejkovic73@gmail.com',
'2017-05-30 17:30:22', 0),
('marvin1', 'if0909mar', 'Marvin_Schulist@gmail.com', '2017-09-09 02:30:49', 10),
('nitzsche77', 'bret77@#', 'Bret_Nitzsche77@gmail.com', '2018-01-09 17:36:49', 0),
('noah51', '18Oct1976#51', 'Noah51@gmail.com', '2017-12-16 22:59:46', 0),
('oreillys', 'reallycool#1', 'Martine_OReilly@yahoo.com', '2017-10-12 05:39:20', 0),
('wyattgreat', 'wyatt111', 'Wyatt_Wisozk2@gmail.com', '2017-07-18 16:28:35', 0);

INSERT INTO rooms (id, room_type, price) VALUES
('AR', 'Archery Range', 120),
('B1', 'Badminton Court', 8),
('B2', 'Badminton Court', 8),
('MPF1', 'Multi Purpose Field', 50),
('MPF2', 'Multi Purpose Field', 60),
('T1', 'Tennis Court', 10),
('T2', 'Tennis Court', 10);

INSERT INTO bookings (room_id, booked_date, booked_time,
member_id, datetime_of_booking, payment_status) VALUES
('AR', '2017-12-26', '13:00:00', 'oreillys', '2017-12-20 20:31:27', 'Paid'),
('MPF1', '2017-12-30', '17:00:00', 'noah51', '2017-12-22 05:22:10', 'Paid'),
('T2', '2017-12-31', '16:00:00', 'macejkovic73', '2017-12-28 18:14:23', 'Paid'),
('T1', '2018-03-05', '08:00:00', 'little31', '2018-02-22 20:19:17', 'Unpaid'),
('MPF2', '2018-03-02', '11:00:00', 'marvin1', '2018-03-01 16:13:45', 'Paid'),
('B1', '2018-03-28', '16:00:00', 'marvin1', '2018-03-23 22:46:36', 'Paid'),
('B1', '2018-04-15', '14:00:00', 'macejkovic73', '2018-04-12 22:23:20', 'Cancelled'),
('T2', '2018-04-23', '13:00:00', 'macejkovic73', '2018-04-19 10:49:00', 'Cancelled'),
('T1', '2018-05-25', '10:00:00', 'marvin1', '2018-05-21 11:20:46', 'Unpaid'),
('B2', '2018-06-12', '15:00:00', 'bbahringer', '2018-05-30 14:40:23', 'Paid');

-- Exploring the data inserted
SELECT * FROM sports_booking.bookings LIMIT 5;
SELECT * FROM sports_booking.members LIMIT 5;
SELECT * FROM sports_booking.rooms LIMIT 5;

-- Testing my constraints, I tried to update my bookings table using this statement "INSERT INTO bookings(room_id, booked_date, booked_time,
-- member_id,payment_status) VALUE ('JA', '2022-12-26', '13:00:00', 'jsuit','Paid');" 
-- I encountered an error which is expected because my room_id and member_id are foriegn keys and they are yet to be updated on their primary tables.
-- Inserting a new record in members and rooms table
INSERT INTO members (id, password, email, member_since,
payment_due) VALUES
('jsuit', 'feil1988ts', 'jenfa.js@hotmail.com', '2017-04-15 12:10:13', 0);

INSERT INTO rooms (id, room_type, price) VALUES
('JA', 'Archery Range', 200);

-- add a new record on bookings table. No error encountered again.
INSERT INTO bookings(room_id, booked_date, booked_time,
member_id,payment_status) VALUE ('JA', '2022-12-26', '13:00:00', 'jsuit','Paid');

-- Testing constraint ON DELETE CASCASE
DELETE FROM rooms WHERE id = 'JA';
SELECT * FROM sports_booking.bookings WHERE room_id = 'JA'; -- running this script returns null records which is expected.

-- Update keyword
UPDATE rooms SET price = 250 WHERE id = 'JA';

-- Thanks you.
