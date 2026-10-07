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
	FROM	sys.server_audits
	WHERE	name = N'Login & Logout'
)
BEGIN
	RAISERROR ('No Server Audit [Login & Logout] has been created.', 0, 1) WITH NOWAIT;
	SET NOEXEC ON;
END
GO

SET NOEXEC OFF;
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

BEGIN
	CREATE SERVER AUDIT SPECIFICATION [Login and Logout to SQL Server]
	FOR SERVER AUDIT [Login & Logout]
	ADD (SUCCESSFUL_LOGIN_GROUP),
	ADD (FAILED_LOGIN_GROUP),
	ADD (LOGOUT_GROUP);

	ALTER SERVER AUDIT SPECIFICATION [Login and Logout to SQL Server] WITH (STATE = ON);
END
GO

