INSERT INTO Car
VALUES 
(0,	'3K096I98581DHSNUP',	'Volkswagen',	'Tiguan',	2019,	'Azul'),
(1,	'ZM8G7BEUQZ97IH46V',	'Peugeot',	    'Rifter',	2019,	'Rojo'),
(2,	'RKXVNNIHLVVZOUB4M',	'Ford',	        'Fusion',	2018,	'Blanco'),
(3,	'HKNDGS7CU31E9Z7JW',	'Toyota',	'RAV4',	2018,	'Plata'),
(4,	'DAM41UDN3CHU2WVF6',	'Volvo',	'V60',	2019,	'Gris'),
(5,	'DAM41UDN3CHU2WVF6',	'Volvo',	'V60 Cross Country',	2019,	'Gris');

-- Comprobación
--SELECT * FROM Car;



INSERT INTO Customer(ID,ClientNr,Name,Phone,Address,City,Province,Country,PostCode)    
VALUES
(0,	'10001',	'Pablo Picasso',	'+34 636 17 63 82',	'Paseo de la Chopera, 14',	'Madrid',	'Madrid',	'España',	'28045'),
(1,	'20001',	'Abraham Lincoln',	'+1 305 907 7086',	'120 SW 8th St',	'Miami',	'Florida',	'Estados Unidos',	'33130'),
(2,	'30001',	'Napoléon Bonaparte',	'+33 1 79 75 40 00',	'40 Rue du Colisée',	'París',	'Île-de-France',	'Francia',	'75008');

-- Comprobación
--SELECT * FROM Customer;



INSERT INTO Salesman
VALUES
(0,	'00001',	'Petey Cruiser',	'Madrid'),
(1,	'00002',	'Anna Sthesia',	'Barcelona'),
(2,	'00003',	'Paul Molive',	'Berlín'),
(3,	'00004',	'Gail Forcewind',	'París'),
(4,	'00005',	'Paige Turner',	'Mimia'),
(5,	'00006',	'Bob Frapples',	'Ciudad de México'),
(6,	'00007',	'Walter Melon',	'Ámsterdam'),
(7,	'00008',	'Shonda Leer',	'São Paulo');

-- Comprobación
--SELECT * FROM Salesman;



INSERT INTO Invoice
VALUES
(0,	'852399038',	'2018-08-22',	0,	1,	3),
(1,	'731166526',	'2018-12-31',	3,	0,	5),
(2,	'271135104',	'2019-01-22',	2,	2,	7);

-- Comprobación
--SELECT * FROM Invoice;

