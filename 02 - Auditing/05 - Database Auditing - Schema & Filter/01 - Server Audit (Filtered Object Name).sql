/*
	============================================================================
	File:		01 - Server Audit (Filtered Object Name).sql

	Summary:	This script creates the Database Level Audit to route all
				information from the Server Audit Specification into the
				predefined files in the prepared directory!
				
	Date:		September 2026
	Revion:		September 2026

	SQL Server Version: >= 2017
	============================================================================
*/
USE [master]
GO

IF EXISTS
(
	SELECT	*
	FROM		sys.server_audits
	WHERE	name = N'filtered objects'
)
BEGIN
	ALTER SERVER AUDIT [filtered objects] WITH (STATE = OFF);
	DROP SERVER AUDIT [filtered objects];
END
GO

CREATE SERVER AUDIT [filtered objects]
TO FILE
(
    FILEPATH = 'T:\Auditing\Database Audits\SQL_2025\ERP_Demo',
    MAXSIZE = 100 MB,
    MAX_FILES = 5
)
WITH
(
    QUEUE_DELAY = 1000,
    ON_FAILURE = CONTINUE
	/*
		These options are only available for
		- SQL Server Managed Instance
		- Azure SQL Database

		RETENTION_DAYS = 10,
		OPERATOR_AUDIT = N'xxx'
	*/
)
WHERE
(
	[object_name] = N'customers'
	OR [object_name] = N'orders'
	OR [object_name] = N'nations'
);
GO

/*
	And start it for recording purposes!
*/
ALTER SERVER AUDIT [filtered objects] WITH (STATE = ON);
GO