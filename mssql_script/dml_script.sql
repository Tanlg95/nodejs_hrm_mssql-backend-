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
IF OBJECT_ID('employee.ufn_get_employee') IS NOT NULL
DROP FUNCTION employee.ufn_get_employee
GO
CREATE FUNCTION employee.ufn_get_employee(@isactive BIT)
RETURNS @table TABLE(
	employeeId CHAR(10),
	employeeName NVARCHAR(250),
	employedDate DATE,
	birthDate DATE,
	isActive BIT
)
AS
BEGIN
	INSERT @table (
		employeeId, employeeName, employedDate, birthDate, isActive
	)
	SELECT 
		employeeId, employeeName, employedDate, birthDate, isActive
	FROM employee.tblemployee
	WHERE isActive = @isactive
	RETURN 
END
GO
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