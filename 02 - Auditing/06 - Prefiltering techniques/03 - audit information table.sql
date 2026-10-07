/*
	============================================================================
	File:		03 - audit information table.sql

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

DROP TABLE IF EXISTS dbo.privileged_access;
GO

CREATE TABLE dbo.privileged_access
(
	event_time							DATETIME2(7) NOT NULL,
	sequence_number						INT NOT NULL,
	action_id							VARCHAR(4) NULL,
	succeeded							BIT NOT NULL,
	permission_bitmask					VARBINARY(16) NOT NULL,
	is_column_permission					BIT NOT NULL,
	session_id							SMALLINT NOT NULL,
	server_principal_id					INT NOT NULL,
	database_principal_id				INT NOT NULL,
	target_server_principal_id			INT NOT NULL,
	target_database_principal_id			INT NOT NULL,
	object_id							INT NOT NULL,
	class_type							VARCHAR(2) NULL,
	session_server_principal_name		varchar(4000) NULL,
	server_principal_name				NVARCHAR(4000) NULL,
	server_principal_sid					VARBINARY(85) NULL,
	database_principal_name				NVARCHAR(128) NULL,
	target_server_principal_name			NVARCHAR(128) NULL,
	target_server_principal_sid			VARBINARY(85) NULL,
	target_database_principal_name		NVARCHAR(128) NULL,
	server_instance_name					NVARCHAR(128) NULL,
	database_name						NVARCHAR(128) NULL,
	schema_name							NVARCHAR(128) NULL,
	object_name							NVARCHAR(128) NULL,
	statement							NVARCHAR(4000) NULL,
	additional_information				NVARCHAR(4000) NULL,
	file_name							NVARCHAR(260) NOT NULL,
	audit_file_offset					BIGINT NOT NULL,
	user_defined_event_id				SMALLINT NOT NULL,
	user_defined_information				NVARCHAR(4000) NULL,
	audit_schema_version					INT NOT NULL,
	sequence_group_id					VARBINARY(85) NULL,
	transaction_id						BIGINT NOT NULL,
	client_ip							NVARCHAR(128) NULL,
	application_name						NVARCHAR(128) NULL,
	duration_milliseconds				BIGINT NOT NULL,
	response_rows						BIGINT NOT NULL,
	affected_rows						BIGINT NOT NULL,
	connection_id						UNIQUEIDENTIFIER NULL,
	data_sensitivity_information			NVARCHAR(4000) NULL,
	host_name							NVARCHAR(128) NULL,
	session_context						NVARCHAR(4000) NULL,
	client_tls_version					BIGINT NOT NULL,
	client_tls_version_name				NVARCHAR(128) NULL,
	database_transaction_id				BIGINT NOT NULL,
	ledger_start_sequence_number			BIGINT NOT NULL,
	external_policy_permissions_checked	NVARCHAR(4000) NULL,
	obo_middle_tier_app_id				NVARCHAR(128) NULL,
	is_local_secondary_replica			BIT NOT NULL
);
GO

CREATE CLUSTERED COLUMNSTORE INDEX cci_privileged_access
ON dbo.privileged_access;
GO

CREATE NONCLUSTERED INDEX nix_privileged_access_event_time
ON dbo.privileged_access (event_time)
WITH
(
	DATA_COMPRESSION = PAGE,
	SORT_IN_TEMPDB = ON
);
GO