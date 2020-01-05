-- --------------------------------------------------------
-- 호스트:                          192.168.1.213
-- 서버 버전:                        5.5.64-MariaDB - MariaDB Server
-- 서버 OS:                        Linux
-- HeidiSQL 버전:                  10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- jeju 데이터베이스 구조 내보내기
CREATE DATABASE IF NOT EXISTS `jeju` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `jeju`;

-- 테이블 jeju.authors 구조 내보내기
CREATE TABLE IF NOT EXISTS `authors` (
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 jeju.authors:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` (`name`, `address`) VALUES
	('대한민국', '서울시'),
	('민국이', '대전시');
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;

-- 테이블 jeju.goods 구조 내보내기
CREATE TABLE IF NOT EXISTS `goods` (
  `code` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `su` int(11) DEFAULT NULL,
  `dan` int(11) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='primary key : 중복이 불가능, 외부에서 참조가 가능한 키';

-- 테이블 데이터 jeju.goods:~7 rows (대략적) 내보내기
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
INSERT INTO `goods` (`code`, `name`, `su`, `dan`) VALUES
	(1, '냉장고', 2, 850000),
	(2, '세탁기', 3, 550000),
	(3, '전자레인지', 2, 350000),
	(4, 'HDTV', 3, 1500000),
	(5, 'VR기기', 2, 1440000),
	(6, 'Drone', 1, 890000),
	(7, '고성능컴퓨터', 3, NULL);
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;

-- 테이블 jeju.purchase 구조 내보내기
CREATE TABLE IF NOT EXISTS `purchase` (
  `num` int(11) NOT NULL AUTO_INCREMENT,
  `userID` varchar(15) DEFAULT NULL,
  `prodName` varchar(15) DEFAULT NULL,
  `groupName` varchar(15) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`num`),
  KEY `userID` (`userID`),
  CONSTRAINT `FK_userinfo` FOREIGN KEY (`userID`) REFERENCES `userinfo` (`userID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- 테이블 데이터 jeju.purchase:~13 rows (대략적) 내보내기
/*!40000 ALTER TABLE `purchase` DISABLE KEYS */;
INSERT INTO `purchase` (`num`, `userID`, `prodName`, `groupName`, `price`, `amount`) VALUES
	(1, 'KBS', '운동화', '전자', 30, 2),
	(2, 'KBS', '운동화', '전자', 30, 2),
	(3, 'KBS', '노트북', '전자', 1000, 1),
	(4, 'JYP', '모니터', '전자', 200, 1),
	(5, 'BBK', '모니터', '전자', 200, 5),
	(6, 'KBS', '청바지', '의류', 50, 3),
	(7, 'BBK', '메모리', '전자', 80, 10),
	(8, 'SSK', '책', '서적', 15, 5),
	(9, 'EJW', '책', '서적', 15, 2),
	(10, 'EJW', '청바지', '의류', 50, 1),
	(11, 'BBK', '운동화', '전자', 30, 2),
	(12, 'EJW', '책', '서적', 15, 1),
	(13, 'BBK', '운동화', '서적', 30, 2);
/*!40000 ALTER TABLE `purchase` ENABLE KEYS */;

-- 프로시저 jeju.purchase_insert 구조 내보내기
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `purchase_insert`(
	IN `userID` VARCHAR(50),
	IN `prodName` VARCHAR(50),
	IN `groupName` VARCHAR(50),
	IN `price` INT,
	IN `amount` INT,
	OUT `result` INT
)
BEGIN
   declare exit handler for sqlexception
   begin 
   	rollback;
   	set result = -1;
   end;
   start transaction;
   	insert into purchase(userID, prodName, groupName, price, amount)
   	value(userID, prodName, groupName, price, amount);
   commit;
   set result = 0; 

END//
DELIMITER ;

-- 테이블 jeju.school 구조 내보내기
CREATE TABLE IF NOT EXISTS `school` (
  `no` int(11) NOT NULL AUTO_INCREMENT,
  `schoolname` varchar(20) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `schoolcode` char(10) NOT NULL,
  `studentcount` int(11) DEFAULT NULL,
  PRIMARY KEY (`schoolcode`),
  KEY `no` (`no`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='index = key : 중복이 되지 않도록 하겠다.\r\nAuto_increment : 자동으로 숫자 증가 ';

-- 테이블 데이터 jeju.school:~4 rows (대략적) 내보내기
/*!40000 ALTER TABLE `school` DISABLE KEYS */;
INSERT INTO `school` (`no`, `schoolname`, `address`, `schoolcode`, `studentcount`) VALUES
	(1, '충주여자고등학교', '충주시', 'CH00000001', 300),
	(2, '신성여자고등학교', '제주시', 'IC00000001', 560),
	(3, '종로여자고등학교', '종로구', 'JR00000001', 300),
	(4, '제주여자고등학교', '서울시', 'SE00000001', 300);
/*!40000 ALTER TABLE `school` ENABLE KEYS */;

-- 테이블 jeju.student 구조 내보내기
CREATE TABLE IF NOT EXISTS `student` (
  `bunho` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `kor` tinyint(4) DEFAULT NULL,
  `mat` tinyint(4) DEFAULT NULL,
  `eng` tinyint(4) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `avg` float DEFAULT NULL,
  `grade` char(2) DEFAULT NULL,
  `schoolcode` char(10) DEFAULT NULL,
  PRIMARY KEY (`bunho`),
  KEY `schoolcode` (`schoolcode`),
  CONSTRAINT `FK__school` FOREIGN KEY (`schoolcode`) REFERENCES `school` (`schoolcode`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- 테이블 데이터 jeju.student:~8 rows (대략적) 내보내기
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` (`bunho`, `name`, `kor`, `mat`, `eng`, `total`, `avg`, `grade`, `schoolcode`) VALUES
	(3, '전공인', 81, 82, 91, 254, 84.67, 'B', 'SE00000001'),
	(4, '전공이', 82, 82, 82, 246, 82, 'B', 'SE00000001'),
	(5, '전공삼', 92, 101, 101, 294, 98, 'A', 'CH00000001'),
	(6, '전공사', 101, 101, 101, 303, 101, 'A', 'CH00000001'),
	(7, '고려인', 101, 82, 101, 284, 94.67, 'A', 'CH00000001'),
	(8, '종로구', 72, 82, 101, 255, 85, 'B', 'IC00000001'),
	(9, '종로구', 72, 82, 101, 255, 85, 'B', 'IC00000001'),
	(10, '제주도', 101, 101, 101, 303, 101, 'A', 'IC00000001');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;

-- 테이블 jeju.student2 구조 내보내기
CREATE TABLE IF NOT EXISTS `student2` (
  `num` int(11) NOT NULL DEFAULT '0',
  `name` varchar(12) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `major` varchar(20) DEFAULT NULL,
  `addr` varchar(15) DEFAULT NULL,
  `tel` varchar(15) DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='번호 이름 성별 나이 직업 주소 연락처 급여\r\n\r\n보통 직업은 code화 하여 사용( 여기서는 그냥 사용 )';

-- 테이블 데이터 jeju.student2:~6 rows (대략적) 내보내기
/*!40000 ALTER TABLE `student2` DISABLE KEYS */;
INSERT INTO `student2` (`num`, `name`, `sex`, `age`, `major`, `addr`, `tel`, `money`) VALUES
	(20120001, '고길동', 'm', 27, '선박', 'seoul', '010-000-4512', 5000),
	(20120002, '최둘리', 'm', 22, '역사', 'pusan', '010-999-9999', 4500),
	(20120003, '도우너', 'w', 15, '역사', 'daegu', '010-555-5555', 6500),
	(20120004, '희동이', 'm', 15, '유아', 'mokpo', '010-777-7777', 7000),
	(20120005, '소지섭', 'm', 22, '컴퓨터공학', 'seoul', '010-012-2222', 8000),
	(20120006, '이연희', 'w', 22, '컴퓨터공학', 'seoul', '010-333-3333', 6000);
/*!40000 ALTER TABLE `student2` ENABLE KEYS */;

-- 테이블 jeju.students 구조 내보내기
CREATE TABLE IF NOT EXISTS `students` (
  `name` varchar(50) DEFAULT NULL,
  `korea` int(50) DEFAULT NULL,
  `math` int(50) DEFAULT NULL,
  `english` int(50) DEFAULT NULL,
  `total` int(50) DEFAULT NULL,
  `average` int(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 jeju.students:~3 rows (대략적) 내보내기
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` (`name`, `korea`, `math`, `english`, `total`, `average`) VALUES
	('대한이', 90, 90, 90, 270, 90),
	('민국이', 80, 80, 81, 241, 80),
	('만세', 100, 100, 100, 300, 100);
/*!40000 ALTER TABLE `students` ENABLE KEYS */;

-- 프로시저 jeju.student_insert 구조 내보내기
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `student_insert`(
	IN `name` VARCHAR(50),
	IN `kor` INT,
	IN `mat` INT,
	IN `eng` INT,
	IN `schoolcode` CHAR(10),
	OUT `result` INT
)
BEGIN
	declare exit handler for sqlexception
	begin
		rollback;   # commit, savepoint , rollback : transaction 명령어
		set result = -1 ;
	end;
	start transaction;
		insert into student(name, kor, mat, eng, schoolcode)
		value(name,kor,mat,eng,schoolcode);
	commit;
	set result = 0;	
END//
DELIMITER ;

-- 프로시저 jeju.student_select 구조 내보내기
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `student_select`()
BEGIN
	select * from student;
END//
DELIMITER ;

-- 프로시저 jeju.student_sum 구조 내보내기
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `student_sum`()
BEGIN
	drop table if exists sungjuk_hab;   # sungjuk_hab table이 기존에 있으면 지우고 시작
	create table sungjuk_hab(korhab float, mathab float, enghab float)
		as select sum(kor) as korhab, sum(mat) as mathab, sum(eng) as enghab from student;
	insert into sungjuk_hab (korhab, mathab, enghab)
		select round(avg(kor),2) , round(avg(mat),2), round(avg(eng),2) from student;
		select * from sungjuk_hab;
END//
DELIMITER ;

-- 프로시저 jeju.student_updatename 구조 내보내기
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `student_updatename`(
	IN `name1` VARCHAR(50),
	IN `name2` VARCHAR(50),
	OUT `result` INT


)
BEGIN
   declare cnt int default 0; #cnt = 0;
	select count(*) into cnt from student where name = name1;
	
	if cnt >0 then 
			update student set name = name2 where name = name1;
			set result = 0;
	
	else set result = -1;
	end if;
END//
DELIMITER ;

-- 프로시저 jeju.student_updateone 구조 내보내기
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `student_updateone`()
BEGIN
    # 모든 데이터에 1점씩 추가하는 저장루틴
    
    declare _done int default false;  # 무한루프의 종료 조건을 위해서 사용
    declare name_var varchar(20);    # 데이터를 하나씩 처리하기 위한 변수들 
    declare kor_var int;
    declare mat_var int;
    declare eng_var int;
    
    declare cursor_student cursor for select name, kor, mat, eng from student;  # 커서 선언 : student의 모든 데이터를 갖고와서 가리키고 있음
	 # * cursor : 데이터를 가리키는 위치
    declare continue handler for not found set _done = TRUE;   # 그냥 이렇게 사용함 
    open cursor_student;
    repeat
    	fetch cursor_student into name_var, kor_var, mat_var, eng_var;  # 데이터를 하나씩 가져오기 위해 fetch
    	if not _done then # not _done  == TRUE
    		update student set kor = kor_var+1, mat = mat_var+1, eng = eng_var +1 where name = name_var;
    		set _done = FALSE;
    	end if;
    until _done # 종료조건 :  _done이 TRUE가 될떄까지  ( for not fount -> TRUE  :: 찾을 수 없으면 TRUE 리턴)
    end repeat;
    close cursor_student;
    
END//
DELIMITER ;

-- 테이블 jeju.sungjuk_hab 구조 내보내기
CREATE TABLE IF NOT EXISTS `sungjuk_hab` (
  `korhab` float DEFAULT NULL,
  `mathab` float DEFAULT NULL,
  `enghab` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- 테이블 데이터 jeju.sungjuk_hab:~2 rows (대략적) 내보내기
/*!40000 ALTER TABLE `sungjuk_hab` DISABLE KEYS */;
INSERT INTO `sungjuk_hab` (`korhab`, `mathab`, `enghab`) VALUES
	(694, 705, 771),
	(86.75, 88.13, 96.38);
/*!40000 ALTER TABLE `sungjuk_hab` ENABLE KEYS */;

-- 테이블 jeju.userinfo 구조 내보내기
CREATE TABLE IF NOT EXISTS `userinfo` (
  `userID` varchar(15) NOT NULL,
  `name` varchar(15) DEFAULT NULL,
  `birthYear` int(11) DEFAULT NULL,
  `addr` varchar(15) DEFAULT NULL,
  `mobile1` char(3) DEFAULT NULL,
  `mobile2` char(8) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `mDate` date DEFAULT NULL,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='userID, name, birthYear,addr,mobile1,mobil2,height,mDate';

-- 테이블 데이터 jeju.userinfo:~10 rows (대략적) 내보내기
/*!40000 ALTER TABLE `userinfo` DISABLE KEYS */;
INSERT INTO `userinfo` (`userID`, `name`, `birthYear`, `addr`, `mobile1`, `mobile2`, `height`, `mDate`) VALUES
	('BBK', '바비킴', 1973, '서울', '010', '00000000', 176, '2013-05-05'),
	('EJW', '은지원', 1972, '경북', '011', '88888888', 174, '2014-03-03'),
	('JKW', '조관우', 1965, '경기', '018', '99999999', 126, '2010-10-10'),
	('JYP', '조용필', 1950, '경기', '011', '44444444', 166, '2009-04-04'),
	('KBS', '김범수', 1979, '경남', '011', '22222222', 173, '2012-04-04'),
	('KKH', '김경호', 1971, '전남', '019', '33333333', 177, '2007-07-07'),
	('LJB', '임재범', 1963, '서울', '016', '66666666', 182, '2009-09-09'),
	('LSG', '이승기', 1987, '서울', '011', '11111111', 182, '2008-08-08'),
	('SSK', '성시경', 1979, '서울', NULL, NULL, 186, '2013-12-12'),
	('YJS', '윤종신', 1969, '경남', NULL, NULL, 170, '2005-05-05');
/*!40000 ALTER TABLE `userinfo` ENABLE KEYS */;

-- 프로시저 jeju.userinfo_insert 구조 내보내기
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `userinfo_insert`(
	IN `userID` VARCHAR(15),
	IN `name` VARCHAR(15),
	IN `birthYear` INT,
	IN `addr` VARCHAR(15),
	IN `mobile1` CHAR(3),
	IN `mobile2` CHAR(8),
	IN `height` INT,
	IN `mDate` DATE,
	OUT `result` INT




)
BEGIN
	declare exit handler for sqlexception
	begin
		rollback;
		set result = -1;
	end;
	start transaction;
		insert into userinfo(userID, name, birthYear,addr,mobile1,mobile2,height,mDate)
		values(userID, name, birthYear,addr,mobile1,mobil2,height,mDate);
	set result = 0;
END//
DELIMITER ;

-- 트리거 jeju.student_before_insert 구조 내보내기
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `student_before_insert` BEFORE INSERT ON `student` FOR EACH ROW BEGIN   # OLD : 입력된 값, NEW : 새롭게 만들어질 데이터 ,
   # set : 변수에 값을 대입할 때 사용됨 
    set new.total = new.kor + new.mat + new.eng;
    set new.avg = round(new.total/3,2);
	 
	 if new.avg >= 90 then set new.grade = 'A';
	 elseif new.avg >= 80 then set new.grade = 'B';
	 elseif new.avg >= 70 then set new.grade = 'C';
	 elseif new.avg >= 60 then set new.grade = 'D';
	 else set new.grade = 'F';
	 end if;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- 트리거 jeju.student_before_update 구조 내보내기
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `student_before_update` BEFORE UPDATE ON `student` FOR EACH ROW BEGIN
    set new.total = new.kor + new.mat + new.eng;
    set new.avg = round(new.total/3,2);
	 
	 if new.avg >= 90 then set new.grade = 'A';
	 elseif new.avg >= 80 then set new.grade = 'B';
	 elseif new.avg >= 70 then set new.grade = 'C';
	 elseif new.avg >= 60 then set new.grade = 'D';
	 else set new.grade = 'F';
	 end if;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
