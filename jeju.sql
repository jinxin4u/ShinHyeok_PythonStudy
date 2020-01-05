CREATE DATABASE if NOT EXISTS jeju;
USE jeju;

CREATE TABLE authors (
	name VARCHAR(50) NULL DEFAULT NULL,
	address VARCHAR(50) NULL DEFAULT NULL
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

# CRUD (insert into, select, update, delete ) 문 사용
INSERT INTO authors(NAME,address) VALUE("대한이","서울시");
INSERT INTO authors(NAME,address) VALUE("민국이","대전시");
INSERT INTO authors(NAME,address) VALUE("만세","충주시");


# 데이터베이스(외부접속단위), 테이블, 필드, 레코드
# * : 모두다
SELECT * FROM authors; # 모든 열 다 가져오기authors
SELECT * FROM authors WHERE NAME="대한이"; # 이름이 대한이인 열 가져오기
SELECT address FROM authors WHERE NAME="만세";

# 업데이트
UPDATE authors SET NAME="대한민국" WHERE NAME="대한이";

# 삭제
DELETE FROM authors WHERE NAME="만세";


# 문제 : 3인분의 성적을 students 테이블에 입력하고 출력해보기
# 이름 국어 영어 수학 총점 평균
# 대한이, 90, 90, 90
# 민국이, 80, 80, 81
# 만세, 100, 100, 100

CREATE TABLE students (
	name VARCHAR(50) NULL DEFAULT NULL,
	kor INT(11) NULL DEFAULT NULL,
	eng INT(11) NULL DEFAULT NULL,
	math INT(11) NULL DEFAULT NULL,
	total INT(11) NULL DEFAULT NULL,
	avg FLOAT NULL DEFAULT NULL
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

INSERT INTO students(NAME,kor,eng,math,total,avg) VALUE("대한이",90,90,90,kor+eng+math,(kor+eng+math)/3);
INSERT INTO students(NAME,kor,eng,math,total,avg) VALUE("민국이",80,80,81,kor+eng+math,(kor+eng+math)/3);
INSERT INTO students(NAME,kor,eng,math,total,avg) VALUE("만세",100,100,100,kor+eng+math,(kor+eng+math)/3);

DELETE FROM students WHERE total=NULL;

SELECT * FROM students;







CREATE TABLE `fruit` (
	`name` VARCHAR(50) NULL DEFAULT NULL,
	`count` INT(11) NULL DEFAULT NULL,
	`local` VARCHAR(50) NULL DEFAULT NULL
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

INSERT INTO fruit VALUE("apple",3,"daegu");
INSERT INTO fruit VALUE("banana",6,"jeju");
INSERT INTO fruit VALUE("blueberry",4,"USA");

UPDATE FROM fruit SET NAME = "fineapple" aqa NAME = "apple";





INSERT INTO goods VALUES(1,'냉장고',2,850000);
INSERT INTO goods VALUES(2,'세탁기',3,550000);
INSERT INTO goods VALUES(3,'전자레인지',2,350000);
INSERT INTO goods VALUES(4,'HDTV',3,1500000);

# name = not null
# INSERT INTO goods(CODE, su, dan) VALUES(4,3,1500000);
# primary key = code 기본값이 0 /  중복이 되면 안됨
# INSERT INTO goods(NAME, su, dan) VALUES("py",3,1500000);

SELECT * FROM goods;
INSERT INTO goods(CODE, NAME, su) VALUES(5,'드론',1);
UPDATE goods SET dan = 1000000 WHERE CODE = 5; # 중복없이 데이터 입력

DELETE FROM goods WHERE CODE = 5;

INSERT INTO goods VALUES(5,'VR기기',2,1440000);
INSERT INTO goods VALUES(6,'Drone',1,890000);
INSERT INTO goods(CODE, NAME, su) VALUES(7,'고성능컴퓨터',3);


# 문제 : 이름이 냉장고이고, 단가가 75000 이상인 데이터 출력
SELECT * FROM goods WHERE NAME = '냉장고' AND dan>750000;

# 단가가 75000이하인 제품 출력
SELECT * FROM goods WHERE dan < 750000;

# 단가가 50000 이상이고 1200000 이하인 제품 출력
SELECT * FROM goods WHERE dan>500000 AND dan < 1200000;

# 판매 수량이 3개 이상인 제품명과 단가의 출력
SELECT NAME, dan FROM goods WHERE su>=3;






INSERT INTO student VALUES(20120001,'고길동','m',27,'선박','seoul','010-000-4512',5000);
INSERT INTO student VALUES(20120002,'최둘리','m',22,'역사','pusan','010-999-9999',4500);
INSERT INTO student VALUES(20120003,'도우너','w',15,'역사','daegu','010-555-5555',6500);
INSERT INTO student VALUES(20120004,'김만덕','w',15,'유아','mokpo','010-555-7777',7000);
INSERT INTO student VALUES(20120005,'류현진','m',22,'컴퓨터공학','seoul','010-122-2222',8000);
INSERT INTO student VALUES(20120006,'손흥민','m',22,'컴퓨터공학','seoul','010-999-9999',8000);

SELECT * FROM student;

# 직업별로 급여의 합계를 내시오
SELECT SUM(money) FROM student group by major;

# 전체 인원 수
SELECT COUNT(*) FROM student;

# 최 씨로 시작하는 사람을 출력하시오
SELECT * FROM student WHERE NAME LIKE '최%';

# 서울이 주소이고 고씨인 사람을 출력
SELECT * FROM student WHERE address LIKE 'seoul' AND NAME LIKE '고%';

# 필드 이름 바꾸기 와 함수 사용  예
SELECT COUNT(*) "전체행수", COUNT(money) "급여건수", MAX(money) "최대급여", MIN(money) "최소급여", ROUND(AVG(money),2) "평균급여" FROM student;
SELECT COUNT(*) , COUNT(money) , MAX(money) , MIN(money), ROUND(AVG(money),2)  FROM student;

SELECT MAX(money) - MIN(money) AS 급여구간 FROM student;

# maney에 대해서 minmax정규화를 실행하시오
#  그룹 함수이기 때문에 그룹값을 상수화해야 정상적으로 계산됨
#  SELECT (money-MIN(money)) / (MAX(money)-MIN(money)) AS 정규화 FROM student;

# 프로그램으로 변경(사용자 변수 : @, 시스템변수 @@)
SELECT MIN(money) INTO @MINVALUE FROM student; 
SELECT @MINVALUE;
SELECT max(money)-MIN(money) INTO @rangevalue FROM student;
SELECT @rangevalue;
SELECT (money-@MINVALUE)/@rangevalue AS 정규화값 FROM student;


##
INSERT INTO school(schoolname, address, schoolcode, studentcount) VALUES("충주여자고등학교","충주시","CH00000001",300);
INSERT INTO school(schoolname, address, schoolcode, studentcount) VALUES("신성여자고등학교","제주시","IC00000001",560);
INSERT INTO school(schoolname, address, schoolcode, studentcount) VALUES("종로여자고등학교","종로구","JR00000001",300);
INSERT INTO school(schoolname, address, schoolcode, studentcount) VALUES("제주여자고등학교","서울시","SE00000001",300);

INSERT INTO student(NAME, kor, mat, eng, schoolcode) VALUES("전공인",81,81,81,"SE00000001");
INSERT INTO student(NAME, kor, mat, eng, schoolcode) VALUES("전공이",81,81,81,"SE00000001");
INSERT INTO student(name, kor, mat, eng, schoolcode) VALUES("전공삼",91,100,100,"CH00000001");
INSERT INTO student(NAME, kor, mat, eng, schoolcode) VALUES("전공사",100,100,100,"CH00000001");
INSERT INTO student(NAME, kor, mat, eng, schoolcode) VALUES("고려인",100,100,100,"CH00000001");
INSERT INTO student(NAME, kor, mat, eng, schoolcode) VALUES("종로구",100,81,71,"IC00000001");
INSERT INTO student(NAME, kor, mat, eng, schoolcode) VALUES("김만덕",100,81,71,"IC00000001");

SELECT * FROM school;
SELECT * FROM student;

SELECT * FROM school WHERE schoolcode = "CH00000001";
SELECT * FROM student WHERE NAME ="고려인";

SELECT NAME AS '이름', kor AS '국어', mat AS '수학', eng AS '영어' FROM student WHERE NAME = '전공이';

# SUB QUERY
SELECT NAME, kor, mat, eng FROM student WHERE schoolcode IN (SELECT schoolcode FROM school WHERE schoolname = '신성여자고등학교');

# %는 여러글자  /  _는 한 글자
SELECT NAME, kor ,mat, eng FROM student WHERE NAME LIKE '전공%';
SELECT NAME, kor, mat ,eng FROM student WHERE NAME LIKE '%공%';
SELECT NAME, kor, mat, eng FROM student WHERE NAME LIKE '_려_';


# 비교 연산자

SELECT * from student WHERE kor>90 AND mat>90 AND eng>90;
SELECT * FROM student WHERE kor>90 OR mat>90 OR eng>90;
SELECT * FROM student WHERE kor>80 AND kor<90;
SELECT * FROM student WHERE kor BETWEEN 80 AND 90;

# group by, having, order by, limit
SELECT * FROM student LIMIT 1;

SELECT * FROM student ORDER BY NAME DESC; # descending 내림차순
SELECT * FROM student ORDER BY NAME ASC; # asending 오름차순

# inner join : 두 개의 조건이 만족하는 경우만 조인
SELECT sc.schoolname, sc.schoolcode, st.name, st.average
	FROM student st INNER JOIN school sc
		ON st.schoolcode = sc.schoolcode;

# concat : 문자결합 / lPAD : 왼쪽에다 채워라 / replace : 대체 / substr :  빼라
SELECT NAME AS '이름', kor AS '국어', mat AS '수학', eng AS '영어' FROM student WHERE NAME='전공이';

SELECT CONCAT(NAME,'님') AS '이름', kor AS '국어', mat AS '수학', eng AS '영어'
	FROM student WHERE NAME='전공인';
	
SELECT CONCAT(NAME,'님') AS '이름', LPAD(kor, 10, '*') AS '국어', mat AS '수학', eng AS '영어'
	FROM student WHERE NAME ='전공삼';
	
SELECT REPLACE(CONCAT(NAME,'님'),'님','형') AS '이름', LPAD(kor, 10, '*') AS '국어', mat AS '수학', eng AS '영어'
	FROM student WHERE NAME='전공삼';
	
SELECT SUBSTR(REPLACE(CONCAT(NAME,'님'),'님','형'),1,2) AS '이름', LPAD(kor, 10, '*') AS '국어', mat AS '수학', eng AS '영어'
	FROM student WHERE NAME='전공삼';
	
SELECT LENGTH(SUBSTR(REPLACE(CONCAT(NAME,'님'),'님','형'),1,2)) AS '이름', LPAD(kor, 10, '*') AS '국어', mat AS '수학', eng AS '영어'
	FROM student WHERE NAME='전공삼';


# 문제
# -- 전공인의 국어 : 80, 영어: 90 으로 변경하고 합계와 평균 그리고 grade를 수정
#		-- 계산을 수동으로 하고 변화만 적용하시오

# -- student 중 kor, mat 점수만 출력하시오
# -- student 중 average가 90이상인 사람의 name, schoolname을 출력하시오
# -- student 중 eng 점수를 출력하되 그 이름을 "영어"로 하시오
# -- 이름 가운데 자가 "공"인 사람을 모두 출력하시오
# -- 학교 이름이 충주여자고등학교인 사람의 name과 total을 출력하시오
# -- student 에서 total을 이용하여 정렬하고 상위 2사람만 출력하시오

SELECT * FROM student;
UPDATE student SET kor = 80, eng = 90 WHERE NAME = '전공인';
UPDATE student SET total = kor+mat+eng, average = ROUND((kor+mat+eng)/3,2), grade=
	case
		when average >= 90 then 'A'
		when average >= 80 AND average < 90 then 'B'
		when average >= 70 AND average < 80 then 'C'
		when average >= 60 and average < 70 then 'D'
		ELSE 'F'
	END
	where NAME ='전공인';

SELECT NAME,schoolname
	FROM school inner join student
	ON school.schoolcode = student.schoolcode AND average>=90;

SELECT eng AS '영어' FROM student;

SELECT * FROM student WHERE NAME LIKE '%공%';

SELECT NAME, total
	FROM school sc INNER JOIN student st
	ON sc.schoolcode = st.schoolcode
	WHERE schoolname="충주여자고등학교"

-- SELECT st.name, st.total FROM student AS st
--	INNER JOIN school AS sc
--	ON sc.schoolname = "충주여자고등학교"
--	AND st.schoolcode = sc.schoolcode;

SELECT * FROM student ORDER BY total DESC LIMIT 2;


###

# 저장 프로시져 연습[함수화](서버측에서 테스트하는 것)
CALL student_select();
CALL student_insert("제주도",100,100,100,"IC00000001",@res);
SELECT @res;
CALL student_insert("제주도",100,100,100,"tt00000001",@res);
SELECT @res;



# 문제 : 이름을 변경하는 프로시져를 작성하시오
CALL student_updatename("제주도","제주민",@res);
CALL @res;

CALL student_sum();
SELECT * FROM student_sum;

CALL student_updateone();
SELECT * FROM student;



