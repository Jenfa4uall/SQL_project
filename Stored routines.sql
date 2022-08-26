-- DATA SELECTION FUNCTION
SELECT em_name, salary FROM employees WHERE gender = 'M'
UNION
SELECT em_name, years_in_company FROM employees WHERE gender =
'F';

-- CREATING TRIGGER ON EMPLOYEES TABLE
CREATE TABLE ex_employees (
em_id INT PRIMARY KEY,
em_name VARCHAR(255) NOT NULL,
gender CHAR(1) NOT NULL,
date_left TIMESTAMP DEFAULT NOW()
);

DELIMITER ##
CREATE TRIGGER ex_employees_update BEFORE DELETE ON employees FOR EACH ROW
BEGIN
	INSERT INTO ex_employees(em_id, em_name,gender) VALUES
	(old.id, old.em_name, old.gender);
END ##

DELIMITER ;

-- testing the trigger
DELETE FROM employees WHERE id = 10;
SELECT * FROM ex_semployees;
--  working with variables 
-- SET keyword is used to asign value to a variable and '@' is included before the variable name.
SET @age = 30;
SELECT @age;
SET @age = @age -3;
-- CREATING PROCEDURES
DELIMITER ##
CREATE PROCEDURE select_table()
BEGIN
	SELECT * FROM employees;
    SELECT * FROM mentorships;
END ##
DELIMITER ;

CALL select_table;

-- creating procedure with IN parameter
DELIMITER ##
CREATE PROCEDURE  employee_info(IN p_em_id INT)
BEGIN
	SELECT * FROM mentorships WHERE mentor_id = p_em_id;
	SELECT * FROM mentorships WHERE mentee_id = p_em_id;
	SELECT * FROM employees WHERE id = p_em_id;
END ##
DELIMITER ;

CALL employee_info(2);

select * from employees;
select * from mentorships;

-- creating procedure with IN and OUT parameters
DELIMITER ##
CREATE PROCEDURE mentors_project_status(IN p_id int, OUT p_name varchar(100),OUT p_status varchar(100))
BEGIN
	SELECT  e.em_name, m.status INTO p_name, p_status FROM employees e JOIN mentorships m ON  e.id = m.mentor_id
	WHERE e.id = p_id limit 1;
END ##
DELIMITER ;

CALL mentors_project_status(1, @p_name, @p_status);  

-- CREATING A STORED FUNCTION TO CALCULATE EMPLOYEE BONUS

DELIMITER ##
CREATE FUNCTION employeebonus(p_salary DOUBLE, p_multiplier DOUBLE) RETURNS
DOUBLE DETERMINISTIC 
BEGIN
	DECLARE bonus DOUBLE(8,2);
	SET bonus = p_salary * p_multiplier;
	RETURN bonus;
END ##
DELIMITER ;

SELECT id, em_name, salary, employeebonus(salary, 1.5) AS bonus
FROM employees;

-- Control Flow statement IF,WHILE and LOOP
DELIMITER ##
CREATE FUNCTION if_demo( x INT, y INT) RETURNS VARCHAR (50) DETERMINISTIC
BEGIN
	IF x>y THEN RETURN "PROFITABLE";
    ELSEIF x=y THEN RETURN "NEUTRAL";
    ELSE RETURN "LOSS";
    END IF;
END ##
DELIMITER ;
SELECT if_demo(3,6);

--  Case statement
DELIMITER ##
CREATE FUNCTION level_demoo (age int, salary float) RETURNS VARCHAR (50) 
DETERMINISTIC
BEGIN
	CASE 
		WHEN age >= 35 AND salary >57000 THEN RETURN "General Manager";
        ELSE RETURN "INTERN";
	END CASE;
END ##
DELIMITER ;

SELECT 
	level_demoo(Age, Salary) AS level
FROM emp_details;
