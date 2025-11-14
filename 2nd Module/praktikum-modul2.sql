CREATE DATABASE praktikum3DB;
USE praktikum3DB;

# no1
CREATE TABLE game(
	G_id CHAR(5) PRIMARY KEY,
    G_title VARCHAR(100) NOT NULL,
    G_release_date DATE NOT NULL,
    G_rating VARCHAR(10) NOT NULL,
    G_price INT NOT NULL,
    G_stock INT NOT NULL
);

CREATE TABLE tags(
	tag_id CHAR(5) PRIMARY KEY,
    tag_name VARCHAR(50) NOT NULL,
    tag_description VARCHAR(250) NOT NULL
);

CREATE TABLE staff(
	S_id CHAR(5) PRIMARY KEY,
    S_name VARCHAR(100) NOT NULL,
    S_email VARCHAR(100) NOT NULL,
    S_gender CHAR(1) NOT NULL,
    S_position VARCHAR(50) NOT NULL,
    S_adress VARCHAR(100) NOT NULL
);

CREATE TABLE customer (
	C_id CHAR(5) PRIMARY KEY,
    C_name VARCHAR(100) NOT NULL,
    C_email VARCHAR(100) NOT NULL,
    C_gender CHAR (1) NOT NULL,
    C_pnumber VARCHAR(15) NOT NULL,
    C_adress VARCHAR (100) NOT NULL
);

CREATE TABLE transaction (
	T_id CHAR (5) PRIMARY KEY,
    T_date DATE NOT NULL,
    T_method VARCHAR(20) NOT NULL,
    customer_id CHAR (5),
    staff_id CHAR(5),
    CONSTRAINT pk_customer_id_transaction FOREIGN KEY (customer_id) REFERENCES customer(C_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT pk_staff_id_transaction FOREIGN KEY (staff_id) REFERENCES staff(S_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE game_tags( # perhatikan foreign key
	tags_id CHAR(5),
    game_id CHAR(5),
    PRIMARY KEY(tags_id, game_id),
    CONSTRAINT fk_tags_id FOREIGN KEY (tags_id) REFERENCES tags(tag_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_game_id FOREIGN KEY (game_id) REFERENCES game(G_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE transaction_detail ( # perhatikan foreign key
	transaction_id VARCHAR(15) PRIMARY KEY,
    quantity INT NOT NULL,
    total_price INT NOT NULL,
    game_id CHAR (5),
    CONSTRAINT fk_game_id_transdetail FOREIGN KEY (game_id) REFERENCES game(G_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE phone_number (
	S_pnumber VARCHAR(15) PRIMARY KEY,
    staff_id CHAR(5),
    CONSTRAINT fk_staff_id_phonenumber FOREIGN KEY (staff_id) REFERENCES staff(S_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- SELECT * FROM customer;
SELECT * FROM game;
-- SELECT * FROM game_tags;
SELECT * FROM staff;
-- SELECT * FROM tags;
-- SELECT * FROM transaction;
-- SELECT * FROM transaction_detail;
-- SELECT * FROM phone_number;

# no2

CREATE TABLE developer (
	D_id CHAR (5) PRIMARY KEY,
    D_name VARCHAR (100) NOT NULL,
    D_country VARCHAR(50) NOT NULL
);

ALTER TABLE game
ADD COLUMN D_id CHAR(5);

ALTER TABLE game
ADD FOREIGN KEY (D_id) REFERENCES developer(D_id) ON UPDATE CASCADE ON DELETE CASCADE;

-- SELECT * FROM developer;

# NO3

DROP TABLE phone_number;

ALTER TABLE staff
ADD COLUMN S_pnumber VARCHAR(15) NOT NULL;

# no 4

ALTER TABLE customer
ADD COLUMN C_joindate DATE NOT NULL;

# NO 5

INSERT INTO customer (C_id, C_name, C_email, C_gender, C_pnumber, C_adress, C_joindate) VALUES
('C0001', 'Alice', 'alice@example.com', 'F', '(555)010-1234', '123 Maple St, IL', '2023-12-01'),
('C0002', 'Ben', 'ben@example.com', 'M', '(555)011-6789', '321 Birch Blvd, WI', '2023-12-02'),
('C0003', 'Chloe', 'chloe@example.com', 'F', '(555)012-3456', '654 Cedar Ct, TX', '2023-12-03'),
('C0004', 'Daniel', 'daniel@example.com', 'M', '(555)013-8901', '246 Willow Way, OR', '2023-12-04'),
('C0005', 'Ethan', 'ethan@example.com', 'M', '(555)014-9012', '147 Maplewood Ln, GA', '2023-12-05');

INSERT INTO staff (S_id, S_name, S_email, S_gender, S_position, S_pnumber, S_adress) VALUES
('S0001', 'Adam', 'adam@example.com', 'M', 'Cashier', '(555)010-5678', '456 Oak Ave, NE'),
('S0002', 'Bella', 'Bella@example.com', 'F', 'Cashier', '(555)011-2345', '789 Pine Rd, OH'),
('S0003', 'Charlie', 'charlie@example.com', 'M', 'Database Engineer', '(555)012-7890', '987 Elm St, CO'),
('S0004', 'Daisy', 'daisy@example.com', 'F', 'Customer Service Rep', '(555)013-4567', '135 Spruce Pl, WA'),
('S0005', 'Emma', 'emma@example.com', 'F', 'Content Writer', '(555)014-5678', '369 Ash Dr, TN');

INSERT INTO transaction (T_id, T_date, T_method, customer_id, staff_id) VALUES
('T0001', '2024-01-01', 'Cash', 'C0001', 'S0001'),
('T0002', '2024-01-02', 'Cash', 'C0002', 'S0002'),
('T0003', '2024-01-02', 'QRIS', 'C0003', 'S0003'),
('T0004', '2024-01-09', 'Debit', 'C0004', 'S0004'),
('T0005', '2024-01-13', 'Credit', 'C0005', 'S0005');

INSERT INTO tags (tag_id, tag_name, tag_description) VALUES
('TG001', 'Action', 'Fast-paced gameplay requiring quick reflexes and combat skills.'),
('TG002', 'Horror', 'Focuses on creating fear and tension through unsettling atmospheres and scares.'),
('TG003', 'Puzzle', 'Challenges players to solve problems and riddles using logic and critical thinking.'),
('TG004', 'RPG', 'Players assume character roles, developing skills and engaging in storytelling.'),
('TG005', 'Sports', 'Involves competitive gameplay based on real or fictional sports, emphasizing skill, strategy, and teamwork.');

INSERT INTO game (G_id, G_title, G_release_date, G_rating, G_price, G_stock, D_id) VALUES
('G0001', 'Call of Duty: Black Ops 6', '2024-10-25', '18+', 1040000, 2, 'D0001'), 
('G0002', 'F1 24', '2024-05-31', '3+', 759000, 11, 'D0002'),
('G0003', 'Hogwarts Legacy', '2023-02-11', '13+', 799000, 9, 'D0003'),
('G0004', 'FC 25', '2024-09-27', '3+', 799000, 32, 'D0002'),
('G0005', 'HELLDIVERS II', '2024-02-08', '18+', 579000, 20, 'D0004'),
('G0006', 'Concord', '2024-08-23', '13+', 579000, 10, 'D0005');

INSERT INTO developer (D_id, D_name, D_country) VALUES
('D0001', 'Activision', 'USA'), 
('D0002', 'EA Sports', 'Canada'), 
('D0003', 'Avalanche', 'UK'), 
('D0004', 'Arrowhead', 'Sweden'),
('D0005', 'Firewalk Studio', 'USA');

INSERT INTO game_tags (tags_id, game_id) VALUES
('TG001', 'G0001'),
('TG001', 'G0005'),
('TG001', 'G0006'),
('TG001', 'G0003'),
('TG004', 'G0003'),
('TG005', 'G0002'),
('TG005', 'G0004');

INSERT INTO transaction_detail (transaction_id, game_id, quantity, total_price) VALUES
('T0001', 'G0001', 1, 1040000),
('T0002', 'G0002', 1, 759000),
('T0003', 'G0003', 1, 799000),
('T0004', 'G0004', 2, 1598000),
('T0005', 'G0005', 2, 1158000);

# no6

ALTER TABLE game
ADD COLUMN D_id CHAR(5);

ALTER TABLE game
ADD FOREIGN KEY (D_id) REFERENCES developer(D_id) ON UPDATE CASCADE ON DELETE CASCADE;

# no7

INSERT INTO staff (S_id, S_name, S_email, S_gender, S_position, S_pnumber, S_adress) VALUES
('S0006', 'Fiona', 'fiona@example.com', 'F', 'Cashier', '(555) 016-3456', '420 Thick Fein, LS');

# no8
SET SQL_safe_updates = 0;
UPDATE game
SET G_price = 0.7 * G_price
WHERE G_rating = '3+';

SELECT * FROM game;

# no9

INSERT INTO transaction (T_id, T_date, T_method, customer_id, staff_id) VALUES
('T0006', '2024-11-01', 'Credit', 'C0005', 'S0005');

UPDATE game
SET G_stock = 0
WHERE G_title = 'Hogwarts Legacy';

# np 10

UPDATE staff
SET S_position = 'Database Engineer'
WHERE S_id = 'S0006';

SELECT * FROM staff;

# no 11

DELETE FROM game
WHERE G_title = 'Concord';

SELECT * FROM game;

# no12

DROP DATABASE praktikum3DB;