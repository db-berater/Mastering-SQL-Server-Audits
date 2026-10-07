/*
	============================================================================
	File:		03 - Server Audit - read the log.sql

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
USE master;
GO

SET NOCOUNT ON;
SET XACT_ABORT ON;
SET NOEXEC OFF;
GO

DROP TABLE IF EXISTS #auditinfo;
GO

DECLARE	@file_name NVARCHAR(256);

SELECT	@file_name = log_file_path + REPLACE(log_file_name, N'.sqlaudit', N'*.sqlaudit')
FROM		sys.server_file_audits
WHERE	name = N'dbo.customers.activity';

IF @file_name IS NULL
BEGIN
    RAISERROR ('No audit with the name [dbo.customers.activity] detected...', 0, 1) WITH NOWAIT;
    SET NOEXEC ON;
END

/*
    Now we store the result into a temporary table because
    joining the dmf can take a long time!
*/
SELECT	*
INTO    #auditinfo
FROM		sys.fn_get_audit_file
(
    @file_name,
    DEFAULT,
    DEFAULT
) AS gaf

SELECT	gaf.event_time,
        gaf.action_id,
        aa.name,
        aa.class_desc,
        gaf.succeeded,
        gaf.session_id,
        gaf.server_principal_name,
        gaf.server_instance_name,
        gaf.client_ip,
        gaf.application_name,
        gaf.duration_milliseconds,
        gaf.host_name,
		gaf.statement
FROM		#auditinfo AS gaf
		LEFT JOIN
		(
			SELECT	action_id,
					name,
					class_desc
			FROM		sys.dm_audit_actions
			WHERE	class_desc = N'OBJECT'
					OR class_desc = N'SERVER AUDIT'
		) AS aa
        ON (gaf.action_id = aa.action_id)
ORDER BY
        event_time DESC;
GO