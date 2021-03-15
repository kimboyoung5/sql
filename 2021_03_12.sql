
sem계정에 있는 prod 테이블의 모든 컬럼을 조회하는 SELECT 쿼리(SQL)작성
SELECT *
FROM prod;

sem계정에 있는 prod 테이블의 prod_id, prod_name 두개의 컬럼만 조회하는 SELECT 쿼리(SQL)작성
SELECT prod_id, prod_name 
FROM prod;

select1]

lprod 테이블에서 모든 테이터를 조회하는 쿼리를 작성하세요
SELECT * 
FROM lprod;

buyer 테이블에서 buyer_id, buyer_name 컬럼만 조회하는 쿼리를 작성하세요
SELECT buyer_id, buyer_name
FROM buyer;

cart 테이블에서 모든 데이터를 조회하는 쿼리를 작성하세요
SELECT * 
FROM cart;

 member 테이블에서 mem_id, mem_pass, mem_name 컬럼만 조회하는 쿼리를 작성하세요
SELECT mem_id, mem_pass, mem_name
FROM member;

컬럼 정보를 보는 방법
1. SELECT * ==> 컬럼의 이름을 알 수 있다.
2. SQL DEVELPOPER의 데이터 객체를 클릭하여 정보확인
3. DESC 테이블명;

DESC emp;

숫자, 날짜에서 사용가능한 연산자
일반적인 사칙연산 + - / *, 우선순위 연산자 () 

empno : number ; ==> expression 
SELECT empno empnuber , empno + 10 emp_plus , 10, hiredate, hiredate -10 
FROM emp;

ALIAS : 컬럼의 이름을 변경 
        컬럼  expression [AS] [별칭명] 
SELECT empno empno, empno + 10 AS emp_plus
FROM emp;

NULL :  아직 모르는 값
        0과 공백은 NULL과 다르다
        **** NULL을 포함한 연산은 결과가 항상 NULL ****
        => NULL 값을 다른 값으로 치환해주는 함수
        
SELECT ename, sal, comm, sal + 100, comm + 100 
FROM emp;

select2]
prod 테이블에서 prod_id, prod_name 두 컬럼을 조회하는 쿼리를 작성하시오.
(단 prod_id -> id, prod_name -> name 으로 컬럼 별칭을 지정)   
 
SELECT prod_id id, prod_name name 
FROM prod;

lprod 테이블에서 lprod_gu, lprod_nm 두 컬럼을 조회하는 쿼리를 작성하시오.
(단 lprod_gu -> gu lprod_nm -> nm으로 컬럼 별칭을 지정)

SELECT lprod_gu AS gu, lprod_nm AS nm
FROM lprod;

buyer 테이블에서 buyer_id, buyer_name 두 컬럼을 조회하는 쿼리를 작성하시오
(단 buyer_id -> 바이어아이디, buyer_id -> 이름으로 컬럼 별칭을 지정)

SELECT buyer_id 바이어아이디, buyer_name 이름
FROM buyer;

literal : 값 자체
literal 표기법: 값을 표현하는 방법

java 정수 값을 어떻게 표현할까?
int a = 10;
float f = 10f;
long l = 10L;
String s = "Hello world";

* | {컬럼|표현식 [As] [Alias], ...}
SELECT empno, 10, Hello World
FROM emp;

문자열 연산
java : String msg = "Hello" + ", World" ;

SELECT empno + 10, ename || ', World', CONCAT(ename, ', world'),  ename || 'Hello' || ', World' 
        결합할 두개의 문자열을 입력받아 결합하고 결합된 문자열을 반환한다.
        CONCAT(문자열1, 문자열2, 문자열3)
        CONCAT(문자열1과 문자열2가 결합된 문자열, 문자열3) 
        CONCAT((문자열1, 문자열2), 문자열3) 
FROM emp;

DESC emp;

아이디 : brown
아이디 : apeach
.
.

SELECT '아이디 : ' || userid, 
        CONCAT('아이디 : ', userid)
FROM users;

SELECT table_name
FROM user_tables;


SELECT 'SELECT * ' || 'FROM ' || table_name || ';',
        CONCAT(CONCAT('SELECT * FROM ', table_name), ';')
        
FROM user_tables;

SELECT *
FROM emp
WHERE deptno = 10 ;

-- users 테이블에서 usserid 컬럼의 값이 brown인 사용자만 조회
--*** SQL 키워드는 대소문자를 가리지 않지만 데이터 값은 대소문자를 가린다. 
SELECT *
FROM users
WHERE userid = 'brown' ;

--emp 테이블에서 부서번호가 20번보다 큰 부서에 속한 직원 조회
SELECT *
FROM emp
WHERE deptno > 20;

--emp 테이블에서 부서번호가 20번이 아닌 모든 직원 조회
SELECT *
FROM emp
WHERE deptno != 20;

WHERE : 기술한 조건을 참(TRUE)으로 만족하는 행들만 조회한다.(FILTER)

SELECT *
FROM emp
WHERE 1=2;

SELECT empno, ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('1981/03/01', 'YYYY/MM/DD');


문자열을 날짜 타입으로 변환하는 방법
TO_DATE (날짜 문자열, 날짜 문자열의 포맷팅)
TO_DATE ('1981/12/11', 'YYYY/MM/DD') 

