# BBK가 구매한 데이터를 출력하시오
SELECT * FROM userbuy WHERE userID = "BBK";

# 김씨인 사람 중 이름과 키를 기준으로 이름, 키, 주소를 내림차순으로 출력하시오(이름 뒤에는 '님을 붙여서 출력
SELECT NAME, height, addr
	FROM userlist
	WHERE SUBSTR(NAME,1,1)="김"
	ORDER BY NAME DESC, height desc;

# user 를 출생년도별 오름차순으로 이름, 주소, 키, 출생년도를 출력하시오(이름은 성을 빼고 출력)
SELECT substr(NAME,2), addr, height, birthYear
	FROM userlist
	ORDER BY birthYear;

# 모바일 번호가 011로 시작하는 사람이 몇명인지 출력하시오
SELECT COUNT(*)
	FROM userlist
	WHERE mobile1 = "011";

# 출생년도가 1960년에서 1979년까지 태어난 사람들이 구매한 품목을 출력하시오
SELECT ub.prodName
	FROM userlist AS ul INNER JOIN userbuy AS ub
	ON ul.userID=ub.userID and birthYear BETWEEN 1960 AND 1979;


# UserID별로 구매한 price, amount 합계를 출력하시오(이 때 userID는 name으로 출력하시오)
SELECT userID AS "name", SUM(price), SUM(amount)
	FROM userbuy GROUP BY userID;

# 주소가 서울인 사람이 구매한 총액을 구하시오
SELECT SUM(ub.price * ub.amount) AS "총액"
	FROM userbuy AS ub INNER JOIN userlist AS ul
	ON ub.userID=ul.userID and addr = "서울"

# 품목별 판매 총액을 출력하시오
SELECT prodName, SUM(price * amount) AS "판매총액"
	FROM userbuy
	GROUP BY prodName;


# 출생년도가 1970년도 이상인 사람을 대상으로 구매한 갯수가 2개 이상인 것의 판매 총합계를 구하시오
SELECT SUM(ub.price * ub.amount) AS "판매총합계"
	FROM userbuy AS ub INNER JOIN userlist AS ul
	ON ub.userID = ul.userID and birthYear >= 1970 AND amount >= 2;

# 모든 유저를 출력하시오(이름 중에 김씨와 조씨는 모두 컬씨로 바꾸어 출력)
SELECT case
	when SUBSTR(NAME,1,1) = "김" then CONCAT("컬",substr(NAME,2))
	when SUBSTR(NAME,1,1) = "조" then CONCAT("컬",SUBSTR(NAME,2))
	ELSE name
	end
	FROM userlist;
	
# 책을 구매한 사람의 이름과 출생년도와 주소를 출력하시오
SELECT ul.name, ul.birthYear, ul.addr
	FROM userlist AS ul INNER JOIN userbuy AS ub
	ON ul.userID = ub.userID AND ub.prodName = "책" GROUP BY ul.name;
