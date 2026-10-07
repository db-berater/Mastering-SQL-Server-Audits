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
	WHERE	name = N'Login & Logout'
)
BEGIN
	ALTER SERVER AUDIT [Login & Logout] WITH (STATE = OFF);
	DROP SERVER AUDIT [Login & Logout];
END
GO

USE [master]
GO

IF EXISTS
(
	SELECT	*
	FROM	sys.server_audit_specifications
	WHERE	name = N'Login and Logout to SQL Server'
)
BEGIN
	ALTER SERVER AUDIT SPECIFICATION [Login and Logout to SQL Server] WITH (STATE = OFF);
	DROP SERVER AUDIT SPECIFICATION [Login and Logout to SQL Server];
END
GO