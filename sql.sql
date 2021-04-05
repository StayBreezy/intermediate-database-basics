
SELECT *
FROM invoice i
JOIN invoice_line il
ON il.invoice_id = i.invoice_id
WHERE unit_price > .99


SELECT c.first_name, c.last_name, i.invoice_date, i.total
FROM invoice i
JOIN customer c
ON i.customer_id = c.customer_id



SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e
ON c.support_rep_id = e.employee_id


SELECT al.title, ar.name
FROM album al
JOIN artist ar
ON ar.artist_id = al.artist_id


SELECT pt.track_id
FROM playlist_track pt
JOIN playlist pl
ON pl.playlist_id = pt.playlist_id
WHERE pl.name = 'Music'



SELECT t.name
FROM track t
JOIN playlist_track pt
ON pt.track_id = t.track_id
WHERE pt.playlist_id = 5


SELECT t.name, pl.name
FROM track t
JOIN playlist_track pt
ON t.track_id = pt.track_id
JOIN playlist pl
ON pl.playlist_id = pt.playlist_id


SELECT t.name, al.title
FROM track t
JOIN album al
ON t.album_id = al.album_id
WHERE g.name = 'Alternative & Punk'




SELECT *
FROM invoice
WHERE invoice_id
IN(
  SELECT invoice_id
  FROM invoice_line
  WHERE unit_price > .99)


SELECT *
FROM playlist_track
WHERE playlist_id
IN(
  SELECT playlist_id
  FROM playlist
  WHERE name = 'Music')


SELECT *
FROM track
WHERE track_id
IN(
  SELECT track_id
  FROM playlist_track
  WHERE playlist_id = 5
  )


SELECT *
FROM track
WHERE genre_id
IN(
  SELECT genre_id
  FROM genre
  WHERE name = 'Comedy'
)


SELECT *
FROM track
WHERE album_id
IN(
  SELECT album_id
 	FROM album
  WHERE name = 'Fireball')


SELECT *
FROM track
WHERE album_id
IN(
  SELECT album_id
  FROM album
  WHERE artist_id
 	IN(
   	SELECT artist_id
   	FROM artist
   	WHERE name = 'Queen'
  	)
 )




UPDATE customer
SET fax = null
WHERE fax IS NOT null


UPDATE customer
SET company = 'Self'
WHERE company IS null


UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett'


UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl'


UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = (SELECT genre_id
                  FROM genre
                  WHERE name ='Metal')
                  AND composer IS null







SELECT COUNT(*), g.name
FROM track t
JOIN genre g
ON t.genre_id = g.genre_id
GROUP BY g.name

SELECT COUNT(*), g.name
FROM track t
JOIN genre g
ON  t.genre_id = g.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name

SELECT ar.name, COUNT(*)
FROM album al
JOIN artist ar
ON ar.artist_id = al.artist_id
GROUP BY ar.name




SELECT DISTINCT composer
FROM track

SELECT DISTINCT billing_postal_code
FROM invoice

SELECT DISTINCT company
FROM customer




DELETE FROM practice_delete
WHERE type = 'bronze'

DELETE FROM practice_delete
WHERE type = 'silver'

DELETE FROM practice_delete
WHERE value = 150




CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
  	person_id INTEGER,
    person_name VARCHAR(200),
    email VARCHAR(200)
);
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    item_id INTEGER,
    product_name VARCHAR(200),
    product_price NUMERIC
);
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    product_name VARCHAR(200),
    customer_name VARCHAR(200),
    product_price NUMERIC,
    order_date TIMESTAMP,
    quantity INTEGER,
    total NUMERIC,
    product_id INT REFERENCES products(product_id)
);



INSERT INTO users
(name, email)
VALUES ('Jake Hirsch', 'jake@jake.com');
INSERT INTO users
(name, email)
VALUES ('Skye Wilks', 'skyewilks@wilks.com');
INSERT INTO users
(name, email)
VALUES ('Ocean Beau', 'obeau@blvd.com');

INSERT INTO products
(product_name, product_price)
VALUES ('stacked ring set', 1399.99);
INSERT INTO products
(product_name, product_price)
VALUES ('jasmine sapphire ring', 1475.00);
INSERT INTO products
(product_name, product_price)
VALUES ('asher cut diamond ring', 12599.00);

INSERT INTO orders
(customer_name, quantity)
VALUES ('Sally Olsen', 1);
INSERT INTO orders
(customer_name, quantity)
VALUES ('Jake Hirsch', 2);
INSERT INTO orders
(customer_name, quantity)
VALUES ('Bisou Blankeship', 3);

 SELECT *
FROM products
WHERE product_id
IN(
  SELECT product_id
  FROM orders
  WHERE order_id = 1
  )


SELECT *
FROM orders

SELECT sum(total)
FROM orders
WHERE order_id = 2


ALTER TABLE users
ADD COLUMN order_id INT REFERENCES orders(order_id)


ALTER TABLE orders
ADD COLUMN user_id INT REFERENCES users(user_id)
