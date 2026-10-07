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
	WHERE	name = N'filtered objects'
)
BEGIN
	ALTER SERVER AUDIT [filtered objects] WITH (STATE = OFF);
	DROP SERVER AUDIT [filtered objects];
END
GO

USE ERP_Demo
GO

IF EXISTS
(
	SELECT	*
	FROM		sys.database_audit_specifications
	WHERE	name = N'trace DML operations'
)
BEGIN
	ALTER DATABASE AUDIT SPECIFICATION [trace DML operations] WITH (STATE = OFF);
	DROP DATABASE AUDIT SPECIFICATION [trace DML operations];
END
GO