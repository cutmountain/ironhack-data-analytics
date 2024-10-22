-- Crear BDD
CREATE DATABASE ironhack_gambling;

-- Usar BDD
USE ironhack_gambling;

-- Definición de tabla Account
DROP TABLE Account;
CREATE TABLE Account (
    AccountNo VARCHAR(10) NOT NULL,
    CustId INT NOT NULL,
	AccountLocation	VARCHAR(3) NOT NULL,
    CurrencyCode VARCHAR(3) NOT NULL,
    DailyDepositLimit DECIMAL(10) NOT NULL,
	StakeScale DECIMAL(5,2) NOT NULL,
	SourceProd VARCHAR(3) NOT NULL,
    PRIMARY KEY (AccountNo)
);
SELECT * FROM Account;

-- Definición de tabla Customer
DROP TABLE Customer;
CREATE TABLE Customer (
    CustId INT NOT NULL,
	AccountLocation	VARCHAR(3) NOT NULL,
    Title VARCHAR(5) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    CreateDate DATE NOT NULL,
    CountryCode VARCHAR(2) NOT NULL,
    Language VARCHAR(2) NOT NULL,
    Status VARCHAR(1) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Contact VARCHAR(1) NOT NULL,
    CustomerGroup VARCHAR(10) NOT NULL,
    PRIMARY KEY (CustId)
);
SELECT * FROM Customer;

-- Definición de tabla Betting
DROP TABLE Betting;
CREATE TABLE Betting (
	AccountNo VARCHAR(10) NOT NULL,
	BetDate DATE NOT NULL,
	ClassId VARCHAR(50) NOT NULL,
	CategoryId INT NOT NULL,
	Source VARCHAR(1) NOT NULL,
	BetCount INT NOT NULL,
	Bet_Amt	DECIMAL(10,2) NOT NULL,
    Win_Amt	DECIMAL(10,2) NOT NULL,
    Product VARCHAR(20) NOT NULL
);
SELECT * FROM Betting;

-- Definición de tabla Product
DROP TABLE Product;
CREATE TABLE Product (
	CLASSID	VARCHAR(50) NOT NULL,
    CATEGORYID	INT NOT NULL,
    product	VARCHAR(50) NOT NULL,
    sub_product	VARCHAR(50) NOT NULL,
    description	VARCHAR(50) NOT NULL,
    bet_or_play TINYINT NOT NULL
);
SELECT * FROM Product;

-- Mostrar tablas
SHOW TABLES;

-- Pregunta 01: Usando la tabla o pestaña de clientes, por favor escribe una consulta SQL que muestre Título, Nombre y Apellido y Fecha de Nacimiento para cada uno de los clientes. No necesitarás hacer nada en Excel para esta.
SELECT Title, FirstName, LastName, DateOfBirth
 FROM Customer;

-- Pregunta 02: Usando la tabla o pestaña de clientes, por favor escribe una consulta SQL que muestre el número de clientes en cada grupo de clientes (Bronce, Plata y Oro). Puedo ver visualmente que hay 4 Bronce, 3 Plata y 3 Oro pero si hubiera un millón de clientes ¿cómo lo haría en Excel?
SELECT CustomerGroup, COUNT(*) AS Num_Customers
 FROM Customer 
  GROUP BY CustomerGroup;
  
-- Pregunta 03: El gerente de CRM me ha pedido que proporcione una lista completa de todos los datos para esos clientes en la tabla de clientes pero necesito añadir el código de moneda de cada jugador para que pueda enviar la oferta correcta en la moneda correcta. Nota que el código de moneda no existe en la tabla de clientes sino en la tabla de cuentas. Por favor, escribe el SQL que facilitaría esto. ¿Cómo lo haría en Excel si tuviera un conjunto de datos mucho más grande?
SELECT c.*, a.CurrencyCode
 FROM Customer c INNER JOIN Account a ON (c.CustId = a.CustId);
 
-- Pregunta 04: Ahora necesito proporcionar a un gerente de producto un informe resumen que muestre, por producto y por día, cuánto dinero se ha apostado en un producto particular. TEN EN CUENTA que las transacciones están almacenadas en la tabla de apuestas y hay un código de producto en esa tabla que se requiere buscar (classid & categoryid) para determinar a qué familia de productos pertenece esto. Por favor, escribe el SQL que proporcionaría el informe. Si imaginas que esto fue un conjunto de datos mucho más grande en Excel, ¿cómo proporcionarías este informe en Excel? 
SELECT p.Product, b.BetDate, SUM(b.Bet_Amt) AS Daily_Amount
 FROM Product p
  INNER JOIN Betting b ON (b.ClassId=p.ClassId AND b.CategoryId=p.CategoryId)
  GROUP BY p.Product, b.BetDate
   ORDER BY p.Product, b.BetDate; 

-- Pregunta 05: Acabas de proporcionar el informe de la pregunta 4 al gerente de producto, ahora él me ha enviado un correo electrónico y quiere que se cambie. ¿Puedes por favor modificar el informe resumen para que solo resuma las transacciones que ocurrieron el 1 de noviembre o después y solo quiere ver transacciones de Sportsbook. Nuevamente, por favor escribe el SQL abajo que hará esto. Si yo estuviera entregando esto vía Excel, ¿cómo lo haría?
SELECT p.Product, b.BetDate, SUM(b.Bet_Amt) AS Daily_Amount
 FROM Product p
  INNER JOIN Betting b ON (b.ClassId=p.ClassId AND b.CategoryId=p.CategoryId AND b.BetDate >= '2012-11-01' AND p.Product='Sportsbook')
  GROUP BY p.Product, b.BetDate
   ORDER BY p.Product, b.BetDate; 
   
-- Pregunta 06: Como suele suceder, el gerente de producto ha mostrado su nuevo informe a su director y ahora él también quiere una versión diferente de este informe. Esta vez, quiere todos los productos pero divididos por el código de moneda y el grupo de clientes del cliente, en lugar de por día y producto. También le gustaría solo transacciones que ocurrieron después del 1 de diciembre. Por favor, escribe el código SQL que hará esto.   
SELECT a.CurrencyCode, c.CustomerGroup, p.Product, SUM(b.Bet_Amt) AS Daily_Amount
 FROM Product p
  INNER JOIN Betting b ON (b.ClassId=p.ClassId AND b.CategoryId=p.CategoryId AND b.BetDate > '2012-12-01')
  INNER JOIN Account a ON (b.AccountNo=a.AccountNo)
  INNER JOIN Customer c ON (c.CustId=a.CustId)
  GROUP BY a.CurrencyCode, c.CustomerGroup, p.Product
   ORDER BY a.CurrencyCode, c.CustomerGroup, p.Product; 

-- Pregunta 07: Nuestro equipo VIP ha pedido ver un informe de todos los jugadores independientemente de si han hecho algo en el marco de tiempo completo o no. En nuestro ejemplo, es posible que no todos los jugadores hayan estado activos. Por favor, escribe una consulta SQL que muestre a todos los jugadores Título, Nombre y Apellido y un resumen de su cantidad de apuesta para el período completo de noviembre.
WITH cte_bet_cust AS(
 SELECT b.*,a.CustId
  FROM Betting b INNER JOIN Account a ON (b.AccountNo=a.AccountNo)
)
SELECT c.Title, c.FirstName, c.LastName, SUM(cte.Bet_Amt) AS Total_Amount
 FROM Customer c
  LEFT JOIN cte_bet_cust cte ON (c.CustId=cte.CustId AND cte.BetDate BETWEEN '2012-11-01' AND '2012-11-30')
  GROUP BY c.Title, c.FirstName, c.LastName
   ORDER BY Total_Amount DESC;

-- Pregunta 08: Nuestros equipos de marketing y CRM quieren medir el número de jugadores que juegan más de un producto. 
-- ¿Puedes por favor escribir 2 consultas, una que muestre el número de productos por jugador 
-- y otra que muestre jugadores que juegan tanto en Sportsbook como en Vegas?   
SELECT c.Title, c.FirstName, c.LastName, COUNT(DISTINCT b.Product) AS ProductCount
FROM Customer c
	INNER JOIN Account a ON (c.CustId = a.CustId)
	INNER JOIN Betting b ON (a.AccountNo = b.AccountNo)
GROUP BY c.Title, c.FirstName, c.LastName
-- HAVING ProductCount > 1
ORDER BY ProductCount DESC;

SELECT DISTINCT c.Title, c.FirstName, c.LastName
FROM Customer c
 INNER JOIN Account a ON (c.CustId = a.CustId)
 INNER JOIN Betting b ON (a.AccountNo = b.AccountNo AND b.Product IN ('Sportsbook','Vegas'))
ORDER BY c.LastName, c.FirstName;

-- Pregunta 09: Ahora nuestro equipo de CRM quiere ver a los jugadores que solo juegan un producto, 
-- por favor escribe código SQL que muestre a los jugadores que solo juegan en sportsbook, usa bet_amt > 0 como la clave. 
-- Muestra cada jugador y la suma de sus apuestas para ambos productos.    
DROP VIEW bets_by_product;
CREATE VIEW bets_by_product AS 
 SELECT
	a.CustId,
	p.Product,
    b.Bet_Amt,
    SUM(b.Bet_Amt) OVER(PARTITION BY a.CustId,p.Product) AS Total_by_Product
    -- COUNT(p.Product) OVER(PARTITION BY a.CustId) AS Num_Productos
    -- SUM(b.Bet_Amt) OVER(PARTITION BY a.CustId,p.Product) As Total_by_product
  FROM Betting b 
	INNER JOIN Account a ON (b.AccountNo=a.AccountNo)
    INNER JOIN Product p ON (b.ClassId=p.ClassId AND b.CategoryId=p.CategoryId)    
    WHERE b.Bet_Amt>0
    ORDER BY a.CustId,p.Product;
SELECT * 
 FROM bets_by_product;

DROP VIEW bets_total;
CREATE VIEW bets_total AS 
	SELECT
		CustId, Product, MIN(Total_by_Product) AS Total_Amt
	 FROM bets_by_product
      GROUP BY CustId, Product;
SELECT * 
 FROM bets_total;      

WITH cte_bets_prods AS(
	SELECT *,
	 COUNT(Product) OVER(PARTITION BY CustId) AS cuantos_productos
	FROM bets_total
)
SELECT c.Title,c.FirstName,c.LastName,b.Total_Amt
 FROM Customer c
  INNER JOIN cte_bets_prods b ON (c.CustId=b.CustId)
    WHERE cuantos_productos=1 AND Product='Sportsbook';

-- Pregunta 10: La última pregunta requiere que calculemos y determinemos el producto favorito de un jugador. 
-- Esto se puede determinar por la mayor cantidad de dinero apostado. Por favor, escribe una consulta que muestre el producto favorito de cada jugador
WITH cte_bet_cust_prod AS(
 SELECT a.CustId,p.Product,
  SUM(b.Bet_Amt) As Total_by_product,
  MAX(SUM(b.Bet_Amt)) OVER(PARTITION BY a.CustId) AS Maximo_Gastado
  FROM Betting b 
	INNER JOIN Account a ON (b.AccountNo=a.AccountNo)
    INNER JOIN Product p ON (b.ClassId=p.ClassId AND b.CategoryId=p.CategoryId)    
    WHERE b.Bet_Amt>0
    GROUP BY a.CustId,p.Product
)
SELECT c.Title, c.FirstName, c.LastName, cte.Product
 FROM Customer c
  INNER JOIN cte_bet_cust_prod cte ON (c.CustId=cte.CustId)
   WHERE cte.Total_by_product=cte.Maximo_Gastado;   
   
   
-- -------------------------------------------------------------------------------   
-- -------------------------------------------------------------------------------   
-- -------------------------------------------------------------------------------   
-- Definición de tabla Student
DROP TABLE Student;
CREATE TABLE Student (
	student_id INT NOT NULL,
    student_name VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    school_id INT NOT NULL,
	GPA DECIMAL(5,2) NOT NULL    
);
SELECT * FROM Student;

-- Definición de tabla School
DROP TABLE School;
CREATE TABLE School (
	school_id INT NOT NULL,
    school_name	VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL
);
SELECT * FROM School;

-- Pregunta 11: Escribe una consulta que devuelva a los 5 mejores estudiantes basándose en el GPA
SELECT *
 FROM Student
  ORDER BY GPA DESC
   LIMIT 5;

-- Pregunta 12: Escribe una consulta que devuelva el número de estudiantes en cada escuela. (¡una escuela debería estar en la salida incluso si no tiene estudiantes!)
SELECT s.school_id, s.school_name, COUNT(st.student_id) AS Number_Students
	FROM School s
		LEFT JOIN Student st ON (s.school_id = st.school_id)
	GROUP BY s.school_id, s.school_name;

-- Pregunta 13: Escribe una consulta que devuelva los nombres de los 3 estudiantes con el GPA más alto de cada universidad. 
WITH RankedStudent AS (
	SELECT
			sch.school_name,
			s.student_name,
			s.GPA,
            RANK() OVER(PARTITION BY sch.school_name ORDER BY s.GPA DESC) AS student_rank
	FROM student s
    INNER JOIN school sch ON (sch.school_id = s.school_id)
     ORDER BY sch.school_name
)
SELECT school_name, student_name, GPA, student_rank
	FROM RankedStudent
		WHERE student_rank <= 3
		ORDER BY school_name, student_rank;  
   
   