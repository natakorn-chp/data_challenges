
----- raw table
create table if not exists dev_raw.sale_info(
	ID_MARCA varchar(10) not null,
	MARCA varchar(100) not null,
	ID_LINHA varchar(10) not null,
	LINHA varchar(100) not null,
	DATA_VENDA varchar(100) not null,
	QTD_VENDA varchar(5000) not null );



----- persist table
create table if not exists dev_pst.sale_info(
ID_MARCA int not null,
MARCA varchar(100) not null,
ID_LINHA int not null,
LINHA varchar(100) not null,
DATA_VENDA timestamp not null,
QTD_VENDA int not null );
