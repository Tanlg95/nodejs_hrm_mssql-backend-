DELETE FROM employee.tblref_position
GO
INSERT employee.tblref_position(posId, posName)
VALUES('NV',N'nhân viên'),
('TN',N'trưởng nhóm'),
('PN',N'phó nhóm'),
('QL',N'quản lý'),
('PQL',N'phó quản lý'),
('PP',N'phó phòng'),
('TP',N'trưởng phòng'),
('GD',N'giám đốc'),
('PGD',N'phó giám đốc'),
('TGD',N'tổng giám đốc'),
('BV',N'bảo vệ');
GO

DELETE FROM employee.tblref_department
GO
INSERT INTO employee.tblref_department(depId,depName, depTypeId, depParent,depOrderNo)
VALUES
('SX',N'sản xuất', 'S', NULL, 0),
('VP',N'văn phòng', 'S', NULL, 1),
('SXTD',N'sản xuất tiêu dùng', 'L', 'SX', 2),
('SXXK',N'sản xuất xuất khẩu', 'L', 'SX', 3),
('TCKT',N'tài chính-kế toán', 'L', 'VP', 4),
('TD',N'tuyển dụng', 'L', 'VP', 5),
('KT',N'kỹ thuật', 'L', 'VP', 6),
('NS',N'nhân sự', 'L', 'VP', 7),
('KTM',N'kỹ thuật phần mềm', 'G', 'KT', 8),
('KTC',N'kỹ thuật phần cứng', 'G', 'KT', 9),
('KTM1',N'lập trình nhúng', 'T', 'KTM', 10),
('KTM2',N'lập trình web', 'T', 'KTM', 11),
('KTM11',N'lập trình nhúng TT', 'P', 'KTM1', 12),
('KTM22',N'lập trình nhúng TK', 'P', 'KTM1', 13)
GO

------------------------------ employee --------------------------

-- create procedure auto generate employee information

IF OBJECT_ID('employee.usp_gen_employee') IS NOT NULL
DROP PROCEDURE employee.usp_gen_employee
GO
CREATE PROCEDURE employee.usp_gen_employee(@totalEmployee INT)
AS
BEGIN
	
DECLARE @tableName1 TABLE(
	keyid INT,
	employeeName NVARCHAR(100)
)
DECLARE @tableName2 TABLE(
	keyid INT,
	employeeName NVARCHAR(100)
)
DECLARE @tableName3 TABLE(
	keyid INT,
	employeeName NVARCHAR(100)
)

INSERT @tableName1(keyid,employeeName) VALUES
(1 	,N'Huy'),
(2 	,N'Khang'),
(3 	,N'Bảo'),
(4 	,N'Minh'),
(5 	,N'Phúc'),
(6 	,N'Anh'),
(7 	,N'Khoa'),
(8 	,N'Phát'),
(9 	,N'Đạt'),
(10 	,N'Khôi'),
(11 	,N'Long'),
(12 	,N'Nam'),
(13 	,N'Duy'),
(14 	,N'Quân'),
(15 	,N'Kiệt'),
(16 	,N'Thịnh'),
(17 	,N'Tuấn'),
(18 	,N'Hưng'),
(19 	,N'Hoàng'),
(20 	,N'Hiếu'),
(21 	,N'Nhân'),
(22 	,N'Trí'),
(23 	,N'Tài'),
(24 	,N'Phong'),
(25 	,N'Nguyên'),
(26 	,N'An'),
(27 	,N'Phú'),
(28 	,N'Thành'),
(29 	,N'Đức'),
(30 	,N'Dũng'),
(31 	,N'Lộc'),
(32 	,N'Khánh'),
(33 	,N'Vinh'),
(34 	,N'Tiến'),
(35 	,N'Nghĩa'),
(36 	,N'Thiện'),
(37 	,N'Hào'),
(38 	,N'Hải'),
(39 	,N'Đăng'),
(40 	,N'Quang'),
(41 	,N'Lâm'),
(42 	,N'Nhật'),
(43 	,N'Trung'),
(44 	,N'Thắng'),
(45 	,N'Tú'),
(46 	,N'Hùng'),
(47 	,N'Tâm'),
(48 	,N'Sang'),
(49 	,N'Sơn'),
(50 	,N'Thái'),
(51 	,N'Cường'),
(52 	,N'Vũ'),
(53 	,N'Toàn'),
(54 	,N'Ân'),
(55 	,N'Thuận'),
(56 	,N'Bình'),
(57 	,N'Trường'),
(58 	,N'Danh'),
(59 	,N'Kiên'),
(60 	,N'Phước'),
(61 	,N'Thiên'),
(62 	,N'Tân'),
(63 	,N'Việt'),
(64 	,N'Khải'),
(65 	,N'Tín'),
(66 	,N'Dương'),
(67 	,N'Tùng'),
(68 	,N'Quý'),
(69 	,N'Hậu'),
(70 	,N'Trọng'),
(71 	,N'Triết'),
(72 	,N'Luân'),
(73 	,N'Phương'),
(74 	,N'Quốc'),
(75 	,N'Thông'),
(76 	,N'Khiêm'),
(77 	,N'Hòa'),
(78 	,N'Thanh'),
(79 	,N'Tường'),
(80 	,N'Kha'),
(81 	,N'Vỹ'),
(82 	,N'Bách'),
(83 	,N'Khanh'),
(84 	,N'Mạnh'),
(85 	,N'Lợi'),
(86 	,N'Đại'),
(87 	,N'Hiệp'),
(88 	,N'Đông'),
(89 	,N'Nhựt'),
(90 	,N'Giang'),
(91 	,N'Kỳ'),
(92 	,N'Phi'),
(93 	,N'Tấn'),
(94 	,N'Văn'),
(95 	,N'Vương'),
(96 	,N'Công'),
(97 	,N'Hiển'),
(98 	,N'Linh'),
(99 	,N'Ngọc'),
(100 ,N'Vĩ');
INSERT @tableName2 SELECT * FROM @tableName1
INSERT @tableName3 SELECT * FROM @tableName1
UPDATE @tableName1 SET employeeName = RTRIM(LTRIM(employeeName))
UPDATE @tableName2 SET employeeName = RTRIM(LTRIM(employeeName))
UPDATE @tableName3 SET employeeName = RTRIM(LTRIM(employeeName))
--SELECT keyid, employeeName, LEN(employeeName) employeename_len FROM @tableName1
--SELECT keyid, employeeName, LEN(employeeName) employeename_len FROM @tableName2
--SELECT keyid, employeeName, LEN(employeeName) employeename_len FROM @tableName3

-- employee's id
	DECLARE @get_max_id INT = ISNULL((SELECT max(CAST(RIGHT(employeeId,7) AS INT)) max_id FROM employee.tblemployee),0) + 1;
	--DECLARE @employeeId VARCHAR(50) = 
	--		CASE WHEN @get_max_id > -1 AND @get_max_id < 10 THEN 'SIV0000' + CAST(@get_max_id AS VARCHAR(10))
	--			 WHEN @get_max_id >= 10 AND @get_max_id < 100 THEN 'SIV000' + CAST(@get_max_id AS VARCHAR(10))
	--			 WHEN @get_max_id >= 100 AND @get_max_id < 1000 THEN 'SIV00' + CAST(@get_max_id AS VARCHAR(10))
	--			 WHEN @get_max_id >= 1000 AND @get_max_id < 10000 THEN 'SIV0' + CAST(@get_max_id AS VARCHAR(10))
	--			 WHEN @get_max_id >= 10000 AND @get_max_id < 100000 THEN 'SIV' + CAST(@get_max_id AS VARCHAR(10)) END
	-- employee's join date
DECLARE @total_want_make_employee INT = 100;
DECLARE @begin_while INT = 1;
WHILE @begin_while < @total_want_make_employee + 1
BEGIN

	DECLARE @rand_number_for_name_1 SMALLINT = CEILING(RAND() * 100)
	, @rand_number_for_name_2 SMALLINT = CEILING(RAND() * 100)
	, @rand_number_for_name_3 SMALLINT = CEILING(RAND() * 100)
	-- random employee's name
	DECLARE @rand_name NVARCHAR(150) = CONCAT((SELECT employeeName FROM @tableName1 WHERE keyid = @rand_number_for_name_1),' ',
	(SELECT employeeName FROM @tableName2 WHERE keyid = @rand_number_for_name_2),' ',
	(SELECT employeeName FROM @tableName3 WHERE keyid = @rand_number_for_name_3));
	
	DECLARE @employedDate DATE = DATEADD(DAY, CEILING(RAND() * 10000) ,CAST('2000-01-01' AS DATE));
	-- employee's birth date
	DECLARE @birthDate DATE = DATEADD(DAY, CEILING(RAND() * 13000) ,CAST('1980-01-01' AS DATE));
	-- employee's active
	DECLARE @isActive BIT = IIF( CEILING(RAND() * 10) < 7, 1, 0)

	DECLARE @employeeId VARCHAR(50) = 
		CASE WHEN @get_max_id > -1 AND @get_max_id < 10 THEN 'SIV0000' + CAST(@get_max_id AS VARCHAR(10))
			 WHEN @get_max_id >= 10 AND @get_max_id < 100 THEN 'SIV000' + CAST(@get_max_id AS VARCHAR(10))
			 WHEN @get_max_id >= 100 AND @get_max_id < 1000 THEN 'SIV00' + CAST(@get_max_id AS VARCHAR(10))
			 WHEN @get_max_id >= 1000 AND @get_max_id < 10000 THEN 'SIV0' + CAST(@get_max_id AS VARCHAR(10))
			 WHEN @get_max_id >= 10000 AND @get_max_id < 100000 THEN 'SIV' + CAST(@get_max_id AS VARCHAR(10)) END
	
	INSERT employee.tblemployee(employeeId, employeeName, employedDate, birthDate, isActive)
	VALUES(@employeeId, @rand_name, @employedDate, @birthDate, @isActive)
	SET @begin_while += 1;
	SET @get_max_id += 1;
END

END
GO
-- how to use store employee.usp_gen_employee:
/*
	// number of the total employee
	DECLARE @total_employee INT = 1000;
	EXEC employee.usp_gen_employee @total_employee;
*/

-- get employee's information
-- IF OBJECT_ID('employee.ufn_get_employee') IS NOT NULL
-- DROP FUNCTION employee.ufn_get_employee
-- GO
-- CREATE FUNCTION employee.ufn_get_employee(@isactive BIT)
-- RETURNS @table TABLE(
-- 	employeeId CHAR(10),
-- 	employeeName NVARCHAR(250),
-- 	employedDate DATE,
-- 	birthDate DATE,
-- 	isActive BIT
-- )
-- AS
-- BEGIN
-- 	INSERT @table (
-- 		employeeId, employeeName, employedDate, birthDate, isActive
-- 	)
-- 	SELECT 
-- 		employeeId, employeeName, employedDate, birthDate, isActive
-- 	FROM employee.tblemployee
-- 	WHERE isActive = @isactive
-- 	RETURN 
-- END
-- GO
-- how to use function employee.ufn_get_employee
/*
	DECLARE @isActive BIT = 0
	SELECT * FROM employee.ufn_get_employee(@isActive) 
*/


------------------------------ position --------------------------

-- generate employee's position

DELETE FROM employee.tblemppos
GO

IF OBJECT_ID('employee.usp_gen_pos') IS NOT NULL
DROP PROCEDURE employee.usp_gen_pos 
GO
CREATE PROCEDURE employee.usp_gen_pos
AS
BEGIN
	BEGIN TRANSACTION
	DECLARE @employeeId CHAR(10) = '', @employedDate DATE = GETDATE();
	DECLARE curv SCROLL CURSOR FOR SELECT employeeId, employedDate FROM employee.tblemployee
	OPEN curv
	FETCH NEXT FROM curv INTO @employeeId, @employedDate
	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE @rand_posId CHAR(10) = (SELECT posId FROM employee.tblref_position WHERE keyid = CEILING(RAND()* 10))
		IF NOT EXISTS (SELECT 1 FROM employee.tblemppos WHERE employeeId = @employeeId)
		BEGIN
			INSERT INTO employee.tblemppos(employeeId,datechange,posId)
			VALUES(@employeeId, @employedDate,@rand_posId)
		END

		FETCH NEXT FROM curv INTO @employeeId, @employedDate
	END;
	CLOSE curv
	DEALLOCATE curv
	COMMIT TRANSACTION
END
GO
-- just only use one time
-- how to use 
/*
	EXEC employee.usp_gen_pos 
*/

-- do you want to create more positions for employees ? 
-- just use store employee.usp_gen_pos_ad 

IF OBJECT_ID('employee.usp_gen_pos_ad') IS NOT NULL
DROP PROCEDURE employee.usp_gen_pos_ad 
GO
CREATE PROCEDURE employee.usp_gen_pos_ad(@totalEmployee INT)
AS
BEGIN
	DECLARE @sql_string NVARCHAR(4000) = N'
	BEGIN TRANSACTION
	DECLARE @employeeId CHAR(10) = '''', @datechange DATE = GETDATE(), @posId CHAR(10);
	DECLARE curv SCROLL CURSOR FOR 
	SELECT TOP '+ CAST(@totalEmployee AS VARCHAR(10)) +' p.employeeId, datechange, posId 
		FROM employee.tblemppos p
		INNER JOIN(
			SELECT employeeId, MAX(datechange) max_date
			FROM employee.tblemppos
			GROUP BY employeeId
		)sub ON sub.employeeId = p.employeeId AND sub.max_date = p.datechange
		
	OPEN curv
	FETCH NEXT FROM curv INTO @employeeId, @datechange, @posId
	WHILE @@FETCH_STATUS = 0
	BEGIN
		DECLARE @rand_posId CHAR(10) = (SELECT posId FROM employee.tblref_position WHERE keyid = CEILING(RAND()* 10))
		DECLARE @rand_datechange DATE = DATEADD(DAY, CEILING(RAND() * 365.0), @datechange)
		IF NOT EXISTS (SELECT 1 FROM employee.tblemppos WHERE employeeId = @employeeId AND posId = @rand_posId AND datechange = @datechange)
		BEGIN
			INSERT INTO employee.tblemppos(employeeId,datechange,posId)
			VALUES(@employeeId, @rand_datechange,@rand_posId)
		END
		ELSE
		BEGIN
			SELECT 1;
		END

		FETCH NEXT FROM curv INTO @employeeId, @datechange, @posId
	END;
	CLOSE curv
	DEALLOCATE curv
	COMMIT TRANSACTION';
	EXEC sp_sqlexec @sql_string;
END
GO
-- how to use:
/*
	DECLARE @total_pos INT = 5000;
	EXEC employee.usp_gen_pos_ad @total_pos
*/

------------------------------------ department ------------------------------------------



-- get department structure

IF OBJECT_ID('employee.ufn_get_dep_struct') IS NOT NULL
DROP FUNCTION employee.ufn_get_dep_struct
GO
CREATE FUNCTION employee.ufn_get_dep_struct(
	@depId CHAR(10)
)
RETURNS @tblref_dep TABLE(
	sectionId CHAR(10),
	lineId CHAR(10),
	groupId CHAR(10),
	teamId CHAR(10),
	partId CHAR(10)
)
AS
BEGIN
	
	-- check first level dep
	DECLARE @tbllevel TABLE(
		depTypeId CHAR(10),
		orderNo INT IDENTITY(1,1),
		depId CHAR(10)
	)
	INSERT @tbllevel (depTypeId) 
	VALUES('S'),('L'),('G'),('T'),('P')


	DECLARE @result TABLE(
		depId CHAR(10),
		orderNo INT
	)

	DECLARE @level_number INT = (SELECT orderNo FROM @tbllevel WHERE depTypeId = (SELECT depTypeId FROM employee.tblref_department WHERE depId = @depId))
	DECLARE @begin INT = 1, @end INT = @level_number
	DECLARE @depId_running CHAR(10) = @depId
	INSERT @result(depId,orderNo) VALUES(@depId,@end)
	WHILE  @end > 0
	BEGIN
		DECLARE @depId_curr CHAR(10) = (SELECT depParent FROM employee.tblref_department WHERE depId = @depId_running)
		INSERT @result(depId, orderNo) VALUES(@depId_curr,@end - 1)
		SET @depId_running = @depId_curr
		SET @end -= 1;
	END

	DECLARE @tbl TABLE( depId CHAR(10), orderNo INT)
	INSERT @tbl
	SELECT B.depId, A.orderNo FROM @tbllevel A
	LEFT JOIN 
		( SELECT TOP 1000 * FROM @result WHERE depId IS NOT NULL ORDER BY orderNo) B ON A.orderNo = B.orderNo

	INSERT @tblref_dep VALUES(NULL,NULL,NULL,NULL,NULL)
	UPDATE @tblref_dep 
	SET sectionId = ( SELECT depId FROM @tbl WHERE orderNo = 1 ),
	lineId = ( SELECT depId FROM @tbl WHERE orderNo = 2 ),
	groupId = ( SELECT depId FROM @tbl WHERE orderNo = 3 ),
	teamId = ( SELECT depId FROM @tbl WHERE orderNo = 4 ),
	partId = ( SELECT depId FROM @tbl WHERE orderNo = 5 )

	RETURN
END
GO
/* how to use
	DECLARE @depId CHAR(10) = 'KT'
	SELECT  * FROM employee.ufn_get_dep_struct (@depId)
*/


IF OBJECT_ID('employee.ufn_get_dep_struct_max_depth') IS NOT NULL
DROP FUNCTION employee.ufn_get_dep_struct_max_depth
GO
CREATE FUNCTION employee.ufn_get_dep_struct_max_depth()
RETURNS @tbl_depid TABLE(
	depId CHAR(10)
)
AS
BEGIN
	DECLARE @tblref_dep TABLE(
		depId CHAR(10),
		depId1 CHAR(10),
		depId2 CHAR(10),
		depId3 CHAR(10),
		depId4 CHAR(10),
		keyid INT IDENTITY(1,1)
		)
		INSERT @tblref_dep
		SELECT
			D.depId,
			D1.depId depId1,
			D2.depId depId2,
			D3.depId depId3,
			D4.depId depId4
		FROM
			employee.tblref_department D
		LEFT JOIN 
			employee.tblref_department D1 ON D1.depParent = D.depId
		LEFT JOIN 
			employee.tblref_department D2 ON D2.depParent = D1.depId
		LEFT JOIN 
			employee.tblref_department D3 ON D3.depParent = D2.depId
		LEFT JOIN 
			employee.tblref_department D4 ON D4.depParent = D3.depId
		ORDER BY D.depId

		DECLARE @tblcontains TABLE(
			sectionId CHAR(10),
			lineId CHAR(10),
			groupId CHAR(10),
			teamId CHAR(10),
			partId CHAR(10),
			keyid INT IDENTITY(1,1)
		)
		DECLARE @begin INT = 1;
		WHILE @begin < 6
		BEGIN
			DECLARE @tblcheck TABLE(depId VARCHAR(10))
			INSERT @tblcheck
			SELECT depId FROM(
							SELECT sectionId depId FROM @tblcontains  UNION ALL
							SELECT lineId FROM @tblcontains  UNION ALL
							SELECT groupId FROM @tblcontains  UNION ALL
							SELECT teamId FROM @tblcontains  UNION ALL
							SELECT partId FROM @tblcontains
							)sub WHERE depId IS NOT NULL
			IF(@begin = 1)
			BEGIN
			INSERT INTO @tblcontains (sectionId, lineId, groupId, teamId, partId)
			SELECT depId, depId1, depId2, depId3, depId4 FROM @tblref_dep 
			WHERE depId4 IS NOT NULL --AND depId3 IS NOT NULL AND depId2 IS NOT NULL AND depId1 IS NOT NULL AND depId IS NOT NULL 
			END
			IF(@begin = 2)
			BEGIN
			INSERT INTO @tblcontains (sectionId, lineId, groupId, teamId, partId)
			SELECT depId, depId1, depId2, depId3, depId4 FROM @tblref_dep D 
			WHERE depId3 IS NOT NULL --AND depId2 IS NOT NULL AND depId1 IS NOT NULL AND depId IS NOT NULL 
			AND depId3 NOT IN (
					SELECT depId FROM @tblcheck
				)
			END
			IF(@begin = 3)
			BEGIN
			INSERT INTO @tblcontains (sectionId, lineId, groupId, teamId, partId)
			SELECT depId, depId1, depId2, depId3, depId4 FROM @tblref_dep D 
			WHERE depId2 IS NOT NULL --AND depId1 IS NOT NULL AND depId IS NOT NULL 
			AND depId2 NOT IN (
					SELECT depId FROM @tblcheck
				)
			END
			IF(@begin = 4)
			BEGIN
			INSERT INTO @tblcontains (sectionId, lineId, groupId, teamId, partId)
			SELECT depId, depId1, depId2, depId3, depId4 FROM @tblref_dep D
			WHERE depId1 IS NOT NULL --AND depId IS NOT NULL 
			AND depId1 NOT IN (
					SELECT depId FROM @tblcheck
				)
			END
			IF(@begin = 5)
			BEGIN
			INSERT INTO @tblcontains (sectionId, lineId, groupId, teamId, partId)
			SELECT depId, depId1, depId2, depId3, depId4 FROM @tblref_dep D 
			WHERE depId IS NOT NULL 
			AND depId NOT IN (
					SELECT depId FROM @tblcheck
				)
			END

			SET @begin += 1;
		END

		INSERT @tbl_depid (depId)
		SELECT IIF( partId IS NOT NULL, partId,
				IIF( teamId IS NOT NULL, teamId,
				IIF( groupId IS NOT NULL, groupId,
				IIF( lineId IS NOT NULL, lineId, sectionId))))
		FROM @tblcontains

	RETURN
END
GO
/*	how to use:
	SELECT * FROM employee.ufn_get_dep_struct_max_depth()
*/


--// create procedure auto generate departments of employees information

IF OBJECT_ID('employee.usp_gen_empdep') IS NOT NULL
DROP PROCEDURE employee.usp_gen_empdep
GO
CREATE PROCEDURE employee.usp_gen_empdep
AS
BEGIN
		--// check exists table tblempdep
		IF EXISTS (SELECT 1 FROM employee.tblempdep)
		BEGIN
			TRUNCATE TABLE employee.tblempdep
		END

		DECLARE @tbl_struct_dep TABLE( depId CHAR(10), keyid INT IDENTITY(1,1))
		INSERT @tbl_struct_dep(depId) SELECT depId FROM employee.ufn_get_dep_struct_max_depth()
	
		DECLARE @employeeId CHAR(10) = '', @employedDate DATE = getdate()
		DECLARE curv CURSOR FAST_FORWARD FOR SELECT employeeId, employedDate FROM employee.tblemployee
		OPEN curv
		FETCH NEXT FROM curv INTO @employeeId, @employedDate
		WHILE @@FETCH_STATUS = 0
		BEGIN
			DECLARE @rand_number_dep SMALLINT = CEILING(RAND() * (SELECT MAX(keyid) FROM @tbl_struct_dep))
			DECLARE @depId CHAR(10) = (SELECT depId FROM @tbl_struct_dep WHERE keyid = @rand_number_dep )

			INSERT INTO employee.tblempdep(employeeId, datechange, depid)
			VALUES(@employeeId, @employedDate, @depId)
		FETCH NEXT FROM curv INTO @employeeId, @employedDate
		END
		CLOSE curv
		DEALLOCATE curv
END
GO
/*	how to use:
	EXEC employee.usp_gen_empdep
	( notice: tblempdep will be truncated first )
*/