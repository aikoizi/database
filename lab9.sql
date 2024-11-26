--1
CREATE OR REPLACE FUNCTION increase_value(INOUT value INTEGER)
AS $$
BEGIN
    value := value + 10;
END;
$$ LANGUAGE plpgsql;

SELECT increase_value(5);
--2
CREATE OR REPLACE FUNCTION compare_numbers(num1 INTEGER, num2 INTEGER)
RETURNS TEXT AS $$
BEGIN
    IF num1 > num2 THEN
        RETURN 'Greater';
    ELSIF num1 = num2 THEN
        RETURN 'Equal';
    ELSE
        RETURN 'Lesser';
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT compare_numbers(10, 5);
--3
CREATE OR REPLACE FUNCTION number_series(n INTEGER)
RETURNS TEXT AS $$
DECLARE
    i INTEGER;
    series TEXT := '';
BEGIN
    FOR i IN 1..n LOOP
        series := series || i || ', ';
    END LOOP;
    RETURN TRIM(TRAILING ', ' FROM series);
END;
$$ LANGUAGE plpgsql;

SELECT number_series(5);
--4
CREATE OR REPLACE FUNCTION find_employee(emp_name TEXT)
RETURNS TEXT AS $$
DECLARE
    emp_details TEXT;
BEGIN
    SELECT 'ID: ' || employee_id || ', Name: ' || name || ', Position: ' || position
    INTO emp_details
    FROM employees
    WHERE name = emp_name;

    RETURN emp_details;
END;
$$ LANGUAGE plpgsql;
--5
CREATE OR REPLACE FUNCTION list_products(category_name TEXT)
RETURNS TABLE(product_id INTEGER, product_name TEXT, price NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT product_id, product_name, price
    FROM products
    WHERE category = category_name;
END;
$$ LANGUAGE plpgsql;
--6
CREATE OR REPLACE FUNCTION calculate_bonus(base_salary NUMERIC)
RETURNS NUMERIC AS $$
BEGIN
    RETURN base_salary * 0.1;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_salary(emp_id INTEGER)
RETURNS VOID AS $$
DECLARE
    bonus NUMERIC;
BEGIN
    bonus := calculate_bonus((SELECT salary FROM employees WHERE employee_id = emp_id));
    UPDATE employees
    SET salary = salary + bonus
    WHERE employee_id = emp_id;
END;
$$ LANGUAGE plpgsql;
--7
CREATE OR REPLACE FUNCTION complex_calculation(input_number INTEGER, input_string TEXT)
RETURNS TEXT AS $$
DECLARE
    numeric_result INTEGER;
    string_result TEXT;
BEGIN
    numeric_result := input_number * 2;
    BEGIN
        string_result := input_string || ' processed';
    END;
    RETURN 'Number: ' || numeric_result || ', String: ' || string_result;
END;
$$ LANGUAGE plpgsql;

SELECT complex_calculation(5, 'Data');