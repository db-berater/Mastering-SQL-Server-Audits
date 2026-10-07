/*
	============================================================================
	File:		02 - Database Audit Specification (Login & Logout).sql

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
	WHERE	name = N'track sysadmin access'
)
	RAISERROR ('Server Audit [track sysadmin access] does not exist...', 0, 1) WITH NOWAIT;
GO

USE ERP_Demo;
GO

IF EXISTS
(
	SELECT	*
	FROM		sys.database_audit_specifications
	WHERE	name = N'object access'
)
BEGIN
	ALTER DATABASE AUDIT SPECIFICATION [object access] WITH (STATE = OFF);
	DROP DATABASE AUDIT SPECIFICATION [object access];
END
GO

BEGIN
	CREATE DATABASE AUDIT SPECIFICATION [object access]
	FOR SERVER AUDIT [track sysadmin access]
		ADD (SELECT ON SCHEMA::[dbo] BY [public])

	ALTER DATABASE AUDIT SPECIFICATION [object access] WITH (STATE = ON);
END
GO