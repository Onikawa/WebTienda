/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  onikawa
 * Created: 25 nov. 2021
 */


#prosedimentos
DELIMITER @@
DROP PROCEDURE IF EXISTS SP_Detalle @@
CREATE PROCEDURE SP_Detalle(fac CHAR(8), coda char(6),  can int)
BEGIN
insert into facdet values (fac,coda, can);
update producto set stock= stock -can where idproducto=coda;
END@@

DELIMITER @@
DROP PROCEDURE IF EXISTS SP_Factura @@
CREATE PROCEDURE SP_Factura(in codc char(8),in tot numeric(8,1))
BEGIN
declare nro int;
declare fac char(8);
select ifnull(max(nrofactura),0) + 1  from faccab into nro;
set fac = lpad(nro,8,'0');
insert into faccab values (fac,current_date(),codc,tot);
select fac;
END@@

DELIMITER @@
DROP PROCEDURE IF EXISTS SP_AdicionCliente @@
CREATE PROCEDURE SP_AdicionCliente (IN Nombres varchar(30) , IN Dni varchar(8), IN Email varchar(30) , IN PassWord char(8) )  BEGIN
DECLARE IDcli CHAR(8);
DECLARE NRO INT;
SELECT IFNULL(RIGHT(MAX(IdCliente),5),0)+1 INTO NRO from clientes ORDER BY IdCliente;
SET IDcli=CONCAT("CLI",LPAD(NRO,5,"0"));
INSERT INTO clientes VALUES(IDcli, Nombres, Dni, Email, PassWord);
SELECT IDcli;
END@@
DELIMITER ;

#INSERT INTO clientes VALUES(IDcli, Nombres, Dni, Email, MD5 (PassWord));
CALL SP_ADICIONCliente('Caslos peru ','8468369','prueba','123456');
select * from clientes;
select IdCliente,Nombres,Dni,Email,PassWord from clientes where Email="Prueba";
select IdCategoria,Idproducto,Descripcion,PrecioUnidad,Stock,Imagen from producto where IdCategoria='CAT01';
select * from faccab;
select * from producto where IdProducto='PRO01';
select * from faccab;
select * from facdet;
select * from clientes;
select * from producto;
select * from clientes;
select IdCategoria,Idproducto,Descripcion,PrecioUnidad,Stock,Imagen from producto where IdCategoria='CAT01';
select * from facdet,faccab;
select * from producto where IdProducto='PRO01';
select *from facdet s,clientes c,faccab f,producto a where c.IdCliente= f.IdCliente and a.Idproducto= s.IdArticulo and c.IdCliente='CLI00004';
select f.NroFactura,Descripcion,Cantidad,PrecioUnidad, sum(Cantidad*PrecioUnidad) as suma, f.MontoTotal from facdet s,clientes c,faccab f,producto a where c.IdCliente= f.IdCliente 
and a.Idproducto= s.IdArticulo and  f.NroFactura=s.NroFactura and f.NroFactura='00000004' group by Cantidad;
select f.NroFactura,Descripcion,Cantidad,PrecioUnidad,Nombres,Dni,FechaFactura from facdet s,clientes c,faccab f,producto a where c.IdCliente= f.IdCliente 
and a.Idproducto= s.IdArticulo and  f.NroFactura=s.NroFactura and f.NroFactura='00000004' group by Descripcion;