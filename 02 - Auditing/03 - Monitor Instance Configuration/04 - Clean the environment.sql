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
	WHERE	name = N'Instance Change Monitoring'
)
BEGIN
	ALTER SERVER AUDIT [Instance Change Monitoring] WITH (STATE = OFF);
	DROP SERVER AUDIT [Instance Change Monitoring];
END
GO

USE [master]
GO

IF EXISTS
(
	SELECT	*
	FROM	sys.server_audit_specifications
	WHERE	name = N'Instance Configuration Changes to SQL Server'
)
BEGIN
	ALTER SERVER AUDIT SPECIFICATION [Instance Configuration Changes to SQL Server] WITH (STATE = OFF);
	DROP SERVER AUDIT SPECIFICATION [Instance Configuration Changes to SQL Server];
END
GO