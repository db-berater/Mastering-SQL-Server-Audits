USE master;
GO

IF SUSER_ID(N'user01') IS NOT NULL
	DROP LOGIN [user01];
GO

CREATE LOGIN [user01]
WITH
	PASSWORD = 'abc$123',
	CHECK_EXPIRATION = OFF,
	CHECK_POLICY = OFF;
GO

USE ERP_Demo;
GO

CREATE USER user01 FROM LOGIN user01;
ALTER ROLE db_datareader ADD MEMBER user01;
ALTER ROLE db_datawriter ADD MEMBER user01;
GO


IF SUSER_ID(N'superuser') IS NOT NULL
	DROP LOGIN [superuser];
GO

CREATE LOGIN [superuser]
WITH
	PASSWORD = 'abc$123',
	CHECK_EXPIRATION = OFF,
	CHECK_POLICY = OFF;
GO

ALTER SERVER ROLE sysadmin ADD MEMBER [superuser];
GO

SELECT	principal_id,
		sid,
		name,
		IS_SRVROLEMEMBER(N'sysadmin', name)	AS	is_sysadmin
FROM		sys.server_principals
WHERE	name IN
		(
			N'user01',
			N'superuser'
		);
GO