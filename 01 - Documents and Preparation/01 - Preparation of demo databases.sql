/*
	============================================================================
	File:		01 - Preparation of demo databases.sql

	Summary:	This script restores the database ERP_Demo from
				the backup medium for distribution of data.
				
				THIS SCRIPT IS PART OF THE TRACK:
					Session - Introduction to Partitioning

	Date:		October 2024
	Revion:		November 2024

	SQL Server Version: >= 2016
	============================================================================
*/
USE master;
GO

/*
	Make sure you've executed the script 00 - dbo.sp_restore_erp_demo.sql
	before you run this code!
*/
EXEC dbo.sp_restore_ERP_demo @query_store = 1;
GO

/* reset the sql server default settings for the demos */
EXEC ERP_Demo.dbo.sp_set_sql_server_defaults;
GO

SELECT * FROM ERP_Demo.dbo.get_database_help_info();
SELECT * FROM ERP_Demo.dbo.get_object_help_info(NULL);
GO

/*
	In the last step we create a small table with all
	single available years in the dbo.orders table!
*/
BEGIN
	DROP TABLE IF EXISTS ERP_Demo.dbo.available_years;

	CREATE TABLE ERP_Demo.dbo.available_years
	(
		order_year	DATE	NOT NULL	PRIMARY KEY CLUSTERED
	);

	;WITH l
	AS
	(
		SELECT	DISTINCT
				DATEPART(YEAR, o_orderdate)	AS	order_year
		FROM	ERP_Demo.dbo.orders
	)
	INSERT INTO ERP_Demo.dbo.available_years(order_year)
	SELECT	DATEFROMPARTS(l.order_year, 1, 1)
	FROM	l;
END
GO

SELECT	*
FROM	ERP_Demo.dbo.available_years;
GO
