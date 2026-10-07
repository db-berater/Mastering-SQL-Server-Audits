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

/*
	Now we can create the new Server Audit Definition!
*/
CREATE SERVER AUDIT [Login & Logout]
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

	/*
		These options are only available for
		- SQL Server Managed Instance
		- Azure SQL Database

		RETENTION_DAYS = 10,
		OPERATOR_AUDIT = N'xxx'
	*/
);
GO

/*
	And start it for recording purposes!
*/
ALTER SERVER AUDIT [Login & Logout] WITH (STATE = ON);
GO
