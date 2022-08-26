-- creating a tutorial database
	CREATE DATABASE tutorial;
-- using newly created database
	USE tutorial;
-- Table Creation with constraint. Employee table and mentorships table will be created.
-- employee table will contain details like id,name,gender, contact number, age and date created.
-- each employee was assigned a unique id which is generated automatically while constraint were set on name,gender, age and date created to be NOT NULL
-- id column which is unique was set as the employee table primary key.
CREATE TABLE co_employees( id int auto_increment,
						em_name varchar(200) not null,
                        gender varchar(1) not null,
                        contact_number varchar(200),
                        age int not null,
                        date_created timestamp not null default now(),
		primary key(id)
        );
        
--  On mentorships table, attribute like mentor_id and mentee_id is set to be not null. status which is the status of the project.
-- since a primary key is a unique key, and a mentor can have many mentee and a mentee can have many mentor which make it hard to us the two 
-- columns as primary key. The mentee_id,mentor_id and project column will serve as our primary key. Also since both mentor and mentee are employee with an id which is a primary key on employee table, then mentee_id and mentor_id become foriegn key on mentorships table.alter
-- Constraint is set on the foreign keys(mentor_id and mentee_id) that update is not allowed on employees table, and when a row is deleted on employees table,the row should be deleted in mentorships table as well

CREATE TABLE mentorships(mentor_id int not null,
						mentee_id int not null,
                        status varchar(25),
                        project varchar(25),
	primary key(mentor_id, mentee_id, project),
    constraint fk1 foreign key (mentor_id) references co_employees(id) on update restrict on delete cascade,
    constraint fk2 foreign key(mentee_id) references co_employees(id) on update restrict on delete cascade);
    
-- renaming of table
RENAME TABLE  co_employees to employees;

-- modification of columns, and addition of columns
ALTER TABLE  employees
	DROP column age,
	ADD COLUMN salary FLOAT NOT NULL AFTER contact_number,
	ADD COLUMN years_in_company  INT NOT NULL AFTER salary;
-- checking the table structure
DESCRIBE employees;

-- modification of contraint in mentorships table
ALTER TABLE mentorships
DROP CONSTRAINT fk1;

ALTER TABLE mentorships
ADD CONSTRAINT fk1 FOREIGN KEY(mentor_id) REFERENCES employees(id) ON DELETE CASCADE ON UPDATE CASCADE; 

-- Inserting values in employees table. The id column was excluded because it is auto while the date_created is default.
INSERT INTO employees (em_name, gender, contact_number, salary,
years_in_company) VALUES
('James Lee', 'M', '516-514-6568', 3500, 11),
('Peter Pasternak', 'M', '845-644-7919', 6010, 10),
('Clara Couto', 'F', '845-641-5236', 3900, 8),
('Walker Welch', 'M', NULL, 2500, 4),
('Li Xiao Ting', 'F', '646-218-7733', 5600, 4),
('Joyce Jones', 'F', '523-172-2191', 8000, 3),
('Jason Cerrone', 'M', '725-441-7172', 7980, 2),
('Prudence Phelps', 'F', '546-312-5112', 11000, 2),
('Larry Zucker', 'M', '817-267-9799', 3500, 1),
('Serena Parker', 'F', '621-211-7342', 12000, 1);

-- inserting values into mentorships table
INSERT INTO mentorships VALUES
(1, 2, 'Ongoing', 'SQF Limited'),
(1, 3, 'Past', 'Wayne Fibre'),
(2, 3, 'Ongoing', 'SQF Limited'),
(3, 4, 'Ongoing', 'SQF Limited'),
(6, 5, 'Past', 'Flynn Tech');

-- querying the tables created
SELECT * FROM employees;
SELECT * FROM mentorships;