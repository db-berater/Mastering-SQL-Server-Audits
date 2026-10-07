/*
	============================================================================
	File:		01 - Server Audit (Failed Logins).sql

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

/*
	If the Server Audit definition already exists we drop it!
*/
IF EXISTS
(
	SELECT	*
	FROM	sys.server_audits
	WHERE	name = N'Failed Logins'
)
BEGIN
	ALTER SERVER AUDIT [Failed Logins] WITH (STATE = OFF);
	DROP SERVER AUDIT [Failed Logins];
END
GO

/*
	Now we can create the new Server Audit Definition!
*/
CREATE SERVER AUDIT [Failed Logins]
TO FILE 
(
	FILEPATH = N'T:\Auditing\Server Audits\NB-LENOVO-I\SQL_2025',
	MAXSIZE = 100 MB,
	MAX_FILES = 10,
	RESERVE_DISK_SPACE = OFF
)
WITH
(
	QUEUE_DELAY = 1000,
	ON_FAILURE = CONTINUE
);
GO

/*
	And start it for recording purposes!
*/
ALTER SERVER AUDIT [Failed Logins] WITH (STATE = ON);
GO
