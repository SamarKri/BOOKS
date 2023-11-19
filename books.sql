CREATE DATABASE IF NOT EXISTS books;
USE books;

CREATE TABLE IF NOT EXISTS users
(user_id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(45)  NOT NULL,
last_name  VARCHAR(45)  NOT NULL,
email 	   VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS authors
(author_id INT PRIMARY KEY AUTO_INCREMENT,
author_name VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS books
(book_id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(45) NOT NULL,
author_id INT NOT NULL,
FOREIGN KEY fk_books_authors (author_id)
	REFERENCES authors (author_id)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS favorites
(user_id INT NOT NULL,
book_id  INT NOT NULL,
FOREIGN KEY fk_favorites_users (user_id)
	REFERENCES users (user_id)
    ON UPDATE CASCADE
    ON DELETE NO ACTION,
FOREIGN KEY fk_favorites_books (book_id)
	REFERENCES books (book_id)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);

INSERT INTO users (first_name, last_name, email)
VALUES ('John', 'Doe','JD@books.com'),
	('Robin', 'Smith', 'Robin@books.com'),
	('Gloria', 'Rodriguez', 'grodriquez@books.com');

INSERT INTO authors (author_name)
VALUES ('Stephen King'),
	   ('F.Scott Fitgerald'),
       ('Jack London'),
       ('Jane Austen'),
       ('Mary Shelley');

INSERT INTO books (title, author_id)
VALUES ('The Shining', 1),
	   ('It', 1),
       ('The Great Gatsby', 2),
       ('The Call of the Wild', 3),
       ('Pride and Prejudice', 4),
       ('Frankenstein', 5);

INSERT INTO favorites (user_id, book_id)
VALUES (1, 1),
	   (1, 2),
       (1, 3),
       (2, 4),
       (2, 5),
       (3, 5),
       (3, 6);

SHOW TABLES FROM books;        

SELECT books.title, favorites.user_id
FROM books
JOIN favorites ON books.book_id = favorites.book_id
WHERE favorites.user_id = 
    (SELECT users.user_id FROM users WHERE (users.last_name = "Doe" AND users.first_name = "John"));
