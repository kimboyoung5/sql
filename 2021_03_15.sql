2021-03-12 복습
조건에 맞는 데이터 조회 : WHERE 절 - 기술한 조건을 참(TRUE)으로 만족하는 행들만 조회한다(FILTER);

--ROW : 14개, CCL : 8개 
SELECT *
FROM emp
WHERE 1=1;

SELECT *
FROM emp
WHERE deptno = deptno;

SELECT *
FROM emp
WHERE deptno != deptno;

int a = 20;
String a = "20";
 '20'

SELECT 'SELELCT * FROM ' || table_name || ';'
FROM user_tables;

'81/03/01' 

TO_DATE('81/03/01' , 'YY/MM/DD')

-- 입사일자가 1982년 1월 1일 이후인 모든 직원 조회 하는 SELECT 쿼리를 작성하세요. 

30 > 20 : 숫자 > 숫자
날짜 > 날짜 
2021-03-15 > 2021-03-12

SELECT *
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01', 'YYYY/MM/DD');
--WHERE hiredate >= TO_DATE('19820101', 'YYYYMMDD');
--WHERE hiredate >= TO_DATE('1982-01-01', 'YYYY-MM-DD');
--WHERE hiredate >= TO_DATE('82-01-01', 'YY-MM-DD'); (X)
--YY는 값과 관계없이 현재 서버 날짜의 년도 앞 두자리를 사용한다. 2082년으로 이해된다.

WHERE절에서 사용 가능한 연산자
(비교 ( =, !=, >, <.....)

a + b; 2항연산자 

a++ == a + 1; 단항연산자 
++a == a + 1;

비교대상 BETWEEN 비교대상의 허용 시작값 AND 비교대상의 허용 종료값 
ex : 부서번호 10번에서 20번 사이의 속한 지원들만 조회
SELECT *
FROM emp
WHERE deptno BETWEEN 10 AND 20;

emp 테이블에서 급여가(sal)가 1000보다 크거나 같고 2000보다 작거나 같은 직원들만 조회
    sal >= 1000 AND
    sal <= 2000
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

true AND true ==> true 
true AND false ==> false

true Or false ==> true 

SELECT *
FROM emp
WHERE sal >= 1000 
    AND sal <= 2000
    AND deptno = 10; 
    
조건에 맞는 데이터 조회하기 (BETWEEN AND 실습 WHERE1)
emp 테이블에서 입사 일자가 1982년 1월 1일 이후부터 1983년 1월 1일 이전인 사원의 ename, hiredate 데이터를 조회하는 쿼리를 작성하시오 
단 연산자는 between을 사용한다. 
SELECT *
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982-1-1','YYYY-MM-DD') AND TO_DATE('1983-1-1','YYYY-MM-DD') ;

BETWEEN AND : 포함(이상, 이하)
              초과, 미만의 개념을 적용하려면 비교연산자를 사용해야 한다.

IN 연산자
대상자 IN (대상자와 비교할 값1, 대상자와 비교할 값2, 대상자와 비교할 값3....)
deptno IN (10,20) ==> deptno값이 10번이나 20번이면 TRUE;

SELECT *
FROM emp
WHERE deptno = 10 
    OR deptno = 20;

SELECT *
FROM emp
WHERE 10 IN (10,20);  

10은 10과 같거나 20과 같다. 
     TRUE    OR    FALSE => TRUE

조건에 맞는 데이터 조회하기 (IN 실습 WHERE3)
users 테이블에서 userid가 brown, cony, sally인 데이터를 다음과 같이 조회 하시오 (IN 연산자 사용)


SELECT userid AS 아이디, usernm AS 이름, alias AS 별명 
FROM users
WHERE userid IN('brown', 'cony', 'sally');

SELECT * 
FROM users
WHERE userid = 'brown' OR userid = 'cony' OR userid = 'sally';

키워드는 대소문자를 가리지 않지만 데이터의 값은 대소문자를 가린다. 
IN은 2항연산자 

LIKE 연산자 : 문자열 매칭 조회
게시글 : 제목 검색, 내용 검색
        제목에 [맥북에어]가 들어가는 게시글만 조회
        
        1. 얼마 안된 맥북에어 팔아요
        2. 맥북에어 팔아요
        3. 팝니다 맥북에어

테이블 : 게시글
제목 컬럼 : 제목
SELECT * 
FROM 게시글
WHERE 제목 LIKE '%맥북에어%';

SELECT * 
FROM 게시글
WHERE 제목 LIKE '%맥북에어%' 
    OR 내용 LIKE '%맥북에어%';

제목        내용
1.         2.
TRUE   OR  TRUE  TRUE
TRUE   OR  FALSE TRUE
FALSE  OR  TRUE  TRUE
FALSE  OR  FALSE FALSE

제목        내용
1.         2.
TRUE   AND  TRUE  TRUE
TRUE   AND  FALSE FALSE
FALSE  AND  TRUE  FALSE
FALSE  AND  FALSE FALSE

% : 0개 이상의 문자  
_ : 1개의 문자 
    C?????? C% 
userid가 c로 시작하는 모든 사용자
SELECT * 
FROM users
WHERE userid LIKE 'c%';

userid가 c로 시작하면서 c 이후에 3개의 글자가 오는 사용자
SELECT * 
FROM users
WHERE userid LIKE 'c___';

userid에 l(알파벳)이 들어가는 모든 사용자 조회 

SELECT * 
FROM users
WHERE userid LIKE '%l%';

조건에 맞는 데이터 조회하기 (LIKE, %, 실습 WHERE4)
member 테이블에서 회원의 성이 [신]씨의 사람이 mem_id, mem_name 을 조회하는 쿼리를 작성하시오
성이 신씨인 사람 mem_name의 첫글자가 신이고 뒤에는 뭐가 와도 상관없다. 

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';

조건에 맞는 데이터 조회하기 (LIKE, %, 실습 WHERE5)
member 테이블에서 회원의 이름에 글자[이]가 들어가는 모든 사람의 mem_id, mem_name을 조회하는 쿼리를 작성하시오

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%';

IS (NULL 비교)
emp 테이블에서 sal 컬럼의 값이 NULL인 사람만 조회
SELECT *
FROM emp
WHERE comm = null;
쿼리 자체는 실행되지만 원하는 값은 안나온다.  NULL은 동등비교연산자 사용불가. NULL은 0이 아니라 값을 모르는 경우이다. 

SELECT *
FROM emp
WHERE comm IS NULL;

SELECT *
FROM emp
WHERE comm IS NOT NULL;
      sal = 1000
      sal != 1000

emp 테이블에서 매니저가 없는 직원만 조회 
SELECT *
FROM emp
WHERE mgr IS NULL;

BETWWEN AND, IN, LIKE, IS

논리연산자 : AND, OR, NOT
AND : 두가지 조건을 동시에 만족시키는지 확인할 때
      조건1 AND 조건2
OR : 두가지 조건 중 하나라도 만족시키는지 확인할 때
      조건1 OR 조건2
NOT : 부정형 논리연산자, 특정 조건을 부정 
        mgr IS NULL : mgr 컬럼의 값이 NULL인 사람만 조회
        mgr IS NOT NULL : mgr 컬럼의 값이 NULL인 아닌 사람만 조회

emp 테이블에서 mgr의 사번이 7698이면서
sal값이 1000보다 큰 직원만 조회;

SELECT *
FROM emp
WHERE mgr = 7698 
    AND sal > 1000;

--조건의 순서는 무관하다.
SELECT *
FROM emp
WHERE sal > 1000
    AND mgr = 7698 ;

-- SAL컬럼의 값이 1000보다 크거나 mgr의 사번이 7698인 직원 조회
SELECT *
FROM emp
WHERE sal > 1000
    OR mgr = 7698 ;

AND 조건이 많아지면 : 조회되는 데이터 건수는 줄어든다.
OR 조건이 많아지면 : 조회되는 데이터 건수는 많아진다.

NOT : 부정형 연산자, 다른 연산자와 결합하여 쓰인다.
        IS NOT, NOT IN, NOT LIKE 

SELECT *
FROM emp
WHERE deptno != (30);

SELECT *
FROM emp
WHERE deptno NOT IN (30);

SELECT * 
FROM emp
WHERE ename NOT LIKE 'S%'

NOT IN 연산자 사용시 주의점 : 비교값 중에 NULL이 포함되면 데이터가 조회되지 않는다. 
SELECT *
FROM emp
WHERE mgr IN (7698, 7839, NULL);  // KING이 안나온다. 
==> 
    시험 ★ mgr = 7698 OR mgr = 7839, mgr = NULL
    
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839, NULL); // 값이 안나온다. 
==>
    시험 ★ mgr != 7698 AND mgr != 7839 AND mgr != NULL)
             TRUE FALSE 의미가 없음 AND FALSE 

논리연산 (AND,OR 실습 WHERE7)
emp 테이블에서 job이 SALESMAN이고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요.

SELECT *
FROM EMP
WHERE job = 'SALESMAN' 
    AND hiredate >= TO_DATE('1981-06-01','YYYY-MM-DD');

논리연산 (AND,OR 실습 WHERE8)
emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요.
(IN, NOT IN 연산자 사용금지)

SELECT *
FROM EMP
WHERE deptno != 10 --deptno NOT IN (10) 
    AND hiredate >= TO_DATE('1981-06-01','YYYY-MM-DD');
    
논리연산 (AND,OR 실습 WHERE10)
emp 테이블에서 부서번호가 10번이 아니고 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회하세요.
(부서 10, 20, 30 만 있다고 가정하고 IN 연산자를 사용)

SELECT *
FROM emp 
WHERE deptno IN(20, 30) --deptno NOT IN (10) 
    AND hiredate >= TO_DATE('1981-06-01','YYYY-MM-DD');

논리연산 (AND,OR 실습 WHERE11)
emp 테이블에서 job이 SALESMAN이거나 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요.
SELECT *
FROM emp
WHERE JOB = 'SALESMAN' 
    OR hiredate >= TO_DATE('1981-06-01','YYYY-MM-DD');

논리연산 (AND,OR 실습 WHERE12)
emp 테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하는 직원의 정보를 다음과 같이 조회 하세요.
SELECT *
FROM emp
WHERE job = 'SALESMAN' 
    OR empno LIKE '78%';
    
empno는 column의 type이 숫자인데 묵시적으로 형변환이 일어나 오류가 일어나지 않고 작동.

논리연산 (AND,OR 실습 WHERE13) 
emp 테이블에서 job이 SALESMAN이거나 사원번호가 78로 시작하는 직원의 정보를 다음과 같이 조회 하세요.
12번문제를 LIKE연산자 사용하지 않고 풀기. 
힌트는 데이터타입
SELECT *
FROM emp
WHERE job = 'SALESMAN'
    OR empno between 7800 and 7899;
