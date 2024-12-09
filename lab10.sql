CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    price DECIMAL(10, 2),
    quantity INT
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    book_id INT,
    customer_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255)
);

INSERT INTO Books (book_id, title, author, price, quantity) VALUES
(1, 'Database 101', 'A. Smith', 40.00, 10),
(2, 'Learn SQL', 'B. Johnson', 35.00, 15),
(3, 'Advanced DB', 'C. Lee', 50.00, 5);

INSERT INTO Customers (customer_id, name, email) VALUES
(101, 'John Doe', 'johndoe@example.com'),
(102, 'Jane Doe', 'janedoe@example.com');

--1
BEGIN;

INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
VALUES (1, 1, 101, CURRENT_DATE, 2);

UPDATE Books
SET quantity = quantity - 2
WHERE book_id = 1;

COMMIT;
--2
DO $$
BEGIN
    INSERT INTO orders (order_id, book_id, customer_id, order_date, quantity)
    VALUES (2, 3, 102, CURRENT_DATE, 10);

    IF (SELECT quantity FROM books WHERE book_id = 3) <= 10 THEN
        ROLLBACK;
        RETURN;
    END IF;

    UPDATE books
    SET quantity = quantity - 10
    WHERE book_id = 3;

    COMMIT;
END;
$$ LANGUAGE plpgsql;
--3
-- sus 1
BEGIN;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

UPDATE Books
SET price = 55.00
WHERE book_id = 3;

--sus 2
BEGIN;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT price FROM Books WHERE book_id = 3;

COMMIT;
SELECT price FROM Books WHERE book_id = 3;
--4
BEGIN;

UPDATE Customers SET email = 'dsadad@gmail.com' WHERE customer_id = 101;

COMMIT;

SELECT customer_id, email FROM Customers WHERE customer_id = 101;