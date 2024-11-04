create table locations(
    location_id SERIAL PRIMARY KEY,
    street_address VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(30),
    state_province VARCHAR(12)
);
create table departments(
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE,
    budget INTEGER,
    location_id INTEGER REFERENCES locations
);
create table employees(
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    salary INTEGER,
    department_id INTEGER REFERENCES departments
);

INSERT INTO locations(street_address,postal_code,city,state_province)
VALUES ('Navoi 296','1111','Almaty','Al'),
       ('64 Steven J','2202','Marsel','FR'),
       ('3 Green island', '1945','Yorkshin','CU'),
       ('112 Ocean Avenue','1974','Amityville','NY');

INSERT INTO departments(department_name, budget, location_id)
VALUES ('HxH',20000,1),   -- 1 almaty
       ('IT',1000,2),     -- 2 marsel
       ('Magic',5000,3),  -- 3 yorkshin
       ('Marine',4000,4); -- 4 amityville

INSERT INTO employees(first_name, last_name, email, phone_number, salary, department_id)
VALUES ('Amina','Snoop','snoop@dog.com','666-666',50000,1),    --hxh
       ('Adiya','Potter','potter@dog.com','11-2001',1000,2),   --it
       ('Steven','Jonson','cuttie@dog.com','777-777',900000,3),--magic
       ('Samira','Fein','fein@dog.com','477-005',2000,4);      --marine
--3
SELECT e.first_name,e.last_name,e.department_id,d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;
--4
SELECT e.first_name,e.last_name,e.department_id,d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id WHERE e.department_id BETWEEN 80 and 40;
--5
SELECT e.first_name,e.last_name,d.department_name,l.city,l.state_province
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id;
--6
SELECT d.department_id,d.department_name,e.first_name,e.last_name
FROM departments d
LEFT JOIN employees e on d.department_id = e.department_id;
--7
SELECT e.first_name,e.last_name,d.department_id,d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;



