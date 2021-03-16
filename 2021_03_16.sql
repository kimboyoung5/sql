SELECT *
FROM emp
WHERE hiredate TO_DATE('1981/06/01','YYYY/MM/DD');

연산자 우선순위 (AND가 OR보다 우선순위가 높다.)
==> 헷갈리면 ()를 사용하여 우선순위를 조정하자

SELECT *
FROM emp
WHERE ename = 'SMITH' OR (ename = 'ALLEN' AND job = 'SALESMAN');
              1        +         2        *         3

==> 직원의 이름이 ALLEN 이면서 job이 SALESMAN 이거나
    직원의 이름이 SMITH인 직원 정보를 조회 

직원의 이름이 ALLEN 이거나 SMITH이면서
job이 SALESMAN인 직원을 조회 

SELECT *
FROM emp
WHERE (ename = 'SMITH' OR ename = 'ALLEN') AND job = 'SALESMAN';

논리연산 (AND,OR 실습 WHERE14)
emp테이블에서
1. job이 SALESEMAN이거나
2. 사원번호가 78로 시작하면서 입사일자가 1981년 6월 1일 이후인 직원의 정보를 다음과 같이 조회 하세요.
(1번 조건 또는 2번 조건을 만족하는 직원)

SELECT *
FROM emp
WHERE empno like '78%' AND hiredate >= TO_date('1981-06-01','yyyy-mm-dd') OR job = 'SALESMAN' ;

데이터 정렬이 필요한 이유?
1. table 객체는 순서를 보장하지 않는다.
 ==> 오늘 실행한 쿼리를 내일 실행할 경우 동일한 순서로 조회가 되지 않을 수도 있다.
2. 현실세계에서는 정렬된 데이터가 필요한 경우가 있다.
 ==> 게시판의 게시글은 보편적으로 가장 최신글이 처음에 나오고, 가장 오래된 글이 맨 밑에 있다.

SQL 에서 정렬 : ORDER BY : SELECT -> FROM -> [WHERE] -> ORDER BY
정렬 방법 : ORDER BY 컬럼명 | 컬럼인덱스(순서) | 별칭 [정렬순서]
정렬 순서 : 기본 ASC(오름차순), DESC(내림차순)
SELECT *
FROM emp
ORDER BY ename;

SELECT *
FROM emp
ORDER BY ename DESC;

A -> B -> C -> D -> Z
1 -> 2 -> .... -> 100 : 오름차순 (ASC => DEFAULT)
100 -> 99 .... -> 1 : 내림차순 (DESC => 명시)

SELECT *
FROM emp
ORDER BY job DESC, sal ASC, ename; //job을 기준으로 정렬한 후, job이 같다면 sal로 2차정렬

정렬 : 컬럼명이 아니라 select 절의 컬럼 순서 (index)

SELECT *
FROM emp
ORDER BY 2 ; //2번째 컬럼으로 정렬하라

SELECT empno, job, mgr
FROM emp
ORDER BY 2 ; // SELECT절을 변경하면 의도와 다른 결과가 나올 수 있다. 

SELECT empno, job, mgr AS m  // AIIAS 명칭으로 정렬이 가능
FROM emp
ORDER BY m 

데이터 정렬( ORDER BY 실습 orderby1 )
*dept테이블의 모든 정보를 부서이름으로 오름차순 정렬로 조회되도록 쿼리를 작성하세요
SELECT *
FROM dept
ORDER BY dname;

*dept테이블의 모든 정보를 부서위치로 내림차순 정렬로 조회되도록 쿼리를 작성하세요
SELECT *
FROM dept
ORDER BY LOC DESC;

데이터 정렬( ORDER BY 실습 orderby2 )
emp테이블에서 상여(comm)정보가 있는 사람들만 조회하고, 상여(comm)를 많이 받는 사람이 먼저 조회되도록 정렬하고,
상여가 같을 경우 사번으로 내림차순 정렬하세요(상여가 0인 사람은 상여가 없는 것으로 간주)

SELECT *
FROM emp
WHERE comm IS NOT NULL 
    AND comm != 0
ORDER BY comm DESC, empno DESC;

SELECT *
FROM emp
WHERE comm > 0
ORDER BY comm DESC, empno DESC;

데이터 정렬( ORDER BY 실습 orderby3 )
emp테이블에서 관리자가 있는 사람들만 조회하고, 직군(job)순으로 오름차순 정렬하고,
직군이 같을 경우 사번이 큰 사원이 먼저 조회되도록 쿼리를 작성하세요.

SELECT *
FROM emp
WHERE mgr IS NOT NULL 
ORDER BY job, empno DESC;

데이터 정렬( ORDER BY 실습 orderby4 )
emp테이블에서 10번 부서(deptno) 혹은 30번 부서에 속하는 사람 중 급여가(sal)가 1500이 넘는 사람들만 조회하고
이름을 내림차순 정렬되도록 쿼리를 작성하세요.

SELECT *
FROM emp
WHERE deptno in(10, 30) 
    AND SAL >= 1500
ORDER BY ename DESC;

SELECT *
FROM emp
WHERE deptno = 10 OR deptno = 30
    AND SAL >= 1500
ORDER BY ename DESC;

페이징 처리 : 전체 데이터를 조회하는게 아니라 페이지 사이즈가 정해졌을 때 원하는 페이지의 데이터만 가져오는 방법
(1. 400건을 다 조회하고 필요한 20건만 사용하는 방법 --> 전체조회(20)
 2. 400건의 데이터 중 원하는 페이지의 20건만 조회 --> 페이징 처리(20) )
 
페이징처리(게시글) ==> 정렬의 기준이 뭔데??? (일반적으로는 게시글의 작성일시 역순)
페이징 처리시 고려할 변수 : 페이지 번호, 페이지 사이즈

ROWNUM : 행번호를 부여하는 특수 키워드(오라클에서만 사용) 
    * 제약사항
    ROWNUM은 WHERE절에서도 사용가능하다.
    단 ROWNUM의 사용을 1부터 사용하는 경우에만 사용 가능
    WHERE ROWNUM BETWEEN 1 AND 5; ==> O
    WHERE ROWNUM BETWEEN 6 AND 10; ==> X
    WHERE ROWNUM = 1; ==> O
    WHERE ROWNUM = 2; ==> X
    WHERE ROWNUM < 10; ==> O
    WHERE ROWNUM > 10; ==> X
    
    SQL 절은 다음의 순서로 실행된다.
    FROM  => WHERE => SELECT => ORDER BY 
    ORDER BY와 ROWNUM을 동시에 사용하면 정렬된 기준으로 ROWNUM이 부여되지 않는다. 
    (SELECT절이 먼저 실행되므로 ROWNUM이 부여된 상태에서 ORDER BY절에 의해 정렬된다.)
전체 데이터 : 14건 
페이지사이즈 : 5건
1번째 페이지 : 1 ~ 5
2번째 페이지 : 6 ~ 10
3번째 페이지 : 11 ~ 15(14)


인라인 뷰: 테이블을 임의대로 만드는 것 

ALIAS

SELECT ROWNUM, empno, ename
FROM emp; // 툴에서 표기하는 행번호를 첫번째 컬럼으로 가져올 수 있다. 

SELECT ROWNUM, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10; 

FROM  => SELECT => ORDER BY 
SELECT ROWNUM, empno, ename
FROM emp
ORDER BY ename; //  ROWNUM의 번호가 뒤죽박죽이 된다.   

(SELECT empno, ename
FROM emp); // 괄호로 묶으면 하나의 테이블로 인식하게 된다. FROM절에 올 수 있다. 

SELECT ROWNUM, empno, ename
FROM (SELECT empno, ename
    FROM emp
    ORDER BY ename) // 

(SELECT ROWNUM, empno, ename
FROM (SELECT empno, ename
    FROM emp
    ORDER BY ename)) // 괄호로 묶으면 하나의 테이블로 인식

SELECT * 
FROM 
(SELECT ROWNUM rn, empno, ename
FROM (SELECT empno, ename
    FROM emp
    ORDER BY ename))
WHERE rn BETWEEN 11 AND 15; 
//★ALIAS로 적용하면 ROWNUM이 아닌 하나의 컬럼으로 인식.1부터 시작을 안해도 실행가능. 

SELECT * 
FROM 
(SELECT ROWNUM rn, empno, ename
FROM (SELECT empno, ename
    FROM emp
    ORDER BY ename))
WHERE rn BETWEEN (:page-1)*:pageSize + 1 AND :page*:pageSize ; 

pageSize : 5건 
1 page :  rn BETWEEN 1 AND 5 ;
2 page :  rn BETWEEN 6 AND 10 ;
3 page :  rn BETWEEN 11 AND 15 ;
n page :  rn BETWEEN n*5-4 AND n*5 ;
n page :  rn BETWEEN n*pageSize-4 AND n*pageSize ;
                    (n-1) * pageSize + 1

rn BETWEEN (page-1)*pageSize + 1 AND page*pageSize ;

n*pageSize-(pageSize - 1)
n*pageSize-pageSize + 1
(n-1)*pageSize + 1

데이터정렬 (가상컬럼 ROWNUM 실습 row_1)
emp테이블에서 ROWNUM 값이 1~10인 값만 조회하는 쿼리를 작성해보세요 (정렬없이 진행하세요) 

SELECT ROWNUM rn, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10;

데이터정렬 (가상컬럼 ROWNUM 실습 row_2)
ROWNUM 값이 11~20(11~14)인 값만 조회하는 쿼리를 작성해보세요
SELECT * 
FROM 
(SELECT ROWNUM rn, empno, ename
FROM (SELECT empno, ename
    FROM emp
    ORDER BY ename))
WHERE rn BETWEEN 11 AND 14; 

데이터정렬 (가상컬럼 ROWNUM 실습 row_3)
emp테이블의 사원 정보를 이름컬럼으로 오름차순 적용 했을 떄의 11~14번째 행을 다음과 같이 조회하는 쿼리를 작성해보세요.
SELECT * 
FROM 
(SELECT ROWNUM rn, empno, ename
FROM 
(SELECT empno, ename
FROM emp
ORDER BY ename)) 
WHERE rn BETWEEN 11 AND 14; 

SELECT ROWNUM, emp.* 
FROM emp; //한정자

SELECT ROWNUM rn, e.* 
FROM emp e; 
테이블에도 alias 를 줄 수 있다. AS 라는 키워드는 사용불가. 

SELECT ROWNUM rn, e.empno 
FROM emp e, emp m ; 
