/*
	Execute the sqlcmd in a dedicated command box

	sqlcmd -SSQLServer -Uuser01 -Pabc$123 -dERP_Demo -Q"SELECT * FROM dbo.customers WHERE c_custkey = 1;" 
	sqlcmd -SSQLServer -Usuperuser -Pabc$123 -dERP_Demo -Q"SELECT * FROM dbo.customers WHERE c_custkey = 1;"
*/
EXEC MaintenanceDB.dbo.collect_audit_information;
GO

SELECT * FROM MaintenanceDB.dbo.privileged_access;