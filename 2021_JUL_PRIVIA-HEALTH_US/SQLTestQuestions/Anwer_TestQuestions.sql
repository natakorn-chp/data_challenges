USE PERSONDATABASE

/*********************
Hello! 

Please use the test data provided in the file 'PersonDatabase' to answer the following
questions. Please also import the dbo.Contacts flat file to a table for use. 

All answers should be executable on a MS SQL Server 2012 instance. 

***********************

QUESTION 1

The table dbo.Risk contains calculated risk scores for the population in dbo.Person. Write a 
query or group of queries that return the patient name, and their most recent risk level(s). 
Any patients that dont have a risk level should also be included in the results. 

**********************/
select PersonName
, RiskLevel
from (select ROW_NUMBER() OVER (
	PARTITION BY p.PersonName
	ORDER BY r.RiskDateTime desc) as row_num
, p.PersonName
, r.RiskLevel
from DBO.Person p
left join DBO.Risk r
on p.PersonID = r.PersonID ) f
where f.row_num = 1;


/**********************

QUESTION 2


The table dbo.Person contains basic demographic information. The source system users 
input nicknames as strings inside parenthesis. Write a query or group of queries to 
return the full name and nickname of each person. The nickname should contain only letters 
or be blank if no nickname exists.

**********************/

--- 1st answer
select PersonName
, SUBSTRING(nickName,2, LEN(nickName)) AS nickName
from (select  PersonName
, SUBSTRING(
	PersonName, CHARINDEX('(', PersonName), CHARINDEX(')', PersonName) - CHARINDEX('(', PersonName)
) AS nickName
from dbo.Person ) f


--- 2nd answer
select PersonName
, nickName
, case when nickName like '' then nickName
  else '' end as nickName
from (select  PersonName
, SUBSTRING(
	PersonName, CHARINDEX('(', PersonName)+1,  
	case when (CHARINDEX(')', PersonName)-1) - CHARINDEX('(', PersonName)<=0 then CHARINDEX(')', PersonName) - CHARINDEX('(', PersonName)
	else  (CHARINDEX(')', PersonName)-1) - CHARINDEX('(', PersonName) end
) AS nickName
from dbo.Person 
) f


/**********************

QUESTION 6

Write a query to return risk data for all patients, all payers 
and a moving average of risk for that patient and payer in dbo.Risk. 

**********************/
select p.PersonName,r.AttributedPayer, AVG(r.RiskScore) as avg_Rscore
from DBO.Person p
left join DBO.Risk r
on p.PersonID = r.PersonID
group by p.PersonName, r.AttributedPayer
order by p.PersonName;



