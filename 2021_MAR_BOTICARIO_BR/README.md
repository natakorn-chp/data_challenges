Source: https://github.com/leivio/work-at-boticario/blob/main/Engenheiro%20de%20Dados.pdf

Country: Brazil

## English

=====================
# Data Engineer - Boticário Group Practice Test

Along with this description, you are getting 3 files with random sales data from 2017 to 2019.
For the execution of this test, you can use the tools you are most familiar with, following only the following premises:
1. The data must necessarily be stored in database tables (MySQL, PostgreSQL, BigQuery, MS SQL, Oracle etc) and not in files or spreadsheets.
2. You must necessarily use SQL and Python in the processes of loading, querying and transforming data.
3. Use a tool that allows you to create ETL processes or DAG's for data ingestion and transformation.
4. You must implement version control for your code.
Note Although you can use tools of your choice, we are structuring our data platform on Google's cloud, if you perform the implementations using GCP tools, we will be even happier!

## You'll need:

1. Import the data from the 3 files into a table created by you in the database of your choice.
2. With the imported data, model 4 new tables and implement processes to make the necessary transformations and insert the following views into the tables:

        a. Table1: Consolidated sales by year and month.
        b. Table2: Consolidated sales by brand and line.
        c. Table3: Consolidated sales by brand, year and month.
        d. Table4: Consolidated sales by line, year and month.
3. Create a common Twitter account.
4. Access https://developer.twitter.com/en/apply-for-access and create an account
of developer.
5. After creating the account, access the App menu and create an application. For testing purposes, the data need not be accurate. The URL, for example, can put http://localhost.com.
6. After creating the app, access it and generate the token and secret token.
7. Create a data capture process through the Twitter API, using the following parameters:

        a. Words to search for: “Boticário” and the name of the line with the most sales in month 12 of 2019 (according to item 2.d.).
        a. Retrieve the 50 most recent tweets.
        c. Retrieve only tweets that are in Portuguese.
8. Create a process that saves the usernames and text of retrieved tweets in a database table.

## What do we expect from you?

1. That you can complete all the steps above.
2. It generates a repository with all the scripts and makes it available for consultation.
3. That shows us all the processes running and the tables being loaded. We'll set up a virtual meeting so you can demonstrate.
4. Tell us how you organized yourself to carry out the tasks.
