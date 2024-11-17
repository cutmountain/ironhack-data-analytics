-- ==============================================================
-- Ironhack Delivery project
-- ==============================================================

-- ==============================================================
-- Ejercicio #1: KPIs
-- ==============================================================
-- 1.Tiempo de espera entre pedido y entrega
-- 2.Porcentaje de pedidos completados (no cancelados)
-- 3.Frecuencia de uso del servicio

-- ==============================================================
-- Ejercicio #2: SQL
-- ==============================================================
-- Crear base de datos
CREATE DATABASE ironhack_delivery;
USE ironhack_delivery;

-- Importar datos
-- Problema para importar customer_courier_chat_messages con Table Data Import Wizard debido a mi versión de MySQLWorkbench y el formato de fecha en el fichero
-- 19/08/2019 08:03 debe convertirse a 2019-08-19 08:03:00 para que MySQLWorkbench reconozca bien la fecha. He realizado la conversión con RegEx de VSCode
-- Alternativamente, podíamos haber importado el campo tal cual (como text) y haberlo tratado con DateTimeFormatStrings.

-- Crear tabla
DROP TABLE IF EXISTS customer_courier_conversations;
CREATE TABLE customer_courier_conversations AS
WITH cte_final AS (
	WITH cte_all AS (
		WITH 
			cte_courier AS (
			SELECT 
			   order_id AS id1,
			   MIN(message_sent_time) OVER(PARTITION BY order_id) AS time_courier_first_message,
			   COUNT(*) OVER(PARTITION BY order_id) AS num_mensajes_courier
			FROM customer_courier_chat_messages WHERE sender_app_type LIKE 'Courier%'),
			cte_customer AS (    
			SELECT 
			   order_id AS id2,
			   MIN(message_sent_time) OVER(PARTITION BY order_id) AS time_customer_first_message,
			   COUNT(*) OVER(PARTITION BY order_id) AS num_mensajes_customer    
			   FROM customer_courier_chat_messages WHERE sender_app_type LIKE 'Customer%'),
			cte_ambos AS (
			SELECT 
			   order_id AS id3,
			   FIRST_VALUE(sender_app_type) OVER(PARTITION BY order_id ORDER BY message_sent_time) AS first_sender,
			   MIN(message_sent_time) OVER(PARTITION BY order_id) AS time_first_message,
			   LAG(message_sent_time) OVER (PARTITION BY order_id ORDER BY message_sent_time) AS time_second_message,
			   MAX(message_sent_time) OVER(PARTITION BY order_id) AS time_last_message,
			   FIRST_VALUE(order_stage) OVER(PARTITION BY order_id ORDER BY message_sent_time DESC) AS order_stage
			FROM customer_courier_chat_messages)
		SELECT *
			FROM cte_courier m LEFT JOIN cte_customer c ON (m.id1=c.id2) LEFT JOIN cte_ambos b ON (m.id1=b.id3)         
		UNION
		SELECT *
			FROM cte_courier m RIGHT JOIN cte_customer c ON m.id1=c.id2 RIGHT JOIN cte_ambos b ON (m.id1=b.id3))  
	SELECT 
		o.order_id,
		o.city_code,
		time_courier_first_message,
		time_customer_first_message,
		num_mensajes_courier,
		num_mensajes_customer,
		first_sender,
		time_first_message,
		TIMESTAMPDIFF(SECOND, time_first_message, time_second_message) AS time_first_answer,
		time_last_message,
		order_stage,
		ROW_NUMBER() OVER(PARTITION BY o.order_id) as num_fila
		FROM cte_all INNER JOIN orders o ON (cte_all.id1=o.order_id))        
SELECT 
	order_id, 
    city_code, 
	time_courier_first_message,
	time_customer_first_message,
	num_mensajes_courier,
	num_mensajes_customer,
	first_sender,
	time_first_message,
	time_first_answer,
	time_last_message,
	order_stage 
 FROM cte_final
  WHERE num_fila=1;    
  
SELECT * FROM customer_courier_conversations;  
    




