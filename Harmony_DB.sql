-- SQL Data-Analyst Project


-- Harmony_DB --
/* A comprehensive music database that tracks information about:

Bands,
Albums,
Guitarists,
Concerts,
Guitar manufacturers,
Social media presence

9 Tables
12 Views

It includes details about band names, founding dates, album releases and sales, concert dates, locations, attendance, revenue, and guitar specifications.
The database also integrates social media statistics for bands, providing a holistic view of their popularity and reach.
This database is designed to facilitate various analyses and visualizations, such as tracking concert attendance, album sales, and band revenue.
*/


USE master;
GO

CREATE DATABASE Harmony_DB;
GO

USE Harmony_DB;
GO


-- --DELETE DB
--USE [master];
--GO
--SELECT * FROM sys.dm_exec_sessions WHERE database_id = DB_ID ('Harmony_DB');

---- Session ID
--KILL 79;

--DROP DATABASE  Harmony_DB;
--GO



--------------CREATE TABLES----------------
-------------------------------------------
------------------TABLE 1------------------

CREATE TABLE Countries
				(id INT IDENTITY,
				 Name VARCHAR(50) NOT NULL
-- CONSTRAINTS
CONSTRAINT country_id_PK PRIMARY KEY(id)
);
GO
-------------------------------------------
-------------------------------------------



-------------------------------------------
------------------TABLE 2------------------

CREATE TABLE Locations (
    Location_id INT IDENTITY PRIMARY KEY,
    Location_Name VARCHAR(100) UNIQUE NOT NULL,
    City VARCHAR(50) NOT NULL,
    Country_id INT NOT NULL, -- FK
    Capacity INT NOT NULL,
	CONSTRAINT country_FK FOREIGN KEY(Country_id) REFERENCES Countries(id)
);
GO
-------------------------------------------
-------------------------------------------



-------------------------------------------
------------------TABLE 3------------------

CREATE TABLE Manufacturer
				(Manufacturer_id INT IDENTITY,
				 Manufacturer_Name VARCHAR(100) UNIQUE NOT NULL,
				 Country_id INT -- FK
-- CONSTRAINTS
CONSTRAINT Manufacturer_id_PK PRIMARY KEY(Manufacturer_id),
CONSTRAINT country_id_FK FOREIGN KEY(Country_id) REFERENCES Countries(id)
);
GO
-------------------------------------------
-------------------------------------------



-------------------------------------------
------------------TABLE 4------------------

CREATE TABLE Guitars
				(Guitar_id INT IDENTITY, 
				 Guitar_Model VARCHAR(100) NOT NULL,
				 Price MONEY NOT NULL,
				 Frets INT NOT NULL, -- ALL guitars have between 20 and 24 Frets depending on the guitar kind
				 Strings INT NOT NULL, -- ALL guitars have 6 OR 8 OR 12 Strings
				 Manufacturer_id INT -- FK
-- CONSTRAINTS
CONSTRAINT guitar_id_PK PRIMARY KEY(Guitar_id),
CONSTRAINT guitar_price CHECK(Price >= 0),
CONSTRAINT String_Num CHECK (Strings IN (6,8,12)),
CONSTRAINT Frets_Num CHECK (Frets BETWEEN 20 AND 24),
CONSTRAINT Manufacturer_id_FK FOREIGN KEY(Manufacturer_id) REFERENCES Manufacturer(Manufacturer_id)
);
GO
-------------------------------------------
-------------------------------------------



-------------------------------------------
------------------TABLE 5------------------

CREATE TABLE Bands
				(id INT IDENTITY,
				Band_Name VARCHAR(50) UNIQUE NOT NULL,
				Country_id INT, -- FK
				Founded_on DATE

-- CONSTRAINTS
CONSTRAINT band_id_PK PRIMARY KEY(id),
CONSTRAINT Bands_country_FK FOREIGN KEY(Country_id) REFERENCES Countries(id)
);
GO
-------------------------------------------
-------------------------------------------



-------------------------------------------
------------------TABLE 6------------------

CREATE TABLE Albums (
    Album_Id INT IDENTITY PRIMARY KEY,
    Album_Name VARCHAR(100) UNIQUE NOT NULL,
    Release_Date DATE,
    Band_id INT, -- FK
    Copies_Sold INT,
    CONSTRAINT band_album_FK FOREIGN KEY(Band_id) REFERENCES Bands(id)
);
GO
-------------------------------------------
-------------------------------------------



-------------------------------------------
------------------TABLE 7------------------

CREATE TABLE Social_Media_Statistics (
    Social_Media_Id INT PRIMARY KEY,
    Band_id INT, -- FK
    Platform VARCHAR(25),
    Followers INT,
    CONSTRAINT band_social_media_FK FOREIGN KEY(Band_id) REFERENCES Bands(id),
	CONSTRAINT platform_name CHECK (Platform IN ('Instagram', 'Facebook', 'Twitter'))
);
GO
-------------------------------------------
-------------------------------------------



-------------------------------------------
------------------TABLE 8------------------

CREATE TABLE Guitarists
				(id INT IDENTITY,
				First_Name VARCHAR(25) NOT NULL,
				Last_Name VARCHAR(50),
				Signature_Guitar INT, --FK
				Country INT, -- FK
				Band INT, -- FK
				Is_Alive VARCHAR(3) CHECK (Is_Alive IN ('YES', 'NO')),
				Net_Worth MONEY
-- CONSTRAINTS
CONSTRAINT Guitarist_id_PK PRIMARY KEY(id),
CONSTRAINT signature_guitar_FK FOREIGN KEY(Signature_Guitar) REFERENCES Guitars(Guitar_id),
CONSTRAINT country_guitarist_FK FOREIGN KEY(Country) REFERENCES Countries(id),
CONSTRAINT band_FK_new FOREIGN KEY (Band) REFERENCES Bands(id)
);
GO
-------------------------------------------
-------------------------------------------



-------------------------------------------
------------------TABLE 9------------------

CREATE TABLE Concerts (
    Concert_Id INT IDENTITY PRIMARY KEY,
    Band_id INT, -- FK
    Location_id INT, -- FK
    Date DATE,
    Attendance INT NOT NULL,
    Revenue MONEY NOT NULL,
    Tickets_Sold INT NOT NULL,
    CONSTRAINT band_concert_FK FOREIGN KEY(Band_id) REFERENCES Bands(id),
    CONSTRAINT location_concert_FK FOREIGN KEY(Location_id) REFERENCES Locations(Location_id),
	CONSTRAINT Attendance_num CHECK (Attendance >= 0),
	CONSTRAINT Revenue_num CHECK (Revenue >= 0),
	CONSTRAINT Tickets_sold_num CHECK(Tickets_Sold >= 0)
);
GO
-------------------------------------------
-------------------------------------------



-------------------------------------------
----------------INSERT VALUES--------------
-------------------------------------------

-- 10 Countries
-- Countries
INSERT INTO Countries
VALUES
	('USA'),
	('JAPAN'),
	('CANADA'),
	('UK'),
	('ISRAEL'),
	('FINLAND'),
	('GERMANY'),
	('FRANCE'),
	('ITALY'),
	('SPAIN');
GO


-- 57 Locations
-- Locations For Concerts
INSERT INTO Locations (Location_Name, City, Country_id, Capacity)
VALUES
    ('Madison Square Garden', 'New York', 1, 20000),
    ('Tokyo Dome', 'Tokyo', 2, 55000),
    ('Rogers Centre', 'Toronto', 3, 49000),
    ('Wembley Stadium', 'London', 4, 90000),
    ('Menora Mivtachim Arena', 'Tel Aviv', 5, 10000),
    ('Hartwall Arena', 'Helsinki', 6, 15000),
    ('Mercedes-Benz Arena', 'Berlin', 7, 17000),
    ('AccorHotels Arena', 'Paris', 8, 20000),
    ('Mediolanum Forum', 'Milan', 9, 12700),
    ('Palau Sant Jordi', 'Barcelona', 10, 17500),
    ('Staples Center', 'Los Angeles', 1, 21000),
    ('Saitama Super Arena', 'Saitama', 2, 37000),
    ('Scotiabank Arena', 'Toronto', 3, 19800),
    ('O2 Arena', 'London', 4, 20000),
    ('Bloomfield Stadium', 'Tel Aviv', 5, 29000),
    ('Tampere Deck Arena', 'Tampere', 6, 13500),
    ('Olympiastadion', 'Berlin', 7, 74475),
    ('Stade de France', 'Paris', 8, 81338),
    ('Unipol Arena', 'Bologna', 9, 18000),
    ('WiZink Center', 'Madrid', 10, 17500),
    ('Red Rocks Amphitheatre', 'Morrison', 1, 9525),
    ('Nippon Budokan', 'Tokyo', 2, 14000),
    ('Centre Bell', 'Montreal', 3, 21302),
    ('Manchester Arena', 'Manchester', 4, 21000),
    ('Pais Arena', 'Jerusalem', 5, 11000),
    ('Gatorade Center', 'Turku', 6, 11700),
    ('Lanxess Arena', 'Cologne', 7, 20000),
    ('Parc des Princes', 'Paris', 8, 47929),
    ('Pala Alpitour', 'Turin', 9, 15200),
    ('Bizkaia Arena', 'Bilbao', 10, 18000),
    ('United Center', 'Chicago', 1, 23500),
    ('Kyocera Dome', 'Osaka', 2, 51000),
    ('Bell MTS Place', 'Winnipeg', 3, 16145),
    ('SSE Hydro', 'Glasgow', 4, 14000),
    ('Nokia Arena', 'Tampere', 6, 15500),
    ('Veltins-Arena', 'Gelsenkirchen', 7, 62000),
    ('Orange Vélodrome', 'Marseille', 8, 67000),
    ('PalaLottomatica', 'Rome', 9, 11000),
    ('La Cartuja Stadium', 'Seville', 10, 60000),
    ('Barclays Center', 'Brooklyn', 1, 19000),
    ('Fukuoka Yahuoku! Dome', 'Fukuoka', 2, 38000),
    ('Rogers Arena', 'Vancouver', 3, 18910),
    ('SSE Arena', 'Belfast', 4, 11300),
    ('Espoo Metro Areena', 'Espoo', 6, 8300),
    ('Volksparkstadion', 'Hamburg', 7, 57000),
    ('Groupama Stadium', 'Lyon', 8, 59000),
    ('PalaTrento', 'Trento', 9, 4300),
    ('Luzhniki Stadium', 'Moscow', 10, 81000),
    ('TD Garden', 'Boston', 1, 19580),
    ('Nagoya Dome', 'Nagoya', 2, 49500),
    ('Scotiabank Saddledome', 'Calgary', 3, 19289),
    ('Utilita Arena', 'Newcastle', 4, 11200),
    ('Isku Areena', 'Lahti', 6, 7000),
    ('Olympiastadion_MU', 'Munich', 7, 69250),
    ('Matmut Atlantique', 'Bordeaux', 8, 42000),
    ('PalaPentassuglia', 'Brindisi', 9, 3500),
    ('San Mamés', 'Bilbao', 10, 53000);
GO


-- 24 Manufacturers
-- Guitar Manufacturers
INSERT INTO Manufacturer (Manufacturer_Name, Country_id)
VALUES
	('Fender', 1),
	('Gibson', 1),
	('Martin', 1),
	('Taylor', 1),
	('PRS', 1),
	('Gretsch', 1),
	('Epiphone', 1),
	('Jackson', 1),
	('Schecter', 1),
	('DAngelico', 1),
	('Music Man', 1),
	('Alvarez', 1),
	('Yamaha', 2),
	('Ibanez', 2),
	('ESP', 2),
	('Godin', 3),
	('Seagull', 3),
	('Chapman', 4),
	('Gordon Smith Guitars', 4),
	('Macmull', 5),
	('BnG', 5),
	('Ruokangas Guitars', 6),
	('Kiiras', 6),
	('Luthman', 6);
GO


-- 98 Guitars
-- Guitars
INSERT INTO Guitars (Guitar_Model, Price, Frets, Strings, Manufacturer_id)
VALUES
    ('Fender Stratocaster', 1500,22,6,1),
    ('Fender Telecaster', 1400,22,6,1),
    ('Gibson Les Paul Standard', 2500,24,6,2),
    ('Gibson SG', 1800,24,6,2),
    ('Martin D-28', 3000,21,6,3),
    ('Taylor 814ce', 3500,21,6 ,4),
    ('PRS Custom 24', 3500,21,12,6),
    ('Gretsch G5420T Electromatic', 1200,21,6, 6),
    ('Epiphone Les Paul Standard', 600,22,6, 7),
    ('Jackson Soloist', 1700,24,8, 8),
    ('Schecter Hellraiser C-1', 1000,24,8, 9),
    ('DAngelico Premier EXL-1', 900,24,6, 10),
    ('Music Man StingRay', 2200,24,6, 11),
    ('Alvarez Artist Series AD60', 500,22,6, 12),
    ('Yamaha FG830', 400,22,6, 13),
    ('Ibanez RG550', 800,24,8, 14),
    ('ESP LTD EC-1000', 1000,24,8, 15),
    ('Godin Multiac ACS-SA', 1500,22,6, 16),
    ('Seagull S6 Original', 400,22,6, 17),
    ('Chapman ML1 Pro Modern', 1200,21,6, 18),
    ('Gordon Smith GS1', 1500,22,6, 19),
    ('Macmull S-Classic', 3000,22,6, 20),
    ('BnG Little Sister', 3500,22,6, 21),
    ('Ruokangas Unicorn Classic', 4000,24,8, 22),
    ('Kiiras K2', 3800,24,8, 23),
    ('Luthman Jako', 2700,24,8, 24),
	('Fender Jazz Bass', 1300,22,6, 1),
    ('Gibson ES-335', 3500,24,6, 2),
    ('Martin OM-28', 3200,20,6, 3),
    ('Taylor 814ce-N', 3800,21,6, 4),
    ('PRS SE Custom 24', 900,24,6, 5),
    ('Gretsch G6120T Players Edition', 2500,24,6, 6),
    ('Epiphone Casino', 700,22,6, 7),
    ('Jackson Rhoads RRX24', 1500,24,12, 8),
    ('Schecter Banshee Elite-6', 1100,24,12, 9),
    ('DAngelico Excel SS', 1200,22,6, 10),
    ('Music Man Cutlass', 2000,24,12, 11),
    ('Alvarez Artist Series AJ80CE', 600,22,6, 12),
    ('Yamaha Pacifica 112V', 300,22,6, 13),
    ('Ibanez AZ2204', 1800,24,6, 14),
    ('ESP E-II Horizon FR', 2200,24,8, 15),
    ('Godin Summit Classic', 1700,22,6, 16),
    ('Seagull Coastline S12 Cedar', 700,22,6, 17),
    ('Chapman ML3 Pro Traditional', 1400,22,6, 18),
    ('Gordon Smith GS2', 1600,22,6, 19),
    ('Macmull Custom T', 3200,22,6, 20),
    ('BnG The Little Sister Crossroads', 2800,22,12, 21),
    ('Ruokangas VSOP', 4500,22,6, 22),
    ('Kiiras M1', 3500,24,12, 23),
    ('Luthman Hot Rod 59', 3000,22,12, 24),
	('Fender Precision Bass', 1100,22,6, 1),
    ('Gibson Flying V', 2200,22,6, 2),
    ('Martin D-45', 7000,21,12, 3),
    ('Taylor 814ce DLX', 4500,22,12, 4),
    ('PRS SE Custom 22', 800,24,8, 5),
    ('Gretsch G5422G Electromatic', 1400,22,8, 6),
    ('Epiphone Hummingbird', 600,22,6, 7),
    ('Jackson King V', 2000,24,12, 8),
    ('Schecter Hellraiser Hybrid C-7', 1300,22,12, 9),
    ('DAngelico Premier SS', 1000,21,12, 10),
    ('Music Man Bongo 5', 2700,24,6, 11),
    ('Alvarez Artist Series AF60', 500,22,6, 12),
    ('Yamaha APX600', 400,22,6, 13),
    ('Ibanez RG550 Genesis Collection', 1000,24,12, 14),
    ('ESP LTD M-1000', 1200,24,12, 15),
    ('Godin 5th Avenue Uptown GT', 1800,22,6, 16),
    ('Seagull Maritime SWS Mahogany', 800,22,6, 17),
    ('Chapman Ghost Fret Pro', 1600,22,6, 18),
    ('Gordon Smith GS1000', 2000,22,6, 19),
    ('Macmull T Classic Custom', 3500,24,6, 20),
    ('BnG Hybrid Sister', 3200,22,6, 21),
    ('Ruokangas Mojo Grande', 5000,22,6, 22),
    ('Kiiras K3', 4000,24,12, 23),
    ('Luthman LPJ', 2500,24,12, 24),
	('Fender Jaguar', 1800,22,6, 1),
    ('Gibson Explorer', 2600,22,6, 2),
    ('Martin HD-28', 3800,22,6, 3),
    ('Taylor 614ce', 3200,22,6, 4),
    ('PRS SE Santana', 900,24,12, 5),
    ('Gretsch G2622 Streamliner', 800,22,6, 6),
    ('Epiphone Sheraton II Pro', 700,22,6, 7),
    ('Jackson DK2M Dinky', 1200,24,12, 8),
    ('Schecter Omen Extreme-6', 600,22,6, 9),
    ('DAngelico Excel SD', 1100,22,6, 10),
    ('Music Man Majesty', 3500,24,12, 11),
    ('Alvarez Artist Series AD30', 400,22,6, 12),
    ('Yamaha Pacifica 612VII', 600,20,6, 13),
    ('Ibanez AS73 Artcore', 700,24,6, 14),
    ('ESP LTD TE-1000', 1500,22,12, 15),
    ('Godin Multiac Grand Concert SA', 2000,22,6, 16),
    ('Seagull S6 Mahogany Deluxe', 900,22,6, 17),
    ('Chapman ML2 Pro Modern', 1300,22,6, 18),
    ('Gordon Smith GS3', 1700,22,6, 19),
    ('Macmull Paloma', 4000,22,12, 20),
    ('BnG The Sister Crossroads',3000,22,8,  21),
    ('Ruokangas Duke', 4200,22,8, 22),
    ('Kiiras T1', 3600,24,12, 23),
    ('Luthman Crossover', 2800,22,6, 24);
GO


-- 50 Bands
-- Bands
INSERT INTO Bands (Band_Name, Country_id, Founded_on)
VALUES
    ('The Jimi Hendrix Experience', 1, '1966-10-06'),
    ('Guns N'' Roses', 1, '1985-03-01'),
    ('Nirvana', 1, '1987-01-01'),
    ('Red Hot Chili Peppers', 1, '1983-01-01'),
    ('Foo Fighters', 1, '1994-01-01'),
    ('Metallica', 1, '1981-10-28'),
    ('The Doors', 1, '1965-07-01'),  
    ('Pearl Jam', 1, '1990-10-22'),
    ('Van Halen', 1, '1972-01-01'),
    ('The Eagles', 1, '1971-01-01'),
    ('Rage Against the Machine', 1, '1991-01-01'),
    ('AC/DC', 1, '1973-11-01'),
    ('Baby Metal', 2, '2010-11-28'),
    ('Dragon Force', 2, '1999-01-01'),
    ('SiM', 2, '2004-03-01'),
    ('Nickelback', 3, '1995-01-01'),
    ('Rush', 3, '1968-08-18'),
    ('Simple Plan', 3, '1999-12-01'),
    ('Cream', 4, '1966-07-01'),
    ('Derek and the Dominos', 4, '1970-06-01'),
    ('Led Zeppelin', 4, '1968-10-01'),
    ('The Rolling Stones', 4, '1962-01-01'),
    ('Queen', 4, '1970-01-01'),
    ('Pink Floyd', 4, '1965-01-01'),
    ('The Who', 4, '1964-01-01'),
    ('Deep Purple', 4, '1968-01-01'),
    ('Iron Maiden', 4, '1975-01-01'),
    ('Black Sabbath', 4, '1968-11-01'),
    ('The Beatles', 4, '1960-01-01'),
    ('Hazeevot‎', 5, '1986-01-01'),
    ('Machina', 5, '1984-01-01'),
    ('Hayehudim', 5, '1989-01-01'),
    ('caveret', 5, '1973-01-01'),
    ('Mercedes Band', 5, '1976-01-01'),
    ('Sinergiya', 5, '1984-01-01'),
    ('Doctor Casper Bunny Show', 5, '1993-01-01'),
    ('Nightwish', 6, '1996-07-06'),
    ('Children Of Boddom', 6, '1993-08-04'),
	('Sonata Arctica', 6, '1995-01-01'),
    ('Apocalyptica', 6, '1993-01-01'),
    ('Rammstein', 7, '1994-01-01'),
    ('Scorpions', 7, '1965-01-01'),
    ('Tokio Hotel', 7, '2001-01-01'),
    ('Kraftwerk', 7, '1970-01-01'),
    ('Daft Punk', 8, '1993-01-01'),
    ('Gojira', 8, '1996-01-01'),
    ('Phoenix', 8, '1995-01-01'),
    ('Justice', 8, '2003-01-01'),
    ('Lacuna Coil', 9, '1994-01-01'),
    ('Maneskin', 9, '2016-01-01');
GO


-- 198 Albums
-- Albums
INSERT INTO Albums (Album_Name, Release_Date, Band_id, Copies_Sold)
VALUES
    ('Are You Experienced', '1967-05-12', 1, 5000000),
    ('Appetite for Destruction', '1987-07-21', 2, 30000000),
    ('Nevermind', '1991-09-24', 3, 30000000),
    ('Californication', '1999-06-08', 4, 15000000),
    ('The Colour and the Shape', '1997-05-20', 5, 2000000),
    ('Master of Puppets', '1986-03-03', 6, 10000000),
    ('The Doors', '1967-01-04', 7, 20000000),
    ('Ten', '1991-08-27', 8, 13000000),
    ('1984', '1984-01-09', 9, 10000000),
    ('Hotel California', '1976-12-08', 10, 32000000),
    ('Rage Against the Machine', '1992-11-03', 11, 16000000),
    ('Back in Black', '1980-07-25', 12, 50000000),
    ('Babymetal', '2014-02-26', 13, 500000),
    ('Valley of the Damned', '2003-01-25', 14, 200000),
    ('Silence iz Mine', '2008-06-25', 15, 100000),
    ('Silver Side Up', '2001-09-11', 16, 10000000),
    ('Moving Pictures', '1981-02-12', 17, 4500000),
    ('No Pads, No Helmets...Just Balls', '2002-03-19', 18, 2000000),
    ('Disraeli Gears', '1967-11-02', 19, 2500000),
    ('Layla and Other Assorted Love Songs', '1970-11-09', 20, 1000000),
    ('Led Zeppelin IV', '1971-11-08', 21, 37000000),
    ('Exile on Main St.', '1972-05-12', 22, 10000000),
    ('A Night at the Opera', '1975-11-21', 23, 6000000),
    ('The Dark Side of the Moon', '1973-03-01', 24, 45000000),
    ('Tommy', '1969-05-23', 25, 20000000),
    ('Machine Head', '1972-03-25', 26, 2000000),
    ('The Number of the Beast', '1982-03-22', 27, 14000000),
    ('Paranoid', '1970-09-18', 28, 12000000),
    ('Abbey Road', '1969-09-26', 29, 30000000),
    ('End of the Road', '1993-01-01', 30, 50000),
    ('Daylight', '1984-01-01', 31, 100000),
    ('Fortress', '1989-01-01', 32, 75000),
    ('Poogy in a Pita', '1973-06-01', 33, 100000),
    ('Mercedes', '1976-05-01', 34, 35000),
    ('Live at Mitzpe Ramon', '1984-10-01', 35, 50000),
    ('Unicorn', '1993-07-07', 36, 30000),
    ('Once', '2004-06-07', 37, 1500000),
    ('Hate Crew Deathroll', '2003-01-07', 38, 250000),
    ('Ecliptica', '1999-11-01', 39, 100000),
    ('Plays Metallica by Four Cellos', '1996-06-11', 40, 500000),
    ('Mutter', '2001-04-02', 41, 1500000),
    ('Love at First Sting', '1984-03-27', 42, 3000000),
    ('Scream', '2007-10-31', 43, 1000000),
    ('Autobahn', '1974-11-01', 44, 500000),
    ('Discovery', '2001-03-12', 45, 3000000),
    ('Magma', '2016-06-17', 46, 250000),
    ('Wolfgang Amadeus Phoenix', '2009-05-25', 47, 500000),
    ('Cross', '2007-06-18', 48, 1500000),
    ('Comalies', '2002-10-29', 49, 250000),
    ('Il ballo della vita', '2018-10-26', 50, 2000000),
    ('Electric Ladyland', '1968-10-16', 1, 2000000),
    ('Use Your Illusion I', '1991-09-17', 2, 10000000),
    ('In Utero', '1993-09-21', 3, 15000000),
    ('By the Way', '2002-07-09', 4, 8000000),
    ('Wasting Light', '2011-04-12', 5, 1500000),
    ('Ride the Lightning', '1984-07-27', 6, 6000000),
    ('L.A. Woman', '1971-04-19', 7, 2000000),
    ('Vs', '1993-10-19', 8, 7000000),
    ('Fair Warning', '1981-04-29', 9, 3000000),
    ('One of These Nights', '1975-06-10', 10, 4000000),
    ('Evil Empire', '1996-04-16', 11, 3000000),
    ('High Voltage', '1976-02-17', 12, 3000000),
    ('Metal Resistance', '2016-04-01', 13, 500000),
    ('Inhuman Rampage', '2005-12-28', 14, 500000),
    ('Thank God, There Are Hundreds of Ways To Kill Enemies', '2006-03-08', 15, 100000),
    ('Dark Horse', '2008-11-18', 16, 3000000),
    ('2112', '1976-04-01', 17, 3000000),
    ('Still Not Getting Any...', '2004-10-26', 18, 1500000),
    ('Fresh Cream', '1966-12-09', 19, 500000),
    ('In Concert', '1973-01-01', 20, 500000),
    ('Physical Graffiti', '1975-02-24', 21, 16000000),
    ('Sticky Fingers', '1971-04-23', 22, 15000000),
    ('Jazz', '1978-11-10', 23, 5000000),
    ('Wish You Were Here', '1975-09-12', 24, 20000000),
    ('Quadrophenia', '1973-10-26', 25, 8000000),
    ('In Rock', '1970-06-03', 26, 1000000),
    ('Powerslave', '1984-09-03', 27, 10000000),
    ('Sabbath Bloody Sabbath', '1973-12-01', 28, 5000000),
    ('Sgt. Peppers Lonely Hearts Club Band', '1967-06-01', 29, 32000000),
    ('Haazanut Boy', '1986-11-10', 30, 60000),
    ('Blind Vision', '1984-09-01', 31, 90000),
    ('In The City', '1989-03-01', 32, 80000),
    ('Songs of Poogy', '1973-09-01', 33, 120000),
    ('Miss Susita', '1976-08-01', 34, 45000),
    ('Eyes Open', '1984-11-01', 35, 60000),
    ('Rainbow', '1993-09-01', 36, 40000),
    ('Imaginaerum', '2011-11-30', 37, 800000),
    ('Blooddrunk', '2008-04-07', 38, 100000),
    ('Reckoning Night', '2004-09-22', 39, 70000),
    ('Reflections', '2003-02-24', 40, 300000),
    ('Sehnsucht', '1997-08-25', 41, 1500000),
    ('Savage Amusement', '1988-04-16', 42, 1000000),
    ('Zimmer 483', '2007-02-23', 43, 2000000),
    ('The Man-Machine', '1978-05-19', 44, 300000),
    ('Random Access Memories', '2013-05-17', 45, 3000000),
    ('The Way of All Flesh', '2008-10-13', 46, 150000),
    ('Its Never Been Like That', '2006-05-15', 47, 300000),
    ('Audio, Video, Disco', '2011-10-24', 48, 200000),
    ('Shallow Life', '2009-04-20', 49, 300000),
    ('Teatro dira: Vol. I', '2021-03-19', 50, 1000000),
	('Bold as Love', '1967-12-01', 1, 2000000),
    ('Use Your Illusion II', '1991-09-17', 2, 9000000),
    ('Bleach', '1989-06-15', 3, 1700000),
    ('Blood Sugar Sex Magik', '1991-09-24', 4, 14000000),
    ('Echoes, Silence, Patience & Grace', '2007-09-25', 5, 1300000),
    ('...And Justice for All', '1988-08-25', 6, 8000000),
    ('Strange Days', '1967-09-25', 7, 1500000),
    ('Vitalogy', '1994-11-22', 8, 5000000),
    ('Van Halen II', '1979-03-23', 9, 5000000),
    ('The Long Run', '1979-09-24', 10, 8000000),
    ('The Battle of Los Angeles', '1999-11-02', 11, 3000000),
    ('Highway to Hell', '1979-07-27', 12, 7000000),
    ('Metal Galaxy', '2019-10-11', 13, 300000),
    ('Sonic Firestorm', '2004-05-11', 14, 200000),
    ('EViLS', '2011-04-20', 15, 50000),
    ('The State', '1998-03-01', 16, 2000000),
    ('A Farewell to Kings', '1977-09-01', 17, 1000000),
    ('Get Your Heart On!', '2011-06-21', 18, 500000),
    ('Wheels of Fire', '1968-07-09', 19, 1000000),
    ('Live at the Fillmore', '1971-07-06', 20, 500000),
    ('Houses of the Holy', '1973-03-28', 21, 11000000),
    ('Some Girls', '1978-06-09', 22, 6000000),
    ('News of the World', '1977-10-28', 23, 4000000),
    ('Animals', '1977-01-23', 24, 10000000),
    ('Whos Next', '1971-08-14', 25, 3000000),
    ('Burn', '1974-02-15', 26, 500000),
    ('Seventh Son of a Seventh Son', '1988-04-11', 27, 5000000),
    ('Heaven and Hell', '1980-04-25', 28, 1000000),
    ('Let It Be', '1970-05-08', 29, 12000000),
    ('Hazanim Mezahim', '1995-04-01', 30, 40000),
    ('Afuch', '1988-08-01', 31, 100000),
    ('Nishkaot', '1991-03-01', 32, 60000),
    ('Shablul', '1970-05-01', 33, 100000),
    ('Einstein on the Beach', '1983-07-01', 34, 30000),
    ('Shirat Hanoar', '1990-09-01', 35, 40000),
    ('Heavy Weather', '1997-01-01', 36, 20000),
    ('Endless Forms Most Beautiful', '2015-03-27', 37, 500000),
    ('Are You Dead Yet?', '2005-10-19', 38, 300000),
    ('Unia', '2007-05-25', 39, 150000),
    ('Cult', '2000-09-25', 40, 300000),
    ('Rosenrot', '2005-10-28', 41, 1000000),
    ('Blackout', '1982-03-29', 42, 1500000),
    ('Humanoid', '2009-10-02', 43, 1000000),
    ('Radio-Activity', '1975-10-01', 44, 300000),
    ('Alive 2007', '2007-11-19', 45, 1000000),
    ('From Mars to Sirius', '2005-09-27', 46, 150000),
    ('United', '2000-06-05', 47, 100000),
    ('Woman', '2016-11-18', 48, 200000),
    ('Broken Crown Halo', '2014-03-31', 49, 200000),
    ('Chosen', '2021-12-17', 50, 800000),
    ('Axis: Bold as Love', '1967-12-01', 1, 1500000),
    ('Chinese Democracy', '2008-11-23', 2, 3000000),
    ('MTV Unplugged in New York', '1994-11-01', 3, 10000000),
    ('The Getaway', '2016-06-17', 4, 3000000),
    ('Concrete and Gold', '2017-09-15', 5, 1500000),
    ('Death Magnetic', '2008-09-12', 6, 2000000),
    ('Morrison Hotel', '1970-02-09', 7, 500000),
    ('Binaural', '2000-05-16', 8, 700000),
    ('OU812', '1988-05-24', 9, 4000000),
    ('Hell Freezes Over', '1994-11-08', 10, 9000000),
    ('Renegades', '2000-12-05', 11, 2000000),
    ('The Razors Edge', '1990-09-24', 12, 5000000),
    ('Live at Wembley', '2016-12-02', 13, 100000),
    ('Ultra Beatdown', '2008-08-20', 14, 200000),
    ('Seeds of Light', '2013-03-06', 15, 30000),
    ('Here and Now', '2011-11-21', 16, 1500000),
    ('Hemispheres', '1978-10-29', 17, 1000000),
    ('Taking One for the Team', '2016-02-19', 18, 400000),
    ('Goodbye', '1969-02-05', 19, 500000),
    ('The Fillmore Concerts', '1992-10-20', 20, 200000),
    ('Presence', '1976-03-31', 21, 3000000),
    ('Black and Blue', '1976-04-23', 22, 2000000),
    ('The Game', '1980-06-30', 23, 4000000),
    ('The Wall', '1979-11-30', 24, 30000000),
    ('Live at Leeds', '1970-05-16', 25, 500000),
    ('Stormbringer', '1974-11-08', 26, 300000),
    ('Somewhere in Time', '1986-09-29', 27, 5000000),
    ('Technical Ecstasy', '1976-09-25', 28, 500000),
    ('Magical Mystery Tour', '1967-11-27', 29, 15000000),
    ('From Me to You', '2002-11-05', 30, 30000),
    ('Neshef', '1986-01-01', 31, 80000),
    ('Balayla', '1990-01-01', 32, 50000),
    ('The Road', '1992-04-01', 33, 90000),
    ('Baghdad', '1986-01-01', 34, 40000),
    ('Shelter', '1995-01-01', 35, 30000),
    ('Coming Home', '2000-10-01', 36, 20000),
    ('Centuries of Chaos', '2017-03-27', 37, 400000),
    ('Follow the Reaper', '2000-10-30', 38, 400000),
    ('Winterhearts Guild', '2003-02-24', 39, 250000),
    ('Inquisition Symphony', '1998-09-22', 40, 200000),
    ('Herzeleid', '1995-09-25', 41, 500000),
    ('Face the Heat', '1993-09-21', 42, 800000),
    ('Dream Machine', '2017-03-03', 43, 300000),
    ('Trans-Europe Express', '1977-03-30', 44, 500000),
    ('TRON: Legacy', '2010-12-07', 45, 600000),
    ('Terra Incognita', '2001-03-19', 46, 200000),
    ('The Power of Now', '2011-03-29', 48, 200000),
    ('Delirium', '2016-05-27', 49, 200000);
GO


-- 150 Social Media Statistics
-- Social Media information For Each Band
INSERT INTO Social_Media_Statistics (Social_Media_Id, Band_id, Platform, Followers)
VALUES
    (1, 1, 'Instagram', 1200000),
    (2, 1, 'Facebook', 1500000),
    (3, 1, 'Twitter', 800000),
    (4, 2, 'Instagram', 5000000),
    (5, 2, 'Facebook', 7000000),
    (6, 2, 'Twitter', 3000000),
    (7, 3, 'Instagram', 10000000),
    (8, 3, 'Facebook', 12000000),
    (9, 3, 'Twitter', 8000000),
    (10, 4, 'Instagram', 2000000),
    (11, 4, 'Facebook', 2500000),
    (12, 4, 'Twitter', 1500000),
    (13, 5, 'Instagram', 4000000),
    (14, 5, 'Facebook', 5000000),
    (15, 5, 'Twitter', 3500000),
    (16, 6, 'Instagram', 9000000),
    (17, 6, 'Facebook', 11000000),
    (18, 6, 'Twitter', 7000000),
    (19, 7, 'Instagram', 800000),
    (20, 7, 'Facebook', 1000000),
    (21, 7, 'Twitter', 600000),
    (22, 8, 'Instagram', 1800000),
    (23, 8, 'Facebook', 2200000),
    (24, 8, 'Twitter', 1200000),
    (25, 9, 'Instagram', 1500000),
    (26, 9, 'Facebook', 1800000),
    (27, 9, 'Twitter', 1000000),
    (28, 10, 'Instagram', 3000000),
    (29, 10, 'Facebook', 3500000),
    (30, 10, 'Twitter', 2500000),
    (31, 11, 'Instagram', 1200000),
    (32, 11, 'Facebook', 1500000),
    (33, 11, 'Twitter', 1000000),
    (34, 12, 'Instagram', 8000000),
    (35, 12, 'Facebook', 10000000),
    (36, 12, 'Twitter', 6000000),
    (37, 13, 'Instagram', 600000),
    (38, 13, 'Facebook', 800000),
    (39, 13, 'Twitter', 400000),
    (40, 14, 'Instagram', 700000),
    (41, 14, 'Facebook', 900000),
    (42, 14, 'Twitter', 500000),
    (43, 15, 'Instagram', 300000),
    (44, 15, 'Facebook', 400000),
    (45, 15, 'Twitter', 200000),
    (46, 16, 'Instagram', 2000000),
    (47, 16, 'Facebook', 2500000),
    (48, 16, 'Twitter', 1500000),
    (49, 17, 'Instagram', 1000000),
    (50, 17, 'Facebook', 1200000),
    (51, 17, 'Twitter', 700000),
    (52, 18, 'Instagram', 1500000),
    (53, 18, 'Facebook', 1800000),
    (54, 18, 'Twitter', 900000),
    (55, 19, 'Instagram', 800000),
    (56, 19, 'Facebook', 1000000),
    (57, 19, 'Twitter', 500000),
    (58, 20, 'Instagram', 600000),
    (59, 20, 'Facebook', 800000),
    (60, 20, 'Twitter', 300000),
    (61, 21, 'Instagram', 9000000),
    (62, 21, 'Facebook', 11000000),
    (63, 21, 'Twitter', 8000000),
    (64, 22, 'Instagram', 6000000),
    (65, 22, 'Facebook', 8000000),
    (66, 22, 'Twitter', 5000000),
    (67, 23, 'Instagram', 2000000),
    (68, 23, 'Facebook', 2500000),
    (69, 23, 'Twitter', 1500000),
    (70, 24, 'Instagram', 12000000),
    (71, 24, 'Facebook', 15000000),
    (72, 24, 'Twitter', 10000000),
    (73, 25, 'Instagram', 5000000),
    (74, 25, 'Facebook', 7000000),
    (75, 25, 'Twitter', 4000000),
    (76, 26, 'Instagram', 3000000),
    (77, 26, 'Facebook', 3500000),
    (78, 26, 'Twitter', 2500000),
    (79, 27, 'Instagram', 9000000),
    (80, 27, 'Facebook', 11000000),
    (81, 27, 'Twitter', 7000000),
    (82, 28, 'Instagram', 8000000),
    (83, 28, 'Facebook', 10000000),
    (84, 28, 'Twitter', 6000000),
    (85, 29, 'Instagram', 12000000),
    (86, 29, 'Facebook', 15000000),
    (87, 29, 'Twitter', 10000000),
    (88, 30, 'Instagram', 200000),
    (89, 30, 'Facebook', 250000),
    (90, 30, 'Twitter', 150000),
    (91, 31, 'Instagram', 300000),
    (92, 31, 'Facebook', 350000),
    (93, 31, 'Twitter', 200000),
    (94, 32, 'Instagram', 400000),
    (95, 32, 'Facebook', 450000),
    (96, 32, 'Twitter', 250000),
    (97, 33, 'Instagram', 500000),
    (98, 33, 'Facebook', 600000),
    (99, 33, 'Twitter', 350000),
    (100, 34, 'Instagram', 100000),
    (101, 34, 'Facebook', 150000),
    (102, 34, 'Twitter', 50000),
    (103, 35, 'Instagram', 200000),
    (104, 35, 'Facebook', 250000),
    (105, 35, 'Twitter', 150000),
    (106, 36, 'Instagram', 300000),
    (107, 36, 'Facebook', 350000),
    (108, 36, 'Twitter', 200000),
    (109, 37, 'Instagram', 600000),
    (110, 37, 'Facebook', 700000),
    (111, 37, 'Twitter', 500000),
    (112, 38, 'Instagram', 400000),
    (113, 38, 'Facebook', 450000),
    (114, 38, 'Twitter', 300000),
    (115, 39, 'Instagram', 500000),
    (116, 39, 'Facebook', 550000),
    (117, 39, 'Twitter', 350000),
    (118, 40, 'Instagram', 600000),
    (119, 40, 'Facebook', 700000),
    (120, 40, 'Twitter', 450000),
    (121, 41, 'Instagram', 2000000),
    (122, 41, 'Facebook', 2500000),
    (123, 41, 'Twitter', 1500000),
    (124, 42, 'Instagram', 1000000),
    (125, 42, 'Facebook', 1200000),
    (126, 42, 'Twitter', 800000),
    (127, 43, 'Instagram', 200000),
    (128, 43, 'Facebook', 250000),
    (129, 43, 'Twitter', 150000),
    (130, 44, 'Instagram', 400000),
    (131, 44, 'Facebook', 450000),
    (132, 44, 'Twitter', 300000),
    (133, 45, 'Instagram', 3000000),
    (134, 45, 'Facebook', 3500000),
    (135, 45, 'Twitter', 2500000),
    (136, 46, 'Instagram', 200000),
    (137, 46, 'Facebook', 250000),
    (138, 46, 'Twitter', 150000),
    (139, 47, 'Instagram', 300000),
    (140, 47, 'Facebook', 350000),
    (141, 47, 'Twitter', 200000),
    (142, 48, 'Instagram', 150000),
    (143, 48, 'Facebook', 200000),
    (144, 48, 'Twitter', 100000),
    (145, 49, 'Instagram', 400000),
    (146, 49, 'Facebook', 450000),
    (147, 49, 'Twitter', 300000),
    (148, 50, 'Instagram', 500000),
    (149, 50, 'Facebook', 600000),
    (150, 50, 'Twitter', 350000);
GO


-- 98 Guitarists
-- Guitarists
INSERT INTO Guitarists (First_Name, Last_Name, Signature_Guitar, Country, Band, Is_Alive, Net_Worth)
VALUES
    ('Jimi', 'Hendrix', 1, 1, 1, 'NO', 5000000),
    ('Slash', 'Hudson', 2, 1, 2, 'YES', 90000000),
    ('Kurt', 'Cobain', 3, 1, 3, 'NO', 50000000),
    ('John', 'Frusciante', 4, 1, 4, 'YES', 20000000),
    ('Dave', 'Grohl', 5, 1, 5, 'YES', 320000000),
    ('Kirk', 'Hammett', 6, 1, 6, 'YES', 200000000),
    ('Robby', 'Krieger', 7, 1, 7, 'YES', 15000000),
    ('Mike', 'McCready', 8, 1, 8, 'YES', 70000000),
    ('Eddie', 'Van Halen', 9, 1, 9, 'NO', 100000000),
    ('Joe', 'Walsh', 10, 1, 10, 'YES', 75000000),
    ('Tom', 'Morello', 11, 1, 11, 'YES', 30000000),
    ('Angus', 'Young', 6, 4, 12, 'YES', 140000000),
    ('Mikio', 'Fujioka', 3, 2, 13, 'NO', 1000000),
    ('Herman', 'Li', 4, 2, 14, 'YES', 8000000),
    ('MAH', 'SiM', 3, 2, 15, 'YES', 2000000),
    ('Chad', 'Kroeger', 3, 3, 16, 'YES', 60000000),
    ('Alex', 'Lifeson', 1, 3, 17, 'YES', 35000000),
    ('Jeff', 'Stinco', 1, 3, 18, 'YES', 9000000),
    ('Eric', 'Clapton', 4, 4, 19, 'YES', 450000000),
    ('Duane', 'Allman', 1, 4, 20, 'NO', 10000000),
    ('Jimmy', 'Page', 3, 4, 21, 'YES', 180000000),
    ('Keith', 'Richards', 3, 4, 22, 'YES', 500000000),
    ('Brian', 'May', 4, 4, 23, 'YES', 210000000),
    ('David', 'Gilmour', 3, 4, 24, 'YES', 180000000),
    ('Pete', 'Townshend', 3, 4, 25, 'YES', 150000000),
    ('Ritchie', 'Blackmore', 1, 4, 26, 'YES', 18000000),
    ('Adrian', 'Smith', 1, 4, 27, 'YES', 40000000),
    ('Tony', 'Iommi', 2, 4, 28, 'YES', 140000000),
    ('George', 'Harrison', 1, 4, 29, 'NO', 400000000),
    ('Yosi', 'Sassi', 1, 5, 30, 'YES', 1000000),
    ('Yuval', 'Banai', 3, 5, 31, 'YES', 5000000),
    ('Oren', 'Balbus', 3, 5, 32, 'YES', 1000000),
    ('Efraim', 'Shamir', 3, 5, 33, 'YES', 1000000),
    ('Kobi', 'Oz', 3, 5, 34, 'YES', 2000000),
    ('Baruch', 'Levi', 3, 5, 35, 'YES', 1000000),
    ('Tzvika', 'Pick', 3, 5, 36, 'NO', 1000000),
    ('Emppu', 'Vuorinen', 1, 6, 37, 'YES', 3000000),
    ('Alexi', 'Laiho', 3, 6, 38, 'NO', 1000000),
    ('Jani', 'Liimatainen', 3, 6, 39, 'YES', 1000000),
    ('Eicca', 'Toppinen', 3, 6, 40, 'YES', 2000000),
    ('Richard', 'Kruspe', 3, 7, 41, 'YES', 20000000),
    ('Rudolf', 'Schenker', 3, 7, 42, 'YES', 80000000),
    ('Tom', 'Kaulitz', 1, 7, 43, 'YES', 25000000),
    ('Ralf', 'Hütter', 3, 7, 44, 'YES', 10000000),
    ('Thomas', 'Bangalter', 4, 8, 45, 'YES', 90000000),
    ('Christian', 'Andreu', 3, 8, 46, 'YES', 5000000),
    ('Laurent', 'Brancowitz', 1, 8, 47, 'YES', 3000000),
    ('Xavier', 'de Rosnay', 3, 8, 48, 'YES', 10000000),
    ('Cristina', 'Scabbia', 3, 9, 49, 'YES', 2000000),
    ('Thomas', 'Raggi', 3, 9, 50, 'YES', 5000000),
    ('Steve', 'Jones', 1, 4, 27, 'YES', 12000000),
    ('Kiko', 'Loureiro', 3, 4, 41, 'YES', 10000000),
    ('Daron', 'Malakian', 1, 1, 12, 'YES', 20000000),
    ('Johnny', 'Ramone', 3, 1, 9, 'NO', 20000000),
    ('Johnny', 'Greenwood', 3, 4, 26, 'YES', 10000000),
    ('Joe', 'Perry', 3, 1, 10, 'YES', 140000000),
    ('Richie', 'Sambora', 3, 1, 10, 'YES', 100000000),
    ('Buddy', 'Holly', 3, 1, 6, 'NO', 10000000),
    ('Brian', 'Setzer', 3, 1, 12, 'YES', 8000000),
    ('Frank', 'Zappa', 4, 1, 5, 'NO', 40000000),
    ('Joe', 'Satriani', 4, 1, 14, 'YES', 12000000),
    ('Steve', 'Vai', 4, 1, 14, 'YES', 14000000),
    ('Zakk', 'Wylde', 3, 1, 6, 'YES', 16000000),
    ('Billy', 'Gibbons', 3, 1, 9, 'YES', 60000000),
    ('James', 'Hetfield', 3, 1, 6, 'YES', 300000000),
    ('Randy', 'Rhoads', 3, 1, 6, 'NO', 10000000),
    ('John', 'Petrucci', 4, 1, 9, 'YES', 35000000),
    ('Mark', 'Knopfler', 3, 1, 12, 'YES', 95000000),
    ('B.B.', 'King', 1, 1, 6, 'NO', 30000000),
    ('Chuck', 'Berry', 1, 1, 6, 'NO', 10000000),
    ('Bo', 'Diddley', 1, 1, 6, 'NO', 5000000),
    ('Rory', 'Gallagher', 1, 1, 6, 'NO', 10000000),
    ('Django', 'Reinhardt', 1, 1, 6, 'NO', 5000000),
    ('Les', 'Paul', 1, 1, 2, 'NO', 5000000),
    ('Carlos', 'Santana', 4, 1, 4, 'YES', 120000000),
    ('Dave', 'Mustaine', 3, 1, 6, 'YES', 20000000),
    ('Michael', 'Schenker', 3, 1, 42, 'YES', 60000000),
    ('Adrian', 'Vandenberg', 3, 1, 6, 'YES', 20000000),
    ('Warren', 'DeMartini', 3, 1, 6, 'YES', 6000000),
    ('Steve', 'Clark', 3, 1, 6, 'NO', 8000000),
    ('Vivian', 'Campbell', 3, 1, 6, 'YES', 20000000),
    ('Vito', 'Bratta', 3, 1, 6, 'YES', 10000000),
    ('John', 'Sykes', 3, 1, 6, 'YES', 10000000),
    ('Gary', 'Moore', 3, 1, 6, 'NO', 10000000),
    ('Mick', 'Mars', 3, 1, 6, 'YES', 70000000),
    ('Jake', 'E. Lee', 3, 1, 6, 'YES', 10000000),
    ('Neal', 'Schon', 3, 1, 6, 'YES', 40000000),
    ('Tommy', 'Thayer', 3, 1, 6, 'YES', 10000000),
    ('Ace', 'Frehley', 3, 1, 6, 'YES', 10000000),
    ('Andy', 'Timmons', 4, 1, 14, 'YES', 2000000),
    ('Nuno', 'Bettencourt', 3, 1, 6, 'YES', 10000000),
    ('Reb', 'Beach', 3, 1, 6, 'YES', 7000000),
    ('Jeff', 'Beck', 3, 1, 6, 'YES', 18000000),
    ('Richie', 'Kotzen', 3, 1, 6, 'YES', 10000000),
    ('Paul', 'Gilbert', 4, 1, 14, 'YES', 5000000),
    ('Marty', 'Friedman', 4, 1, 14, 'YES', 10000000),
    ('Bruce', 'Kulick', 3, 1, 6, 'YES', 5000000),
    ('Dimebag', 'Darrell', 3, 1, 6, 'NO', 10000000);
GO


-- 212 Concerts
-- Concerts
INSERT INTO Concerts (Band_id, Location_id, Date, Attendance, Revenue, Tickets_Sold)
VALUES
    (1, 1, '1967-01-15', 17468, 1426598.00, 18215),
    (2, 2, '1986-03-20', 53458, 2826598.00, 54000),
    (3, 3, '1989-07-05', 48124, 2425598.00, 48987),
    (4, 4, '1985-11-12', 88125, 4912489.00, 89000),
    (5, 5, '1996-09-10', 9256, 656698.00, 9500),
    (6, 6, '1984-10-07', 14224, 113695.00, 14500),
    (7, 7, '1968-03-14', 16269, 130244.00, 16500),
    (8, 8, '1995-04-21', 19000, 171248.00, 19280),
    (9, 9, '1975-12-28', 12000, 906398.00, 12000),
    (10, 10, '1981-02-15', 16500, 1205599.00, 17500),
    (11, 11, '1991-07-02', 19500, 1406587.00, 19500),
    (12, 12, '1981-05-10', 20595, 150000.00, 21060),
    (13, 13, '2012-08-18', 36951, 190600.00, 37000),
    (14, 14, '2005-10-25', 19000, 110000.00, 19000),
    (15, 15, '2010-11-12', 28000, 140000.00, 28000),
    (16, 16, '2001-04-19', 13200, 850000.00, 13200),
    (17, 17, '1976-06-26', 73000, 38000.00, 74475),
    (18, 18, '2008-03-15', 80500, 43000.00, 81338),
    (19, 19, '1999-07-03', 17200, 100000.00, 17200),
    (20, 20, '2002-08-20', 16500, 12000.00, 16500),
    (21, 21, '1969-09-15', 9200, 50000.00, 9525),
    (22, 22, '2003-10-10', 13500, 70000.00, 14000),
    (23, 23, '1991-11-05', 20500, 140000.00, 21302),
    (24, 24, '1982-12-01', 19500, 130000.00, 21000),
    (25, 25, '1993-01-27', 10830, 60000.00, 11000),
    (26, 26, '1995-02-15', 11700, 70090.00, 11700),
    (27, 27, '2003-03-10', 19500, 1200000.00, 20000),
    (28, 28, '1979-04-18', 46000, 2400000.00, 47929),
    (29, 29, '1984-05-05', 15500, 850000.00, 15500),
    (30, 30, '2008-06-23', 18000, 1000000.00, 18000),
    (31, 31, '1981-07-12', 23000, 1300000.00, 23500),
    (32, 32, '2010-08-20', 50000, 2800336.00, 51000),
    (33, 33, '2001-09-30', 15500, 750456.00, 16145),
    (34, 34, '1972-10-22', 13500, 600125.00, 14000),
    (35, 35, '2014-11-19', 14500, 800023.00, 15500),
    (36, 36, '1990-12-10', 61000, 3306015.00, 62000),
    (37, 37, '2007-01-15', 66000, 3600127.00, 67000),
    (38, 38, '2004-02-05', 10500, 600000.00, 11000),
    (39, 39, '2007-03-15', 59000, 3400258.00, 60000),
    (40, 40, '2000-04-12', 18571, 1106639.00, 19000),
    (41, 41, '1997-05-30', 37513, 1800000.00, 38000),
    (42, 42, '2001-06-20', 18560, 904211.00, 18910),
    (43, 43, '2003-07-12', 11300, 500225.00, 11300),
    (44, 44, '2014-08-10', 8279, 45226.00, 8300),
    (45, 45, '2018-09-05', 56498, 2902659.00, 57000),
    (46, 46, '2002-10-30', 58750, 3400115.00, 59000),
    (47, 47, '2019-11-20', 4233, 250115.00, 4300),
    (48, 48, '2020-12-18', 82365, 3800366.00, 83000),
    (49, 49, '2021-01-25', 19559, 1000000.00, 19580),
    (50, 50, '2021-02-15', 49340, 2800000.00, 49500),
    (1, 1, '2021-03-10', 17099, 1400366.00, 18000),
    (2, 2, '2021-04-05', 52400, 289668.00, 55000),
    (3, 3, '2021-05-20', 47122, 24000.00, 49000),
    (4, 4, '2021-06-15', 85659, 480000.00, 90000),
    (5, 5, '2021-07-10', 9000, 65000.00, 10000),
    (6, 6, '2021-08-25', 14000, 11000.00, 15000),
    (7, 7, '2021-09-18', 16078, 130000.00, 17000),
    (8, 8, '2021-10-05', 18770, 170000.00, 20000),
    (9, 9, '2021-11-12', 11500, 90000.00, 12700),
    (10, 10, '2021-12-20', 16000, 120000.00, 17500),
    (11, 11, '2022-01-15', 18580, 140336.00, 20000),
    (12, 12, '2022-02-10', 20000, 150000.00, 21000),
    (13, 13, '2022-03-07', 35000, 190000.00, 37000),
    (14, 14, '2022-04-05', 18500, 110000.00, 19800),
    (15, 15, '2022-05-15', 27000, 140000.00, 29000),
    (16, 16, '2022-06-12', 13000, 85000.00, 13500),
    (17, 17, '2022-07-10', 73650, 3836500.00, 74475),
    (18, 18, '2022-08-15', 80500, 4302558.00, 81338),
    (19, 19, '2022-09-03', 17284, 1000000.00, 18000),
    (20, 20, '2022-10-20', 16532, 1265520.00, 17506),
    (21, 21, '2022-11-15', 9200, 500000.00, 9525),
    (22, 22, '2022-12-10', 13500, 700000.00, 14000),
    (23, 23, '2023-01-05', 20500, 1403258.00, 21302),
    (24, 24, '2023-02-01', 19500, 1300255.00, 21000),
    (25, 25, '2023-03-27', 10800, 601365.00, 11000),
    (26, 26, '2023-04-15', 11700, 700258.00, 11700),
    (27, 27, '2023-05-10', 19500, 1203369.00, 20000),
    (28, 28, '2023-06-18', 46000, 2405502.00, 47929),
    (29, 29, '2023-07-05', 15500, 850025.00, 15500),
    (30, 30, '2023-08-23', 18000, 100000.00, 18000),
    (31, 31, '2023-09-12', 23221, 1306697.00, 23500),
    (32, 32, '2023-10-20', 50000, 2800050.00, 51000),
    (33, 33, '2023-11-30', 15500, 750000.00, 16145),
    (34, 34, '2023-12-22', 13588, 602298.00, 14000),
    (35, 35, '2024-01-19', 14500, 803267.00, 15500),
    (36, 36, '2024-02-10', 61339, 3300000.00, 62000),
    (37, 37, '2024-03-15', 66237, 360224.00, 67000),
    (38, 38, '2024-04-05', 10970, 601187.00, 11000),
    (39, 39, '2024-05-15', 59000, 3400057.00, 60000),
    (40, 40, '2024-06-12', 18500, 1103369.00, 19000),
    (1, 1, '1968-07-15', 16095, 130220.00, 17000),
    (2, 2, '1987-08-20', 51480, 2700005.00, 52000),
    (3, 3, '1990-09-10', 47000, 230117.00, 48000),
    (4, 4, '1986-10-15', 87045, 460364.00, 88000),
    (5, 5, '1997-11-10', 8669, 600000.00, 9000),
    (6, 6, '1985-12-07', 13024, 1007893.00, 14000),
    (7, 7, '1969-01-14', 15000, 1200418.00, 16000),
    (8, 8, '1996-03-21', 17578, 1500000.00, 19000),
    (9, 9, '1976-05-28', 11000, 80227.00, 12000),
    (10, 10, '1982-02-15', 15504, 1100000.00, 16500),
    (11, 11, '1992-03-02', 18500, 130328.00, 19500),
    (12, 12, '1982-04-10', 19598, 1400000.00, 20500),
    (13, 13, '2013-06-18', 34592, 1801246.00, 36000),
    (14, 14, '2006-07-25', 18000, 100448.00, 19000),
    (15, 15, '2011-08-12', 26000, 1303260.00, 28000),
    (16, 16, '2002-09-19', 12500, 800390.00, 13200),
    (17, 17, '1977-11-26', 71558, 3600658.00, 73000),
    (18, 18, '2009-01-15', 79000, 4200145.00, 80500),
    (19, 19, '2000-03-03', 16457, 900122.00, 17200),
    (20, 20, '2003-04-20', 15453, 110018.00, 16500),
    (21, 21, '1970-05-15', 8700, 45788.00, 9200),
    (22, 22, '2004-06-10', 12500, 600000.00, 13500),
    (23, 23, '1992-08-05', 19000, 1300000.00, 20500),
    (24, 24, '1983-09-01', 18500, 1200000.00, 19500),
    (25, 25, '1994-10-27', 10500, 550000.00, 10800),
    (26, 26, '1996-12-15', 11000, 650000.00, 11700),
    (27, 27, '2004-02-10', 18500, 1100000.00, 19500),
    (28, 28, '1980-04-18', 45000, 2300000.00, 46000),
    (29, 29, '1985-05-05', 14500, 800000.00, 15500),
    (30, 30, '2009-06-23', 17500, 950000.00, 18000),
    (31, 31, '1982-07-12', 22000, 120000.00, 23000),
    (32, 32, '2011-08-20', 49000, 270000.00, 50000),
    (33, 33, '2002-09-30', 15000, 700000.00, 15500),
    (34, 34, '1973-10-22', 13000, 550000.00, 13500),
    (35, 35, '2015-11-19', 14000, 75000.00, 14500),
    (36, 36, '1991-12-10', 59000, 3207850.00, 61000),
    (37, 37, '2008-01-15', 64000, 354700.00, 66000),
    (38, 38, '2005-02-05', 10000, 550031.00, 10500),
    (39, 39, '2008-03-15', 57000, 3307890.00, 59000),
    (40, 40, '2001-04-12', 18000, 1000028.00, 18500),
    (41, 41, '1998-05-30', 36000, 1700000.00, 37500),
    (42, 42, '2002-06-20', 18000, 850000.00, 18500),
    (43, 43, '2004-07-12', 11000, 450000.00, 11300),
    (44, 44, '2015-08-10', 8000, 350000.00, 8200),
    (45, 45, '2019-09-05', 55000, 2800000.00, 56000),
    (46, 46, '2003-10-30', 57000, 3300000.00, 58000),
    (47, 47, '2020-11-20', 4000, 230000.00, 4200),
    (48, 48, '2021-12-18', 79000, 3700000.00, 80000),
    (49, 49, '2022-01-25', 18000, 950000.00, 19000),
    (50, 50, '2022-02-15', 47000, 2700000.00, 48000),
    (1, 1, '2022-03-10', 16000, 1300000.00, 17000),
    (2, 2, '2022-04-05', 51000, 2700000.00, 52000),
    (3, 3, '2022-05-20', 46000, 2300000.00, 47000),
    (4, 4, '2022-06-15', 84000, 4600000.00, 85000),
    (5, 5, '2022-07-10', 8500, 600000.00, 9000),
    (6, 6, '2022-08-25', 13800, 1078500.00, 14000),
    (7, 7, '2022-09-18', 15000, 1200778.00, 16000),
    (8, 8, '2022-10-05', 17500, 1500000.00, 19000),
    (9, 9, '2022-11-12', 11000, 800000.00, 11500),
    (10, 10, '2022-12-20', 15500, 1100000.00, 16000),
    (11, 11, '2023-01-15', 18000, 1300000.00, 18500),
    (12, 12, '2023-02-10', 19500, 1400000.00, 20000),
    (13, 13, '2023-03-07', 34600, 1800000.00, 35000),
    (14, 14, '2023-04-05', 18500, 1001246.00, 18500),
    (15, 15, '2023-05-15', 27000, 1304405.00, 27000),
    (16, 16, '2023-06-12', 12530, 800005.00, 13000),
    (17, 17, '2023-07-10', 71448, 3604478.00, 73000),
    (18, 18, '2023-08-15', 79336, 4205584.00, 80500),
    (19, 19, '2023-09-03', 16894, 909635.00, 17200),
    (20, 20, '2023-10-20', 16239, 1100201.00, 16500),
    (21, 21, '2023-11-15', 8777, 45000.00, 9200),
    (22, 22, '2023-12-10', 12549, 696987.00, 13500),
	(1, 1, '1968-05-25', 17547, 1456255.00, 18000),
    (2, 2, '1987-07-10', 51663, 2757855.00, 52000),
    (3, 3, '1991-08-15', 47587, 2350000.00, 48000),
    (4, 4, '1987-09-20', 87787, 465487.00, 88000),
    (5, 5, '1998-10-05', 8949, 624565.00, 9000),
    (6, 6, '1986-11-07', 13265, 1023115.00, 14000),
    (7, 7, '1970-12-15', 15587, 1230125.00, 16000),
    (8, 8, '1997-01-20', 18698, 1555579.00, 19500),
    (9, 9, '1977-02-25', 11565, 859995.00, 12000),
    (10, 10, '1983-03-05', 16498, 1157869.00, 16500),
    (11, 11, '1993-04-10', 19369, 1354289.00, 19500),
    (12, 12, '1983-05-15', 20695, 1457985.00, 21000),
    (13, 13, '2014-06-20', 35516, 1921297.00, 37000),
    (14, 14, '2007-07-25', 18536, 1123069.00, 19000),
    (15, 15, '2012-08-30', 26596, 1424521.00, 28000),
    (16, 16, '2003-09-05', 12800, 877816.00, 13200),
    (17, 17, '1978-10-15', 72000, 379669.00, 74475),
    (18, 18, '2010-11-25', 80000, 4323069.00, 81338),
    (19, 19, '2001-12-30', 17000, 1021263.00, 17200),
    (20, 20, '2004-01-05', 16000, 1230213.00, 16500),
    (21, 21, '1971-02-15', 9000, 487896.00, 9525),
    (22, 22, '2005-03-20', 13200, 723620.00, 14254),
    (23, 23, '1993-04-25', 20000, 1427780.00, 21302),
    (24, 24, '1984-05-30', 19200, 1354578.00, 21260),
    (25, 25, '1995-06-10', 11000, 621023.00, 11000),
    (26, 26, '1997-07-15', 11500, 674593.00, 11700),
    (27, 27, '2005-08-25', 19200, 1231029.00, 20652),
    (28, 28, '1981-09-30', 47000, 2450232.00, 47929),
    (29, 29, '1986-10-05', 15700, 861025.00, 15978),
    (30, 30, '2010-11-12', 18300, 1033698.00, 22000),
    (31, 31, '1983-12-25', 23500, 1351259.00, 23500),
    (32, 32, '2012-01-05', 50500, 2854560.00, 51000),
    (33, 33, '2003-02-15', 15700, 780778.00, 16145),
    (34, 34, '1974-03-20', 13700, 630148.00, 14000),
    (35, 35, '2016-04-25', 14800, 830000.00, 15500),
    (36, 36, '1992-05-30', 61500, 3350000.00, 62000),
    (37, 37, '2009-06-15', 66500, 3650000.00, 67000),
    (38, 38, '2006-07-10', 10800, 630125.00, 11000),
    (39, 39, '2009-08-25', 59500, 3459986.00, 60000),
    (40, 40, '2002-09-15', 18700, 1133658.00, 19000),
    (41, 41, '1999-10-05', 38000, 1851245.00, 38000),
    (42, 42, '2003-11-20', 18700, 920457.00, 18910),
    (43, 43, '2005-12-10', 11500, 530785.00, 11956),
    (44, 44, '2016-01-25', 8300, 420245.00, 8300),
    (45, 45, '2020-02-20', 57000, 2950778.00, 57000),
    (46, 46, '2004-03-15', 59000, 3450365.00, 59000),
    (47, 47, '2021-04-25', 4300, 260425.00, 4300),
    (48, 48, '2022-05-30', 81000, 3854785.00, 81987),
    (49, 49, '2023-06-10', 19500, 1054452.00, 19580),
    (50, 50, '2023-07-15', 49500, 2854586.00, 49500);
GO   




-- ===========================================================
-- ===========================================================

-- ========VIEWS========

-- 1.Band Total Revenue

ALTER VIEW Band_Total_Revenue AS
SELECT 
    B.Band_Name,
    SUM(C.Revenue) AS Concerts_Profit,
    SUM(A.Copies_Sold) AS Album_Sales_Profit,
    (SUM(C.Revenue) + SUM(A.Copies_Sold)) AS Total_Revenue
FROM 
    Concerts C
INNER JOIN 
    Bands B ON C.Band_id = B.id
LEFT JOIN 
    Albums A ON A.Band_id = B.id
GROUP BY 
    B.Band_Name
GO



-- 2. Average Ticket Price by Band

ALTER VIEW Avg_Ticket_Price_By_Band AS
SELECT
	b.Band_Name,
	(AVG(c.Revenue / c.Tickets_Sold)) AS Avg_Ticket_Price
FROM Concerts c
INNER JOIN Bands b ON c.Band_id = b.id
GROUP BY b.Band_Name;
GO



-- 3. Total Album Copies Sold by Country

ALTER VIEW Album_Copies_Sales_By_Country AS
SELECT 
	c.Name AS Country,
	SUM(a.Copies_Sold) AS Total_Copies_Sold
FROM Albums a
INNER JOIN Bands b ON a.Band_id = b.id
INNER JOIN Countries c ON b.Country_id = c.id
GROUP BY c.Name
GO



-- 4. Social Media Followers by Platform

ALTER VIEW Social_Media_Statistics_By_Platform AS
SELECT 
	Platform,
	SUM(Followers) AS Total_Followers
FROM Social_Media_Statistics
GROUP BY Platform;
GO



-- 5 Social Media Followers Per Band

ALTER VIEW Social_Media_Followers_Per_Band AS
SELECT 
    b.Band_Name,
    sm.Platform,
    SUM(sm.Followers) AS Total_Followers
FROM 
    Social_Media_Statistics sm
INNER JOIN 
    Bands b ON sm.Band_id = b.id
GROUP BY 
    b.Band_Name,
	sm.Platform;
GO



-- 6 Copies sold per album

ALTER VIEW Copies_sold_per_album AS
SELECT
	b.Band_Name,
	a.Album_Name,
	a.Copies_Sold AS Copies_Sold
FROM Albums a
INNER JOIN Bands b ON a.Band_id = b.id;
GO



-- 7 Albums Sold Per Band

ALTER VIEW Albums_Sold_Per_Band AS
SELECT 
    b.Band_Name,
	c.Name AS Country,
    SUM(a.Copies_Sold) AS Albums_Sold
FROM 
    Albums a
INNER JOIN 
    Bands b ON a.Band_id = b.id
INNER JOIN
	Countries c ON c.id = b.Country_id
GROUP BY 
    b.Band_Name, c.Name;
 GO



-- 8 How Many Didn't Show up

ALTER VIEW Concert_Attendance_vs_TicketsSold AS
SELECT 
    
    b.Band_Name,
    l.Location_Name,
    CONVERT(VARCHAR, c.Date, 103) AS Date,
    c.Attendance AS Attendance,
    c.Tickets_Sold AS Tickets_Sold,
    (c.Tickets_Sold - c.Attendance) AS "Didn't show up"
FROM 
    Concerts c
INNER JOIN 
    Bands b ON c.Band_id = b.id
INNER JOIN 
    locations l ON c.Location_id = l.Location_id;
GO



-- 9 How many concerts took place per day of the week

CREATE VIEW Concert_Count_By_Day_Of_Week AS
SELECT 
    DATENAME(WEEKDAY, c.Date) AS "Day Of Week",
    COUNT(*) AS ConcertCount
FROM
	Concerts c
GROUP BY 
    DATENAME(WEEKDAY, Date);
GO



-- 10 Most Profitable Concert Location

ALTER VIEW Top_Profit_Location AS
SELECT 
    l.Location_Name,
	co.Name AS Country,
    (SUM(c.Revenue)) AS Total_Revenue
FROM 
    Concerts c
INNER JOIN 
    Locations l ON c.Location_id = l.Location_id
INNER JOIN
	Countries co ON co.id = l.Country_id
GROUP BY 
    l.Location_Name,
	co.Name;
GO



-- 11 Average Attendance per Band

ALTER VIEW Avg_Attendance_Per_Band AS
SELECT 
    b.Band_Name,
    AVG(c.Attendance) AS Avg_Attendance
FROM 
    Concerts c
INNER JOIN 
    Bands b ON c.Band_id = b.id
GROUP BY 
    b.Band_Name;
GO



-- 12
CREATE VIEW Bands_Founded_By_Decade AS
SELECT
	(YEAR(b.Founded_on) / 10) * 10 AS Decade,
    COUNT(*) AS Bands_Founded
FROM 
    Bands b
GROUP BY 
   (YEAR(b.Founded_on) / 10) * 10;
GO



-- 13
CREATE VIEW Concert_Attendance AS
SELECT 
    b.Band_Name,
	AVG(c.Attendance) AS Average_Attendance,
    AVG(c.Tickets_Sold - c.Attendance) AS Average_Absence
FROM 
    Concerts c
INNER JOIN 
    Bands b ON c.Band_id = b.id
GROUP BY 
    b.Band_Name;
GO



-- 14
ALTER VIEW Location_Capacity AS
SELECT 
    l.Location_Name,
    co.Name AS Country,
    l.Capacity
FROM 
    Locations l
INNER JOIN 
    Countries co ON l.Country_id = co.id;
GO


/*
Views Created
1. Band Total Revenue: Calculates the total revenue from concerts and album sales for each band.
2. Average Ticket Price by Band: Computes the average ticket price for concerts held by each band.
3. Total Albums Sold by Country: Sums the total copies of albums sold in each country.
4. Social Media Followers by Platform: Aggregates the total followers on each social media platform.
5. Social Media Followers Per Band: Summarizes the total followers per band on each social media platform.
6. Copies Sold per Album: Lists the number of copies sold for each album.
7. Albums Sold Per Band: Calculates the total albums sold by each band.
8. Concert Attendance vs. Tickets Sold: Compares the attendance and tickets sold for each concert.
9. Concert Count by Day of Week: Counts the number of concerts held on each day of the week.
10. View showing the locations that generate the most revenue from concerts
11. View showing the average attendance for concerts of each band
12. How many bands founded in each decade
13. Shows Average attendance/absence at concerts per band
14. Locations Capacity Details
*/