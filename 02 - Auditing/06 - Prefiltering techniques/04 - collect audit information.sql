/*
	============================================================================
	File:		04 - collect audit information.sql

	Summary:		This script creates the infrastructure to collect all 
				audit information into a persistent table for the union.
				We make sure we only collect data from sysadmin accounts!
				
				THIS SCRIPT IS PART OF THE TRACK:
					Session - Mastering SQL Server Audit

	Date:		September 2026
	Revion:		September 2026

	SQL Server Version: >= 2017
	============================================================================
*/
USE MaintenanceDB;
GO

CREATE OR ALTER PROCEDURE dbo.collect_audit_information
AS
BEGIN
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

	/*
		Get the filename of the server audit and the last recorded time stamp
	*/
	DECLARE	@file_name			NVARCHAR(256);
	DECLARE	@last_time_stamp		DATETIME2(7);

	BEGIN
		SELECT	@file_name = log_file_path + REPLACE(log_file_name, N'.sqlaudit', N'*.sqlaudit')
		FROM		sys.server_file_audits
		WHERE	name = N'track sysadmin access';

		SELECT	@last_time_stamp = ISNULL(MAX(event_time), '1900-01-01 00:00:00.000')
		FROM		dbo.privileged_access;
	END

	/*
		Now we can collect the information from the audit file(s)
	*/
	BEGIN
		DROP TABLE IF EXISTS #auditinfo;

		SELECT	*
		INTO    #auditinfo
		FROM	sys.fn_get_audit_file
		(
			@file_name,
			DEFAULT,
			DEFAULT
		) AS gaf
		WHERE	event_time >= @last_time_stamp;

		INSERT INTO dbo.privileged_access WITH (TABLOCK)
		SELECT	ai.event_time,
                ai.sequence_number,
                ai.action_id,
                ai.succeeded,
                ai.permission_bitmask,
                ai.is_column_permission,
                ai.session_id,
                ai.server_principal_id,
                ai.database_principal_id,
                ai.target_server_principal_id,
                ai.target_database_principal_id,
                ai.object_id,
                ai.class_type,
                ai.session_server_principal_name,
                ai.server_principal_name,
                ai.server_principal_sid,
                ai.database_principal_name,
                ai.target_server_principal_name,
                ai.target_server_principal_sid,
                ai.target_database_principal_name,
                ai.server_instance_name,
                ai.database_name,
                ai.schema_name,
                ai.object_name,
                ai.statement,
                ai.additional_information,
                ai.file_name,
                ai.audit_file_offset,
                ai.user_defined_event_id,
                ai.user_defined_information,
                ai.audit_schema_version,
                ai.sequence_group_id,
                ai.transaction_id,
                ai.client_ip,
                ai.application_name,
                ai.duration_milliseconds,
                ai.response_rows,
                ai.affected_rows,
                ai.connection_id,
                ai.data_sensitivity_information,
                ai.host_name,
                ai.session_context,
                ai.client_tls_version,
                ai.client_tls_version_name,
                ai.database_transaction_id,
                ai.ledger_start_sequence_number,
                ai.external_policy_permissions_checked,
                ai.obo_middle_tier_app_id,
                ai.is_local_secondary_replica
		FROM		#auditinfo AS ai
				INNER JOIN sys.server_principals AS sp
				ON (ai.server_principal_id = sp.principal_id)
		WHERE	IS_SRVROLEMEMBER('sysadmin', sp.name) = 1

		EXCEPT

		SELECT	event_time,
                sequence_number,
                action_id,
                succeeded,
                permission_bitmask,
                is_column_permission,
                session_id,
                server_principal_id,
                database_principal_id,
                target_server_principal_id,
                target_database_principal_id,
                object_id,
                class_type,
                session_server_principal_name,
                server_principal_name,
                server_principal_sid,
                database_principal_name,
                target_server_principal_name,
                target_server_principal_sid,
                target_database_principal_name,
                server_instance_name,
                database_name,
                schema_name,
                object_name,
                statement,
                additional_information,
                file_name,
                audit_file_offset,
                user_defined_event_id,
                user_defined_information,
                audit_schema_version,
                sequence_group_id,
                transaction_id,
                client_ip,
                application_name,
                duration_milliseconds,
                response_rows,
                affected_rows,
                connection_id,
                data_sensitivity_information,
                host_name,
                session_context,
                client_tls_version,
                client_tls_version_name,
                database_transaction_id,
                ledger_start_sequence_number,
                external_policy_permissions_checked,
                obo_middle_tier_app_id,
                is_local_secondary_replica
		FROM		dbo.privileged_access;
	END
END
GO