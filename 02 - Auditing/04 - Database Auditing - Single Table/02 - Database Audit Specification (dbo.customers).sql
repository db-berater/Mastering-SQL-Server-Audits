/*
	============================================================================
	File:		02 - Database Audit Specification (object access).sql

	Summary:	This script creates the Database Level Audit Specification
				to track all information from the Server Audit Specification
				into the predefined files in the prepared directory!
				
				THIS SCRIPT IS PART OF THE TRACK:
					Session - Mastering SQL Server Audit

	Date:		September 2026
	Revion:		September 2026

	SQL Server Version: >= 2017
	============================================================================
*/
USE [master]
GO

IF NOT EXISTS
(
	SELECT	*
	FROM		sys.server_audits
	WHERE	name = N'dbo.customers.activity'
)
	RAISERROR ('Server Audit [dbo.customers.activity] does not exist...', 0, 1) WITH NOWAIT;
GO

USE ERP_Demo;
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

BEGIN
	CREATE DATABASE AUDIT SPECIFICATION [dbo.customers]
	FOR SERVER AUDIT [dbo.customers.activity]
		ADD (INSERT ON OBJECT::[dbo].[customers] BY [public]),
		ADD (UPDATE ON OBJECT::[dbo].[customers] BY [public]),
		ADD (DELETE ON OBJECT::[dbo].[customers] BY [public])

	ALTER DATABASE AUDIT SPECIFICATION [dbo.customers] WITH (STATE = ON);
END
GO