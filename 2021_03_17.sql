WHERE 조건1 : 10건
WHERE 조건1
  AND 조건2 : 10건을 넘을 수 없음
  
Function 
Single row function 
- 단일 행을 기준으로 작업하고 행당 하나의 결과를 반환
- 특정 컬럼의 문자열 길이 : length(ename)

Multi row function
-여러 행을 기준으로 작업하고 하나의 결과를 반환 
-그룹함수 : count, sum, avg 

함수명을 보고
1. 파라미터가 어떤게 들어갈까?
2. 몇개의 파라미터가 들어갈까?
3. 반환되는 값은 무엇일까?

chracter 
*대소문자
LOWER 
UPPER  
INITCAP 

SELECT * | {column | expression}

SELECT ename, LOWER(ename), UPPER(ename), INITCAP(ename)
FROM emp; //데이터를 소문자로 변경

chracter 
*문자열 조작
CONCAT 
SUBSTR 
LENGTH 
INSTR
LPAD | RPAD
TRIM
REPLACE


SELECT ename, SUBSTR(ename, 1, 3), SUBSTR(ename, 2), REPLACE(ename, 'S', 'T')
FROM emp;
--SUBSTR(ename, 2) 2번째 글자부터 출력

DUAL Table
sys계정에 있는 테이블
누구나 사용 가능
DUMMY 컬럼 하나만 존재하며 값은 'X'이며 데이터는 한 행만 존재

사용용도
데이터와 관련 없이 
함수 실행
시퀀스 실행
merge문에서 (insert + update)
데이터 복제시(connect by level)

SELECT *
FROM dual; 

SELECT LENGTH('TEST')
FROM emp; 

SELECT LENGTH('TEST')
FROM dual
CONNECT BY LEVEL <= 10;

SINGLE ROW FUNCTION : WHERE 절에서도 사용 가능
emp 테이블에 등록된 직원들 중에 직원의 이름의 길이가 5글자를 초과하는 직원만 조회 

SELECT *
FROM emp
WHERE LENGTH(ename) > 5;

SELECT *
FROM emp
WHERE LOWER(ename) = 'smith'; // 컬럼을 가공하는 것은 권장되지 않는다.

SELECT *
FROM emp
WHERE ename = UPPER('smith');

엔코아 ==> 에코아_부사장 : b2en ==> b2en대표컨설턴트 : dbian

Oracle 문자열 함수

SELECT 'HELLO' || ',' || 'WORLD',
        CONCAT('HELLO', CONCAT(', ' ,'WORLD')) AS CONCAT,
        SUBSTR('HELLO, WORLD', 1, 5) SUBSTR,   
        LENGTH('HELLO, WORLD') LENGTH,
        INSTR('HELLO, WORLD', 'O') INSTR,
        INSTR('HELLO, WORLD', 'O', 6) INSTR2,
        -- 문자에서 특정문자가 몇번째에 있는지 -- 몇번째위치부터 찾을지 
        LPAD('HELLO, WORLD', 15, '*') LPAD,
        RPAD('HELLO, WORLD', 15, '*') RPAD,
        REPLACE('HELLO, WORLD', 'O', 'X') REPLACE,
        -- 공백을 제거, 문자열의 앞과 뒷부분에 있는 공백만
        TRIM('   HELLO, WORLD   ') TRIM,
        --D라는 문자열을 삭제한다. 
        TRIM('D' FROM 'HELLO, WORLD') TRIM
FROM dual;

number
*숫자 조작
ROUND 반올림
TRUNC 
MOD 

JAVA 10%3 => 1

SELECT MOD(10, 3)
FROM dual;

SELECT
ROUND(105.54, 1) round1, -- 반올림 결과가 소수점 첫번째 자리까지 나오도록 : 소수점 둘째 자리에서 반올림 : 105.5
ROUND(105.55, 1) round2, -- 반올림 결과가 소수점 첫번째 자리까지 나오도록 : 소수점 둘째 자리에서 반올림 : 105.6
ROUND(105.55, 0) round3, -- 반올림 결과 첫번째 자리까지 나오도록 : 소수점 첫째 자리에서 반올림 : 106
ROUND(105.55, -1) round4, -- 반올림 결과 두번째 자리(십의자리)까지 나오도록 : 정수 첫째 자리에서 반올림 : 110
ROUND(105.55) round5
FROM dual;

SELECT
TRUNC(105.54, 1) trunc1, -- 절삭 결과가 소수점 첫번째 자리까지 나오도록 : 소수점 둘째 자리에서 절삭 : 105.5
TRUNC(105.55, 1) trunc2, -- 절삭 결과가 소수점 첫번째 자리까지 나오도록 : 소수점 둘째 자리에서 절삭 : 105.5
TRUNC(105.55, 0) trunc3, -- 절삭 결과 첫번째 자리까지 나오도록 : 소수점 첫째 자리에서 절삭 : 105
TRUNC(105.55, -1) trunc4, -- 절삭 결과 두번째 자리(십의자리)까지 나오도록 : 정수 첫째 자리에서 절삭 : 100
TRUNC(105.55) trunc5 --두번째 인자를 생략하면 TRUNC(105.55, 0)과 동일한 값
FROM dual;

--ex : 7499, ALLEN, 1600, 1, 600
SELECT empno, ename, sal, sal을 1000으로 나눴을 때의 몫, sal을 1000으로 나눴을 때의 나머지
FROM emp;

SELECT empno, ename, sal, TRUNC(sal/1000), MOD(sal,1000) 
FROM emp;

날짜 <--> 문자 
서버의 현재 시간 : SYSDATE 
LENGTH('TEST')
SYSDATE //인자가 없으면 괄호를 붙이지 않는다. 

SELECT SYSDATE + 1, SYSDATE + 1/24, SYSDATE + 1/24/60, SYSDATE + 1/24/60/60 
FROM dual; 
--정수가 일수로 계산이 된다.
--1/24 1시간

Function (date 실습 fn1)
1. 2019년 12월 31일을 date형으로 표현
2. 2019년 12월 31일을 date형으로 표현하고 5일 이전 날짜
3. 현재 날짜
4. 현재 날짜에서 3일 전 값

위 4개 컬럼을 생성하여 다음과 같이 조회하는 쿼리를 작성하세요.
SELECT TO_DATE('2019-12-31','YYYY-MM-DD') LASTDAY,
       TO_DATE('2019-12-31','YYYY-MM-DD') - 5 LASTDAY_BEFORE5,
       SYSDATE NOW,
       SYSDATE-3 NOW_BEFORE3
FROM dual; 

TO_DATE : 인자-문자, 문자의 형식
TO_CHAR : 인자-날짜, 문자의 형식 

NLS : YYYY/MM/DD HH24:MI:SS
--52~53 
--0-일요일 1-월요일 2-화요일 ....6-토요일

SELECT SYSDATE, TO_CHAR(SYSDATE, 'IW'), TO_CHAR(SYSDATE, 'D')
FROM dual;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')
FROM dual;

*date
FORMAT
YYYY : 4자리 년도
MM : 2자리 월
DD : 2자리 일자
D : 주간일차(1~7)
IW : 주차(1~53)
HH, HH12 : 2자리 시간(12시간 표현)
HH24 : 2자리 시간(24시간 표현)
MI : 2자리 분
SS : 2자리 초

Function (date 실습 fn2) 
오늘 날짜를 다음과 같은 포맷으로 조회하는 쿼리를 작성하시오
1. 년-월-일
2. 년-월-일 시간(24)-분-초
3. 일-월-년

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') DT_DASH,
       TO_CHAR(SYSDATE, 'DD-MM-YYYY HH24:MI:SS') DT_DASH_WITH_TIME,
       TO_CHAR(SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY
FROM dual;

TO_DATE(문자열, 문자열 포맷)

TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD'), 'YYYY-MM-DD')
FROM dual;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') DT_DASH
FROM dual;

'2021-03-17' ==> '2021-03-17 12:41:00'
SELECT TO_CHAR(TO_DATE('2021-03-17', 'YYYY-MM-DD'), 'YYYY-MM-DD HH24:MI:SS')
FROM dual;

SELECT SYSDATE TO_DATE(TO_CHAR(SYSDATE-5, 'YYYYMMDD'), 'YYYYMMDD')
FROM dual;
