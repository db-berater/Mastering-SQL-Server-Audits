/*
	============================================================================
	File:		01 - Server Audit (Monitoring).sql

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
	WHERE	name = N'Instance Change Monitoring'
)
BEGIN
	RAISERROR ('No Server Audit [Instance Change Monitoring] has been created.', 0, 1) WITH NOWAIT;
	SET NOEXEC ON;
END
GO

SET NOEXEC OFF;
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

BEGIN
	CREATE SERVER AUDIT SPECIFICATION [Instance Configuration Changes to SQL Server]
	FOR SERVER AUDIT [Instance Change Monitoring]
	ADD (SERVER_OPERATION_GROUP),
    ADD (SERVER_PERMISSION_CHANGE_GROUP),
    ADD (SERVER_STATE_CHANGE_GROUP),
	ADD (SERVER_OBJECT_CHANGE_GROUP);

	ALTER SERVER AUDIT SPECIFICATION [Instance Configuration Changes to SQL Server] WITH (STATE = ON);
END
GO

