CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(40),
    last_name VARCHAR(40),
    birth_day DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT,
    branch_id INT
);CREATE TABLE branch (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(40),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE
    SET
        NULL
);
ALTER TABLE
    employee
ADD
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE
SET
    NULL;
ALTER TABLE
    employee
ADD
    FOREIGN KEY(super_id) REFERENCES employee(emp_id) ON DELETE
SET
    NULL;CREATE TABLE client (
        client_id INT PRIMARY KEY,
        client_name VARCHAR(40),
        branch_id INT,
        FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE
        SET
            NULL
    );CREATE TABLE works_with (
        emp_id INT,
        client_id INT,
        total_sales INT,
        PRIMARY KEY(emp_id, client_id),
        FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
        FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
    );CREATE TABLE branch_supplier (
        branch_id INT,
        supplier_name VARCHAR(40),
        supply_type VARCHAR(40),
        PRIMARY KEY(branch_id, supplier_name),
        FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
    );-- -----------------------------------------------------------------------------
    -- Corporate
INSERT INTO
    employee
VALUES(
        100,
        'David',
        'Wallace',
        '1967-11-17',
        'M',
        250000,
        NULL,
        NULL
    );
INSERT INTO
    branch
VALUES(1, 'Corporate', 100, '2006-02-09');
UPDATE
    employee
SET
    branch_id = 1
WHERE
    emp_id = 100;
INSERT INTO
    employee
VALUES(
        101,
        'Jan',
        'Levinson',
        '1961-05-11',
        'F',
        110000,
        100,
        1
    );-- Scranton
INSERT INTO
    employee
VALUES(
        102,
        'Michael',
        'Scott',
        '1964-03-15',
        'M',
        75000,
        100,
        NULL
    );
INSERT INTO
    branch
VALUES(2, 'Scranton', 102, '1992-04-06');
UPDATE
    employee
SET
    branch_id = 2
WHERE
    emp_id = 102;
INSERT INTO
    employee
VALUES(
        103,
        'Angela',
        'Martin',
        '1971-06-25',
        'F',
        63000,
        102,
        2
    );
INSERT INTO
    employee
VALUES(
        104,
        'Kelly',
        'Kapoor',
        '1980-02-05',
        'F',
        55000,
        102,
        2
    );
INSERT INTO
    employee
VALUES(
        105,
        'Stanley',
        'Hudson',
        '1958-02-19',
        'M',
        69000,
        102,
        2
    );-- Stamford
INSERT INTO
    employee
VALUES(
        106,
        'Josh',
        'Porter',
        '1969-09-05',
        'M',
        78000,
        100,
        NULL
    );
INSERT INTO
    branch
VALUES(3, 'Stamford', 106, '1998-02-13');
UPDATE
    employee
SET
    branch_id = 3
WHERE
    emp_id = 106;
INSERT INTO
    employee
VALUES(
        107,
        'Andy',
        'Bernard',
        '1973-07-22',
        'M',
        65000,
        106,
        3
    );
INSERT INTO
    employee
VALUES(
        108,
        'Jim',
        'Halpert',
        '1978-10-01',
        'M',
        71000,
        106,
        3
    );-- Buffalo
INSERT INTO
    branch
VALUES(4, 'Buffalo', NULL, NULL);-- BRANCH SUPPLIER
INSERT INTO
    branch_supplier
VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO
    branch_supplier
VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO
    branch_supplier
VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO
    branch_supplier
VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO
    branch_supplier
VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO
    branch_supplier
VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO
    branch_supplier
VALUES(3, 'Stamford Lables', 'Custom Forms');-- CLIENT
INSERT INTO
    client
VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO
    client
VALUES(401, 'Lackawana Country', 2);
INSERT INTO
    client
VALUES(402, 'FedEx', 3);
INSERT INTO
    client
VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO
    client
VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO
    client
VALUES(405, 'Times Newspaper', 3);
INSERT INTO
    client
VALUES(406, 'FedEx', 2);-- WORKS_WITH
INSERT INTO
    works_with
VALUES(105, 400, 55000);
INSERT INTO
    works_with
VALUES(102, 401, 267000);
INSERT INTO
    works_with
VALUES(108, 402, 22500);
INSERT INTO
    works_with
VALUES(107, 403, 5000);
INSERT INTO
    works_with
VALUES(108, 403, 12000);
INSERT INTO
    works_with
VALUES(105, 404, 33000);
INSERT INTO
    works_with
VALUES(107, 405, 26000);
INSERT INTO
    works_with
VALUES(102, 406, 15000);
INSERT INTO
    works_with
VALUES(105, 406, 130000);------------------------------------------------------------
    -- Find all employees ordered by salary
SELECT
    *
FROM
    employee
ORDER BY
    salary;-- Find all employees ordered by sex then name
SELECT
    *
FROM
    employee
ORDER BY
    sex,
    first_name,
    last_name;-- Select the least 5 payed employess
SELECT
    first_name,
    last_name,
    salary AS yearSalary
FROM
    employee
ORDER BY
    salary ASC
LIMIT
    5;-- Select all different sexes of the employees
SELECT
    DISTINCT sex
from
    employee;-- Find the number of female employees
SELECT
    COUNT(emp_id)
FROM
    employee
WHERE
    sex = 'F';-- Find the average of all employee salaries
SELECT
    AVG(salary)
FROM
    employee
WHERE
    sex = 'M';-- The sum of all employees salaries
SELECT
    SUM(salary)
FROM
    employee;-- Aggregation---------------------------
    -- How many males and females
SELECT
    COUNT(sex),
    sex
FROM
    employee
GROUP BY
    sex;-- Total sales of every salseman
SELECT
    SUM(total_sales),
    emp_id
FROM
    works_with
GROUP BY
    emp_id;-- Total sales of each branch
SELECT
    SUM(total_sales),
    client_id
FROM
    works_with
GROUP BY
    client_id DESC;-- Wild Cards----------------------------
    -- % =  any number of characters // _ = one character
    -- Find any brach suppliers who are in the label busniess
SELECT
    *
FROM
    branch_supplier
WHERE
    supplier_name LIKE '%Label%';-- Find all employees born in October
Select
    *
FROM
    employee
WHERE
    birth_day LIKE '____-10%';--Unions-------------------------------
    -- Generate a list of all employees and branch names
SELECT
    first_name AS comp_data
FROM
    employee
UNION
SELECT
    branch_name
FROM
    branch;--Joins-----------------------------------
    -- Branches and the name of their managers (JOIN)
SELECT
    employee.emp_id,
    employee.first_name,
    branch.branch_name
FROM
    employee
    JOIN branch ON branch.mgr_id = employee.emp_id;-- (LEFT JOIN : all elements from the employee table)
SELECT
    employee.emp_id,
    employee.first_name,
    branch.branch_name
FROM
    employee
    LEFT JOIN branch ON branch.mgr_id = employee.emp_id;-- (RIGHT JOIN : all elements from the branch table)
SELECT
    employee.emp_id,
    employee.first_name,
    branch.branch_name
FROM
    employee
    RIGHT JOIN branch ON branch.mgr_id = employee.emp_id;-- 4th type of JOIN called OUTER JOIN which is
    -- LEFT & RIGHT JOIN combined but it doesn' work in MySQL
    -- Nested Queries
    -- Find the name of all employees who have sold
    -- more than 30000  to a single client
SELECT
    employee.first_name,
    employee.last_name
FROM
    employee
WHERE
    employee.emp_id IN (
        SELECT
            works_with.emp_id
        FROM
            works_with
        WHERE
            total_sales > 30000
    );-- Select all clients who works with the branch that
    -- michel scott manages
SELECT
    client.client_name
FROM
    client
WHERE
    client.branch_id = (
        SELECT
            branch.branch_id
        FROM
            branch
        WHERE
            mgr_id = 102
    );
SELECT
    *
FROM
    employee;-- On delete set NULL
    -- we use it when the column isnt a primary key
DELETE FROM
    employee
WHERE
    emp_id = 102;
SELECT
    *
FROM
    employee;
SELECT
    *
FROM
    branch;-- On delete CASCADE
    -- we use it whene we are deleting a primary key
    -- for ex if we delete branch 3(it is a prim key in branch_supplier) then all the rows form
    -- branch_supplier who hase branch_id 3 will get deleted automaticaly
DELETE FROM
    branch
WHERE
    branch_id = 3;
SELECT
    *
FROM
    branch_supplier;--TRIGGERS
    /*
    DELIMITER &
    CREATE
      TRIGGER my_trigger BEFORE INSERT
      ON employee
      FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES('new emp added');
        END &
    DELIMITER ;
    */
    /*
    DELIMITER &
    CREATE
      TRIGGER my_trigger1 BEFORE INSERT
      ON employee
      FOR EACH ROW BEGIN
        INSERT INTO trigger_test VALUES(NEW.first_name);
        END &
    DELIMITER ;
    */
    /*
    DELIMITER $$
    CREATE
      TRIGGER my_trigger2 BEFORE INSERT
      ON employee
      FOR EACH ROW BEGIN
        IF NEW.sex = 'M' THEN
            INSERT INTO trigger_test VALUES('welcome man');
        ELSEIF NEW.sex = 'F' THEN
            INSERT INTO trigger_test VALUES('welcome female');
        END IF;
      END$$
    DELIMITER ;
    */
    -- DROP TRIGGER my_trigger
INSERT INTO
    employee
VALUES(
        109,
        'Oscar',
        'Martinez',
        '1968-02-19',
        'M',
        69000,
        102,
        2
    );
INSERT INTO
    employee
VALUES(
        110,
        'Kevin',
        'Malone',
        '1978-02-19',
        'M',
        69000,
        102,
        2
    );
INSERT INTO
    employee
VALUES(
        111,
        'Pam',
        'Beesly',
        '1988-02-19',
        'F',
        69000,
        102,
        2
    );
SELECT
    *
FROM
    employee;
SELECT
    *
FROM
    trigger_test;
UPDATE
    employee
SET
    super_id = 102
WHERE
    super_id = NULL;
