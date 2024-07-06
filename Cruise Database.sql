create database CruiseSystem;
use CruiseSystem;


CREATE TABLE PORTS(
PORT_ID VARCHAR(10),
PORT_NAME VARCHAR(100) NOT NULL,
PORT_SIZE VARCHAR(50) NOT NULL,
ZIP INT NOT NULL,
COUNTRY VARCHAR(50) NOT NULL,
CITY VARCHAR(50) NOT NULL,
P_STATE VARCHAR(50) NOT NULL,
PRIMARY KEY (PORT_ID)
);


CREATE TABLE CRUISE_COMPANY(
COMPANY_ID VARCHAR(50) ,
COMPANY_NAME VARCHAR(100) NOT NULL,
PRIMARY KEY (COMPANY_ID)
);  


CREATE TABLE CRUISE(
CRUISE_NO VARCHAR(25) ,
CAPACITY INT NOT NULL,
CRUISE_NAME VARCHAR(100) NOT NULL,
COMPANY VARCHAR(50) NOT NULL,
PRIMARY KEY (CRUISE_NO),
FOREIGN KEY (COMPANY) REFERENCES CRUISE_COMPANY(COMPANY_ID)
);


CREATE TABLE CRUISE_PORT_ACCESS(
PORTS VARCHAR(25) NOT NULL,
CRUISE_SHIP VARCHAR(25) NOT NULL,
PRIMARY KEY (PORTS,CRUISE_SHIP),
FOREIGN KEY (PORTS) REFERENCES PORTS(PORT_ID) ON DELETE CASCADE,
FOREIGN KEY (CRUISE_SHIP) REFERENCES CRUISE(CRUISE_NO) ON DELETE CASCADE
);


CREATE TABLE STATEROOM(
CRUISE_SHIP VARCHAR(25) NOT NULL,
ROOM_NO VARCHAR(5) NOT NULL,
AVAILABILITY VARCHAR(15) DEFAULT 'AVAILABLE',
ROOM_TYPE VARCHAR(50) NOT NULL,
DECK VARCHAR(25) NOT NULL,
PRIMARY KEY (CRUISE_SHIP,ROOM_NO),
FOREIGN KEY (CRUISE_SHIP) REFERENCES CRUISE(CRUISE_NO) ON DELETE CASCADE
);


CREATE TABLE END_USER (
EMAIL VARCHAR(50) NOT NULL,
FNAME VARCHAR(25) NOT NULL,
LNAME VARCHAR(25) NOT NULL,
PHONE varchar(10) ,
TYPE_OF_USER VARCHAR(25) NOT NULL,
PRIMARY KEY (EMAIL)
);


CREATE TABLE CRUISE_TRIP(
CRUISE_TRIP_ID VARCHAR(15) ,
NO_OF_GUESTS INT NOT NULL,
ARRIVAL_PORT VARCHAR(25) NOT NULL,
ARRIVAL_DATE DATE NOT NULL,
DEPART_PORT VARCHAR(25) NOT NULL,
DEPART_DATE DATE NOT NULL,
PRIMARY KEY (CRUISE_TRIP_ID)
);

CREATE TABLE BOOKS
(
EMAIL VARCHAR(50) NOT NULL,
CRUISE_TRIP_ID VARCHAR(15),
PRIMARY KEY(EMAIL, CRUISE_TRIP_ID),
FOREIGN KEY (EMAIL) REFERENCES END_USER(EMAIL) ON DELETE CASCADE,
FOREIGN KEY (CRUISE_TRIP_ID) REFERENCES CRUISE_TRIP(CRUISE_TRIP_ID) ON DELETE CASCADE
);


CREATE TABLE FARE(
CRUISE_TRIP_ID VARCHAR(15),
TOTAL DECIMAL(9,2) NOT NULL,
PRICE_PER_PERSON DECIMAL(9,2) NOT NULL,
CURRENCY VARCHAR(5) NOT NULL,
DISCOUNT DECIMAL(4,2) NOT NULL,
TAX DECIMAL(5,2) NOT NULL,
PRIMARY KEY (CRUISE_TRIP_ID, TOTAL),
FOREIGN KEY (CRUISE_TRIP_ID) REFERENCES CRUISE_TRIP(CRUISE_TRIP_ID)ON DELETE CASCADE
);

CREATE TABLE TRAVELLER(
ID INT AUTO_INCREMENT,
CRUISE_SHIP VARCHAR(25) NOT NULL,
ROOM_NO VARCHAR(5) NOT NULL,
CRUISE_TRIP_ID VARCHAR(15),
PHONE VARCHAR(10),
FNAME VARCHAR(25) NOT NULL,
LNAME VARCHAR(25) NOT NULL,
COUNTRY VARCHAR(25) NOT NULL,
PRIMARY KEY(ID, CRUISE_TRIP_ID),
FOREIGN KEY (CRUISE_TRIP_ID) REFERENCES CRUISE_TRIP(CRUISE_TRIP_ID) ON DELETE CASCADE,
FOREIGN KEY (CRUISE_SHIP, ROOM_NO) REFERENCES STATEROOM(CRUISE_SHIP, ROOM_NO) ON DELETE CASCADE
);


-- Insert values into PORTS table
INSERT INTO PORTS (PORT_ID, PORT_NAME, PORT_SIZE, ZIP, COUNTRY, CITY, P_STATE) VALUES
('P001', 'Port of Miami', 'Large', 33132, 'USA', 'Miami', 'FL'),
('P002', 'Port of Los Angeles', 'Large', 90731, 'USA', 'Los Angeles', 'CA'),
('P003', 'Port of Barcelona', 'Medium', 8039, 'Spain', 'Barcelona', 'Catalonia'),
('P004', 'Port of Nassau', 'Medium', 11111, 'Bahamas', 'Nassau', 'New Providence'),
('P005', 'Port of Singapore', 'Large', 22222, 'Singapore', 'Singapore', 'Singapore'),
('P006', 'Port of Sydney', 'Large', 2000, 'Australia', 'Sydney', 'NSW'),
('P007', 'Port of Hamburg', 'Medium', 20457, 'Germany', 'Hamburg', 'Hamburg'),
('P008', 'Port of Tokyo', 'Large', 1350064, 'Japan', 'Tokyo', 'Tokyo'),
('P009', 'Port of Vancouver', 'Large', 60001, 'Canada', 'Vancouver', 'BC'),
('P010', 'Port of Dubai', 'Large', 33333, 'UAE', 'Dubai', 'Dubai');


-- Insert values into CRUISE_COMPANY table
INSERT INTO CRUISE_COMPANY (COMPANY_ID, COMPANY_NAME) VALUES
('C001', 'Carnival Corporation'),
('C002', 'Royal Caribbean International'),
('C003', 'Norwegian Cruise Line'),
('C004', 'MSC Cruises'),
('C005', 'Disney Cruise Line'),
('C006', 'Holland America Line'),
('C007', 'Celebrity Cruises'),
('C008', 'Princess Cruises'),
('C009', 'Costa Cruises'),
('C010', 'Azamara');

-- Insert values into CRUISE table
INSERT INTO CRUISE (CRUISE_NO, CAPACITY, CRUISE_NAME, COMPANY) VALUES
('CR001', 3000, 'Carnival Breeze', 'C001'),
('CR002', 3500, 'Harmony of the Seas', 'C002'),
('CR003', 2500, 'Norwegian Epic', 'C003'),
('CR004', 4000, 'MSC Meraviglia', 'C004'),
('CR005', 2700, 'Disney Dream', 'C005'),
('CR006', 2000, 'Nieuw Amsterdam', 'C006'),
('CR007', 3200, 'Celebrity Edge', 'C007'),
('CR008', 2800, 'Regal Princess', 'C008'),
('CR009', 2400, 'Costa Smeralda', 'C009'),
('CR010', 800, 'Azamara Journey', 'C010');

-- Insert values into CRUISE_PORT_ACCESS table
INSERT INTO CRUISE_PORT_ACCESS (PORTS, CRUISE_SHIP) VALUES
('P001', 'CR001'),
('P002', 'CR002'),
('P003', 'CR003'),
('P004', 'CR004'),
('P005', 'CR005'),
('P006', 'CR006'),
('P007', 'CR007'),
('P008', 'CR008'),
('P009', 'CR009'),
('P010', 'CR010');

-- Insert values into STATEROOM table
INSERT INTO STATEROOM (CRUISE_SHIP, ROOM_NO, AVAILABILITY, ROOM_TYPE, DECK) VALUES
('CR001', '101', 'AVAILABLE', 'Suite', 'Deck 1'),
('CR002', '102', 'AVAILABLE', 'Balcony', 'Deck 2'),
('CR003', '103', 'AVAILABLE', 'Inside', 'Deck 3'),
('CR004', '104', 'AVAILABLE', 'Oceanview', 'Deck 4'),
('CR005', '105', 'AVAILABLE', 'Suite', 'Deck 5'),
('CR006', '106', 'AVAILABLE', 'Balcony', 'Deck 6'),
('CR007', '107', 'AVAILABLE', 'Inside', 'Deck 7'),
('CR008', '108', 'AVAILABLE', 'Oceanview', 'Deck 8'),
('CR009', '109', 'AVAILABLE', 'Suite', 'Deck 9'),
('CR010', '110', 'AVAILABLE', 'Balcony', 'Deck 10');

-- Insert values into END_USER table
INSERT INTO END_USER (EMAIL, FNAME, LNAME, PHONE, TYPE_OF_USER) VALUES
('user1@example.com', 'John', 'Doe', '1234567890', 'Guest'),
('user2@example.com', 'Jane', 'Smith', '0987654321', 'Guest'),
('user3@example.com', 'Bob', 'Johnson', '1112223333', 'Guest'),
('user4@example.com', 'Alice', 'Williams', '2223334444', 'Guest'),
('user5@example.com', 'Charlie', 'Brown', '3334445555', 'Guest'),
('user6@example.com', 'Dave', 'Davis', '4445556666', 'Guest'),
('user7@example.com', 'Eve', 'Miller', '5556667777', 'Guest'),
('user8@example.com', 'Frank', 'Wilson', '6667778888', 'Guest'),
('user9@example.com', 'Grace', 'Moore', '7778889999', 'Guest'),
('user10@example.com', 'Hank', 'Taylor', '8889990000', 'Guest');

-- Insert values into CRUISE_TRIP table
INSERT INTO CRUISE_TRIP (CRUISE_TRIP_ID, NO_OF_GUESTS, ARRIVAL_PORT, ARRIVAL_DATE, DEPART_PORT, DEPART_DATE) VALUES
('T001', 2000, 'P001', '2024-08-01', 'P002', '2024-08-15'),
('T002', 2500, 'P003', '2024-09-01', 'P004', '2024-09-15'),
('T003', 1500, 'P005', '2024-10-01', 'P006', '2024-10-15'),
('T004', 3000, 'P007', '2024-11-01', 'P008', '2024-11-15'),
('T005', 1800, 'P009', '2024-12-01', 'P010', '2024-12-15'),
('T006', 2200, 'P001', '2024-01-01', 'P002', '2024-01-15'),
('T007', 2700, 'P003', '2024-02-01', 'P004', '2024-02-15'),
('T008', 1900, 'P005', '2024-03-01', 'P006', '2024-03-15'),
('T009', 2600, 'P007', '2024-04-01', 'P008', '2024-04-15'),
('T010', 2300, 'P009', '2024-05-01', 'P010', '2024-05-15');

-- Insert values into BOOKS table
INSERT INTO BOOKS (EMAIL, CRUISE_TRIP_ID) VALUES
('user1@example.com', 'T001'),
('user2@example.com', 'T002'),
('user3@example.com', 'T003'),
('user4@example.com', 'T004'),
('user5@example.com', 'T005'),
('user6@example.com', 'T006'),
('user7@example.com', 'T007'),
('user8@example.com', 'T008'),
('user9@example.com', 'T009'),
('user10@example.com', 'T010');

-- Insert values into FARE table
INSERT INTO FARE (CRUISE_TRIP_ID, TOTAL, PRICE_PER_PERSON, CURRENCY, DISCOUNT, TAX) VALUES
('T001', 500000.00, 250.00, 'USD', 10.00, 50.00),
('T002', 625000.00, 250.00, 'USD', 15.00, 55.00),
('T003', 375000.00, 250.00, 'USD', 5.00, 45.00),
('T004', 750000.00, 250.00, 'USD', 20.00, 60.00),
('T005', 450000.00, 250.00, 'USD', 12.00, 52.00),
('T006', 550000.00, 250.00, 'USD', 18.00, 57.00),
('T007', 675000.00, 250.00, 'USD', 25.00, 65.00),
('T008', 475000.00, 250.00, 'USD', 8.00, 48.00),
('T009', 650000.00, 250.00, 'USD', 22.00, 62.00),
('T010', 575000.00, 250.00, 'USD', 17.00, 56.00);

-- Insert values into TRAVELLER table
INSERT INTO TRAVELLER (CRUISE_SHIP, ROOM_NO, CRUISE_TRIP_ID, PHONE, FNAME, LNAME, COUNTRY) VALUES
('CR001', '101', 'T001', '1234567890', 'John', 'Doe', 'USA'),
('CR002', '102', 'T002', '0987654321', 'Jane', 'Smith', 'USA'),
('CR003', '103', 'T003', '1112223333', 'Bob', 'Johnson', 'USA'),
('CR004', '104', 'T004', '2223334444', 'Alice', 'Williams', 'USA'),
('CR005', '105', 'T005', '3334445555', 'Charlie', 'Brown', 'USA'),
('CR006', '106', 'T006', '4445556666', 'Dave', 'Davis', 'USA'),
('CR007', '107', 'T007', '5556667777', 'Eve', 'Miller', 'USA'),
('CR008', '108', 'T008', '6667778888', 'Frank', 'Wilson', 'USA'),
('CR009', '109', 'T009', '7778889999', 'Grace', 'Moore', 'USA'),
('CR010', '110', 'T010', '8889990000', 'Hank', 'Taylor', 'USA');


-- creating 

-- Create a new port
INSERT INTO PORTS (PORT_ID, PORT_NAME, PORT_SIZE, ZIP, COUNTRY, CITY, P_STATE) VALUES 
('P011', 'Port of Antwerp', 'Medium', 2000, 'Belgium', 'Antwerp', 'Antwerp');

-- Create a new cruise company
INSERT INTO CRUISE_COMPANY (COMPANY_ID, COMPANY_NAME) VALUES 
('C011', 'P&O Cruises');

-- Create a new cruise
INSERT INTO CRUISE (CRUISE_NO, CAPACITY, CRUISE_NAME, COMPANY) VALUES 
('CR011', 1500, 'Arcadia', 'C011');

-- Create a new cruise trip
INSERT INTO CRUISE_TRIP (CRUISE_TRIP_ID, NO_OF_GUESTS, ARRIVAL_PORT, ARRIVAL_DATE, DEPART_PORT, DEPART_DATE) VALUES 
('T011', 1200, 'P011', '2024-06-01', 'P001', '2024-06-15');



-- viewing 
-- View all ports
SELECT * FROM PORTS;

-- View all cruises
SELECT * FROM CRUISE;

-- View all cruise trips
SELECT * FROM CRUISE_TRIP;




-- update
-- Update the name of a port
UPDATE PORTS SET PORT_NAME = 'Port of Rotterdam' WHERE PORT_ID = 'P011';

-- Update the capacity of a cruise
UPDATE CRUISE SET CAPACITY = 1600 WHERE CRUISE_NO = 'CR011';

-- Update the number of guests on a cruise trip
UPDATE CRUISE_TRIP SET NO_OF_GUESTS = 1300 WHERE CRUISE_TRIP_ID = 'T011';



-- delete
-- Delete a port
DELETE FROM PORTS WHERE PORT_ID = 'P011';

-- Delete a cruise
DELETE FROM CRUISE WHERE CRUISE_NO = 'CR011';

-- Delete a cruise trip
DELETE FROM CRUISE_TRIP WHERE CRUISE_TRIP_ID = 'T011';



-- use of join
-- Join to view cruise names along with the company names
SELECT CRUISE.CRUISE_NAME, CRUISE_COMPANY.COMPANY_NAME
FROM CRUISE
JOIN CRUISE_COMPANY ON CRUISE.COMPANY = CRUISE_COMPANY.COMPANY_ID;

-- Join to view bookings along with user details
SELECT BOOKS.CRUISE_TRIP_ID, END_USER.EMAIL, END_USER.FNAME, END_USER.LNAME
FROM BOOKS
JOIN END_USER ON BOOKS.EMAIL = END_USER.EMAIL;


-- use of aggrigate function
-- finding the total cruise of each company
SELECT COMPANY, COUNT(*) AS NumberOfCruises
FROM CRUISE
GROUP BY COMPANY;

-- finding out the fare of each trip
SELECT CRUISE_TRIP_ID, SUM(TOTAL) AS TotalFare
FROM FARE
GROUP BY CRUISE_TRIP_ID;



-- use of co-related subqueries
-- Find the cruises with more capacity than the average capacity of all cruises
SELECT CRUISE_NAME, CAPACITY
FROM CRUISE AS C
WHERE CAPACITY > (SELECT AVG(CAPACITY) FROM CRUISE);

-- Find users who have booked more than one cruise trip
SELECT EMAIL, COUNT(CRUISE_TRIP_ID) AS NumberOfBookings
FROM BOOKS
GROUP BY EMAIL
HAVING COUNT(CRUISE_TRIP_ID) > 1;

