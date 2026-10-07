/*
	============================================================================
	File:		04 - clean the environment.sql

	Summary:	This script removes all audit configurations from the demo!
				
				THIS SCRIPT IS PART OF THE TRACK:
					Session - Mastering SQL Server Audit

	Date:		September 2026
	Revion:		September 2026

	SQL Server Version: >= 2017
	============================================================================
*/
USE [master]
GO

/*
	If the Server Audit definition already exists we drop it!
*/
IF EXISTS
(
	SELECT	*
	FROM	sys.server_audits
	WHERE	name = N'dbo.customers.activity'
)
BEGIN
	ALTER SERVER AUDIT [dbo.customers.activity] WITH (STATE = OFF);
	DROP SERVER AUDIT [dbo.customers.activity];
END
GO

USE [ERP_Demo]
GO

IF EXISTS
(
	SELECT	*
	FROM		sys.database_audit_specifications
	WHERE	name = N'dbo.customers'
)
BEGIN
	ALTER DATABASE AUDIT SPECIFICATION [dbo.customers] WITH (STATE = OFF);
	DROP DATABASE AUDIT SPECIFICATION [dbo.customers];
END
GO