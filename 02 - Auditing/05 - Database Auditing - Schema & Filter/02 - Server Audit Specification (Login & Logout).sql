/*
	============================================================================
	File:		01 - Server Audit (Login & Logout).sql

	Summary:	This script creates the Server Level Audit to route all
				information from the Server Audit Specification into the
				predefined files in the prepared directory!
				
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
	WHERE	name = N'filtered objects '
)
	RAISERROR ('Server Audit [filtered objects] does not exist...', 0, 1) WITH NOWAIT;
GO

USE ERP_Demo;
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

BEGIN
	CREATE DATABASE AUDIT SPECIFICATION [trace DML operations]
	FOR SERVER AUDIT [filtered objects]
		ADD (UPDATE ON SCHEMA::[dbo] BY [public]),
		ADD (INSERT ON SCHEMA::[dbo] BY [public]),
		ADD (DELETE ON SCHEMA::[dbo] BY [public])

	ALTER DATABASE AUDIT SPECIFICATION [trace DML operations] WITH (STATE = ON);
END
GO