CREATE DATABASE ironhack_lab_mysql;
USE DATABASE ironhack_lab_mysql;

CREATE SCHEMA ironhack_class;
USE SCHEMA ironhack_lab_mysql.ironhack_class;

--NB. He tenido que modificar mi esquema inicial para adaptarlo al resto del ejercicio:
-- i) Añadiendo una columna autoincremento ID en todas las tablas.
-- ii) Cambiando algunos campos de INT a VARCHAR

CREATE TABLE Car (
    ID INT IDENTITY(0,1) NOT NULL,
    VIN VARCHAR(50) NOT NULL,
    Make VARCHAR(50) NOT NULL,
    Model VARCHAR(50) NOT NULL,
    LaunchYear INT NOT NULL,
    Color VARCHAR(50) NOT NULL
);
ALTER TABLE Car ADD PRIMARY KEY (ID);


CREATE TABLE Customer (
    ID INT IDENTITY(0,1) NOT NULL,
    ClientNr VARCHAR(50) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NULL,
    Address VARCHAR(255) NULL,
    City VARCHAR(50),
    Province VARCHAR(50),
    Country VARCHAR(50),
    PostCode VARCHAR(50),
    Store VARCHAR(100),
    PRIMARY KEY (ID)
);


CREATE TABLE Salesman (
    ID INT IDENTITY(0,1) NOT NULL,
    EmployeeNr VARCHAR(50) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Store VARCHAR(100) NOT NULL,
    PRIMARY KEY (ID)
);


--Suposición: Cada factura corresponde a la venta de 1 solo coche
CREATE TABLE Invoice (
    ID INT IDENTITY(0,1) NOT NULL,
    InvoiceNr VARCHAR(50) NOT NULL,
    InvoiceDate DATE NOT NULL,
    Car_ID INT NOT NULL,
    Customer_ID INT NOT NULL,
    Salesman_ID INT NOT NULL,
    PRIMARY KEY (ID),
    CONSTRAINT FK_Invoice_Car FOREIGN KEY (Car_ID) REFERENCES Car(ID),
    CONSTRAINT FK_Invoice_Customer FOREIGN KEY (Customer_ID) REFERENCES Customer(ID),
    CONSTRAINT FK_Invoice_Salesman FOREIGN KEY (Salesman_ID) REFERENCES Salesman(ID)
);
