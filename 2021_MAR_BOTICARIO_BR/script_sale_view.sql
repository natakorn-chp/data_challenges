
-------------- a. Table1: Consolidated sales by year and month.
create view dev_view.sale_month_year(
	sum_qtd_venda,
	venda_month,
	venda_year
) as select sum(qtd_venda) as sum_qtd_venda
, extract('month' from data_venda) as month
, extract('year' from data_venda) as year
from dev_pst.sale_info
group by extract('month' from data_venda), extract('year' from data_venda);

-------------- b. Table2: Consolidated sales by brand and line.
create view dev_view.sale_linha_marca(
	sum_qtd_venda,
	linha,
	marca
) as select sum(qtd_venda) as sum_qtd_venda
, linha
, marca
from dev_pst.sale_info
group by linha, marca;

-------------- c. Table3: Consolidated sales by brand, year and month.
create view dev_view.sale_marca_month_year(
	sum_qtd_venda,
	marca,
	venda_month,
	venda_year
) as select sum(qtd_venda) as sum_qtd_venda
, marca
, extract('month' from data_venda) as month
, extract('year' from data_venda) as year
from dev_pst.sale_info
group by marca, extract('month' from data_venda), extract('year' from data_venda);


-------------- d. Table4: Consolidated sales by line, year and month.
create view dev_view.sale_linha_month_year(
	sum_qtd_venda,
	linha,
	venda_month,
	venda_year
) as select sum(qtd_venda) as sum_qtd_venda
, linha
, extract('month' from data_venda) as month
, extract('year' from data_venda) as year
from dev_pst.sale_info
group by linha, extract('month' from data_venda), extract('year' from data_venda);
