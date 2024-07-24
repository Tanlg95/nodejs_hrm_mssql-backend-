
USE master

CREATE DATABASE hrm ON(
	FILENAME = 'D:\mssql\DDL\hrm_primary_file.mdf',
	NAME = hrm,
	SIZE = 1000MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 10MB
), FILEGROUP [FG_hrm](
	FILENAME = 'D:\mssql\DDL\hrm_second_1.ndf',
	NAME = hrm_fg1,
	SIZE = 500MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 10MB
),(
	FILENAME = 'D:\mssql\DDL\hrm_second_2.ndf',
	NAME = hrm_fg2,
	SIZE = 500MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 10MB
),(
	FILENAME = 'D:\mssql\DDL\hrm_second_3.ndf',
	NAME = hrm_fg3,
	SIZE = 500MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 10MB
) LOG ON(
	FILENAME = 'D:\mssql\DDL\hrm_log.ldf',
	NAME = hrm_LOG,
	SIZE = 100MB,
	MAXSIZE = 2000MB,
	FILEGROWTH = 10MB
)
GO
USE hrm;
-- create schema employee
IF EXISTS (SELECT 1 FROM SYS.SCHEMAS WHERE name = 'employee')
BEGIN
	EXEC('DROP SCHEMA employee;')
END
ELSE
BEGIN
	EXEC('CREATE SCHEMA employee;')
END
GO

-- create table employee information
IF OBJECT_ID('employee.tblemployee') IS NOT NULL
DROP TABLE employee.tblemployee
CREATE TABLE employee.tblemployee(
	employeeId CHAR(10),
	employeeName NVARCHAR(250),
	employedDate DATE,
	birthDate DATE,
	isActive BIT,
	keyid UNIQUEIDENTIFIER DEFAULT (NEWSEQUENTIALID()),
	CONSTRAINT pk_tblemployee PRIMARY KEY(employeeId)
) ON [FG_hrm]
GO
-- create table employee's position
IF OBJECT_ID('employee.tblref_position') IS NOT NULL
DROP TABLE employee.tblref_position
CREATE TABLE employee.tblref_position(
	posId CHAR(10),
	posName NVARCHAR(150),
	note NVARCHAR(250),
	CONSTRAINT pk_tblref_position PRIMARY KEY(posId)
) ON[FG_hrm]
GO
IF OBJECT_ID('employee.tblemppos') IS NOT NULL
DROP TABLE employee.tblemppos
CREATE TABLE employee.tblemppos(
	employeeId CHAR(10),
	datechange DATE,
	posId CHAR(10),
	note NVARCHAR(250),
	CONSTRAINT pk_tblemppos PRIMARY KEY CLUSTERED(
		employeeId , datechange DESC),
	CONSTRAINT fk_tblemppos_1 FOREIGN KEY(employeeId) REFERENCES employee.tblemployee(employeeId) ON UPDATE CASCADE,
	CONSTRAINT fk_tblemppos_2 FOREIGN KEY(posId) REFERENCES employee.tblref_position(posId) ON UPDATE CASCADE
) ON[FG_hrm]
GO

ALTER TABLE employee.tblref_position ADD keyid INT IDENTITY(1,1)
GO

-- CREATE TABLE employee's position TYPE
IF EXISTS (SELECT * FROM sys.types WHERE name = 'utype_tblemppos')
DROP TYPE employee.utype_tblemppos
GO
CREATE TYPE employee.utype_tblemppos AS TABLE(
	employeeId CHAR(10),
	datechange DATE,
	posId CHAR(10),
	note NVARCHAR(150)
)
GO

ALTER TABLE employee.tblemppos ADD keyid INT IDENTITY(1,1)
GO

-- CREATE TABLE employee's account
IF OBJECT_ID('employee.tblaccount') IS NOT NULL
DROP TABLE employee.tblaccount
GO
CREATE TABLE employee.tblaccount(
	accountId CHAR(10),
	accountName NVARCHAR(150),
	email VARCHAR(150),
	pwd VARCHAR(1000),
	atoken VARCHAR(1500),
	ftoken VARCHAR(1500),
	note NVARCHAR(250),
	keyid INT IDENTITY(1,1)
) ON[FG_hrm]
GO

ALTER TABLE employee.tblaccount ALTER COLUMN accountId NVARCHAR(10) NOT NULL
GO

ALTER TABLE employee.tblaccount ADD CONSTRAINT cs_pk_tblaccount PRIMARY KEY(accountId)
GO

-- CREATE TABLE employee's account TYPE
IF EXISTS (SELECT * FROM sys.types WHERE name = 'utype_tblaccount')
DROP TYPE employee.utype_tblaccount
GO
CREATE TYPE employee.utype_tblaccount AS TABLE(
	accountId CHAR(10),
	accountName NVARCHAR(150),
	email VARCHAR(150),
	pwd VARCHAR(1000),
	atoken VARCHAR(1500),
	ftoken VARCHAR(1500),
	note NVARCHAR(250)
)
GO