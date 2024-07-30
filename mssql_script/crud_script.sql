--------------------------- employee ----------------------------------------


-- store get employee
IF OBJECT_ID('employee.usp_get_employee') IS NOT NULL
DROP PROCEDURE employee.usp_get_employee
GO
CREATE PROCEDURE employee.usp_get_employee(@todate VARCHAR(50), @empid CHAR(10))
AS
BEGIN
	SELECT employeeId, employeeName, employedDate, birthDate, isActive, keyid
	FROM employee.tblemployee
	WHERE employedDate < DATEADD(DAY,1,CAST(@todate AS DATE))
	AND employeeId LIKE IIF(@empid IS NULL ,'%', CONCAT('%',@empid,'%'))
END
GO

-- store insert employee
IF OBJECT_ID('employee.usp_insert_employee') IS NOT NULL
DROP PROCEDURE employee.usp_insert_employee
GO
CREATE PROCEDURE employee.usp_insert_employee(
		@tblemployee employee.utype_tblemployee READONLY
)
AS
BEGIN
	INSERT employee.tblemployee(employeeId, employeeName, employedDate, birthDate, isActive)
	SELECT employeeId, employeeName, employedDate, birthDate, isActive
	FROM @tblemployee
END
GO

--EXEC employee.usp_get_employee '2024-07-18','SIV00001'

-- store update employee
IF OBJECT_ID('employee.usp_update_employee') IS NOT NULL
DROP PROCEDURE employee.usp_update_employee
GO
CREATE PROCEDURE employee.usp_update_employee(
		@tblemployee employee.utype_tblemployee_update READONLY
)
AS
BEGIN
	UPDATE E
	SET employeeName = ISNULL(E1.employeeName, E.employeeName),
		employedDate = ISNULL(E1.employedDate, E.employedDate),
		birthDate = ISNULL(E1.birthDate, E.birthDate),
		isActive = ISNULL(E1.isActive, E.isActive)
	FROM employee.tblemployee E
	INNER JOIN	@tblemployee E1 ON E.keyid = E1.keyid
END
GO

-- store delete employee
IF OBJECT_ID('employee.usp_delete_employee') IS NOT NULL
DROP PROCEDURE employee.usp_delete_employee
GO
CREATE PROCEDURE employee.usp_delete_employee(
	@tblemployee employee.utype_delete_multi_rows READONLY
)
AS
BEGIN
	DELETE E FROM employee.tblemployee E
	INNER JOIN @tblemployee E1 ON E.keyid = E1.keyid

END
GO

--------------------------- position ----------------------------------------


-- get employee's position
IF OBJECT_ID('employee.ufn_get_position') IS NOT NULL
DROP FUNCTION employee.ufn_get_position 
GO
CREATE FUNCTION employee.ufn_get_position(@todate DATE, @empid CHAR(10))
RETURNS @tblemppos TABLE(
	employeeId CHAR(10),
	datechange DATE,
	posId CHAR(10),
	posName NVARCHAR(150),
	note NVARCHAR(150)
)
AS
BEGIN
	INSERT @tblemppos (employeeId, datechange, posId, posName, note)
	SELECT TOP 100000000 P.employeeId, P.datechange, P.posId, (SELECT posName FROM employee.tblref_position ref WHERE ref.posId = P.posId), P.note 
	FROM employee.tblemppos P
	INNER JOIN(
		SELECT employeeId, MAX(datechange) max_date
		FROM employee.tblemppos
		WHERE datechange < DATEADD(DAY, 1, @todate) 
		AND employeeId LIKE IIF( @empid IS NULL, '%', CONCAT('%',@empid,'%'))
		GROUP BY employeeId
	)sub ON P.employeeId = sub.employeeId AND P.datechange = sub.max_date
	ORDER BY P.employeeId
	RETURN
END
GO
-- SELECT * FROM employee.ufn_get_position(CURRENT_TIMESTAMP + 100,null)

-- insert employee's position

IF OBJECT_ID('employee.usp_insert_position') IS NOT NULL
DROP PROCEDURE employee.usp_insert_position
GO
CREATE PROCEDURE employee.usp_insert_position
	@tblemppos employee.utype_tblemppos READONLY
AS
BEGIN
	INSERT employee.tblemppos(employeeId, datechange, posId, note)
	SELECT employeeId, datechange, posId, note
	FROM @tblemppos

END
GO

--DECLARE @table employee.utype_tblemppos;
--INSERT INTO @table(employeeId, datechange, posId, note)
--VALUES('SIV09599','2024-05-01','QL','promote'),
--('SIV09598','2024-05-01','NV','promote')
--SELECT * FROM @table
--EXECUTE employee.usp_insert_position @table

-- update employee's position
IF OBJECT_ID('employee.usp_update_position') IS NOT NULL
DROP PROCEDURE employee.usp_update_position
GO
CREATE PROCEDURE employee.usp_update_position
	@tblemppos employee.utype_tblemppos_update READONLY
AS
BEGIN
	UPDATE P
	SET datechange = ISNULL(P1.datechange, P.datechange),
		posId = ISNULL(P1.posId, P.posId),
		note = P1.note
	FROM employee.tblemppos P
	INNER JOIN
		@tblemppos P1 ON P.keyid = P1.keyid
END
GO

-- delete employee's position
IF OBJECT_ID('employee.usp_delete_position') IS NOT NULL
DROP PROCEDURE employee.usp_delete_position
GO
CREATE PROCEDURE employee.usp_delete_position 
	@tblemppos employee.utype_delete_multi_rows READONLY
AS
BEGIN
	DELETE P FROM employee.tblemppos P
	INNER JOIN
		@tblemppos P1 ON P.keyid = P1.keyid
END
GO

--- FUNCTION get max position
IF OBJECT_ID('employee.ufn_get_max_pos') IS NOT NULL
DROP FUNCTION  employee.ufn_get_max_pos
GO
CREATE FUNCTION employee.ufn_get_max_pos(@todate DATE, @employeeId CHAR(10))
RETURNS @get_max_pos TABLE(
	employeeId CHAR(10),
	employeeName NVARCHAR(150),
	employedDate DATE,
	datechange_pos DATE,
	posId CHAR(10),
	posName NVARCHAR(150),
	note VARCHAR(150)
)
AS
BEGIN
	INSERT @get_max_pos(
		employeeId, employeeName, employedDate, datechange_pos, posId, posName, note
	)
	SELECT
		e.employeeId,
		e.employeeName,
		e.employedDate,
		p.datechange ,
		p.posId,
		(SELECT posName FROM employee.tblref_position ref WHERE ref.posId = p.posId),
		p.note
	FROM
		employee.tblemppos p
	INNER JOIN
		(
			SELECT	employeeId, MAX(datechange) max_date 
			FROM employee.tblemppos
			WHERE datechange <  DATEADD(DAY,1,@todate )
			AND employeeId LIKE IIF(@employeeId IS NULL, '%', CONCAT('%',@employeeId,'%'))
			GROUP BY employeeId
		)sub ON p.employeeId = sub.employeeId AND p.datechange = sub.max_date
	INNER JOIN
		employee.tblemployee e ON p.employeeId = e.employeeId

	RETURN
END
GO


--------------------------- account ----------------------------------------
-- store insert employee's account
IF OBJECT_ID('employee.usp_insert_account') IS NOT NULL
DROP PROCEDURE employee.usp_insert_account
GO
CREATE PROCEDURE employee.usp_insert_account
	@tblaccount employee.utype_tblaccount READONLY
AS
BEGIN
	INSERT employee.tblaccount(accountId, accountName, email, pwd, atoken, ftoken, note)
	SELECT accountId, accountName, email, pwd, atoken, ftoken, note
	FROM @tblaccount
END
GO

-- store update employee's account information
IF OBJECT_ID('employee.usp_update_account') IS NOT NULL
DROP PROCEDURE employee.usp_update_account
GO
CREATE PROCEDURE employee.usp_update_account
	@tblaccount employee.utype_tblaccount_update READONLY
AS
BEGIN
	UPDATE A
	SET accountName = ISNULL(A1.accountName, A.accountName),
		email = ISNULL(A1.email, A.email),
		note = A1.note
	FROM employee.tblaccount A
	INNER JOIN @tblaccount A1 ON A1.keyid = A.keyid
END
GO

-- store delete employee's information account 
IF OBJECT_ID('employee.usp_delete_account') IS NOT NULL
DROP PROCEDURE employee.usp_delete_account
GO
CREATE PROCEDURE employee.usp_delete_account
	@tblaccount employee.utype_delete_multi_rows READONLY 
AS
BEGIN
	DELETE A FROM employee.tblaccount A 
	INNER JOIN @tblaccount A1 ON A.keyid = A1.keyid
	
END
GO

-- store update account's token 
IF OBJECT_ID('employee.usp_update_token') IS NOT NULL
DROP PROCEDURE employee.usp_update_token
GO
CREATE PROCEDURE employee.usp_update_token
	@keyid INT,
	@atoken VARCHAR(1500),
	@ftoken VARCHAR(1500),
	@opt TINYINT
AS
BEGIN
	-- opt: 0 => atoken and ftoken
	-- opt: 1 => atoken
	-- opt: 2 => ftoken
	IF(@opt = 0)
	BEGIN
		UPDATE employee.tblaccount 
		SET atoken = @atoken,
			ftoken = @ftoken
		WHERE keyid = @keyid
	END
	IF(@opt = 1)
	BEGIN
		UPDATE employee.tblaccount SET atoken = @atoken
		WHERE keyid = @keyid
	END
	ELSE
		UPDATE employee.tblaccount SET ftoken = @ftoken
		WHERE keyid = @keyid
END
GO

-- store change password

IF OBJECT_ID('employee.usp_change_account_password') IS NOT NULL
DROP PROCEDURE employee.usp_change_account_password
GO
CREATE PROCEDURE employee.usp_change_account_password(
	@keyid INT,
	@new_password VARCHAR(1000)
)
AS
BEGIN
		UPDATE employee.tblaccount
		SET pwd = @new_password
		WHERE keyid = @keyid

END
GO

SELECT * FROM employee.tblaccount