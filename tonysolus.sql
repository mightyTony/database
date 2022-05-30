DROP TABLE EMPLOYEE;
DROP TABLE DEPARTMENT;
DROP TABLE SALGRADE;

CREATE TABLE DEPARTMENT
        (DNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY,
         DNAME VARCHAR2(14),
	 LOC   VARCHAR2(13) ) ;
CREATE TABLE EMPLOYEE 
        (ENO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
	 ENAME VARCHAR2(10),
 	 JOB   VARCHAR2(9),
	 MANAGER  NUMBER(4),
	 HIREDATE DATE,
	 SALARY NUMBER(7,2),
	 COMMISSION NUMBER(7,2),
	 DNO NUMBER(2) CONSTRAINT FK_DNO REFERENCES DEPARTMENT);
CREATE TABLE SALGRADE
        (GRADE NUMBER,
	 LOSAL NUMBER,
	 HISAL NUMBER );

INSERT INTO DEPARTMENT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPARTMENT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPARTMENT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPARTMENT VALUES (40,'OPERATIONS','BOSTON');

INSERT INTO EMPLOYEE VALUES
(7369,'SMITH','CLERK',    7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7499,'ALLEN','SALESMAN', 7698,to_date('20-2-1981', 'dd-mm-yyyy'),1600,300,30);
INSERT INTO EMPLOYEE VALUES
(7521,'WARD','SALESMAN',  7698,to_date('22-2-1981', 'dd-mm-yyyy'),1250,500,30);
INSERT INTO EMPLOYEE VALUES
(7566,'JONES','MANAGER',  7839,to_date('2-4-1981',  'dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981', 'dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMPLOYEE VALUES
(7698,'BLAKE','MANAGER',  7839,to_date('1-5-1981',  'dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7782,'CLARK','MANAGER',  7839,to_date('9-6-1981',  'dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7788,'SCOTT','ANALYST',  7566,to_date('13-07-1987', 'dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7839,'KING','PRESIDENT', NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMPLOYEE VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981',  'dd-mm-yyyy'),1500,0,30);
INSERT INTO EMPLOYEE VALUES
(7876,'ADAMS','CLERK',    7788,to_date('13-07-1987', 'dd-mm-yyyy'),1100,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7900,'JAMES','CLERK',    7698,to_date('3-12-1981', 'dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMPLOYEE VALUES
(7902,'FORD','ANALYST',   7566,to_date('3-12-1981', 'dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMPLOYEE VALUES
(7934,'MILLER','CLERK',   7782,to_date('23-1-1982', 'dd-mm-yyyy'),1300,NULL,10);

INSERT INTO SALGRADE VALUES (1, 700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

COMMIT;

--------------------------------------------------------------------------------
DESC EMPLOYEE; -- employee 정의

SELECT sysdate FROM dual; --오늘 날짜 

SELECT * FROM employee; 

SELECT eno, ename, job, manager, hiredate, salary, commission, dno FROM green14.employee;

SELECT ename, salary, salary*12 FROM employee;

SELECT ename, salary, salary*12+commission FROM employee;

SELECT ename, salary, salary*12+NVL(commission, 0) AS "연 봉" FROM employee; --NVL(,) commission이 없다면 0

SELECT DNO FROM employee;

SELECT DISTINCT DNO FROM employee; --DISTINCT : 중복 제외

SELECT ename, salary FROM employee WHERE ename='SMITH'; -- ''(o), ""(x)
-- 알고싶다, 이름과 급여를 사원테이블에 있는 이름이 스미스인 사람.

SELECT * FROM employee WHERE salary <= 1500;

SELECT * FROM employee WHERE ename != 'SMITH';

SELECT * FROM employee WHERE NOT hiredate <= '1981/05/31' AND salary >= 1200;
-- NOT 바로 뒤를 부정

SELECT * FROM employee WHERE salary <=1500 AND salary >= 1000;
SELECT * FROM employee WHERE salary BETWEEN 1000 AND 1500;
-- 급여 1000~1500 사이인 사원을 조회

SELECT * FROM employee WHERE salary <1000 OR salary > 1500;
SELECT * FROM employee WHERE salary NOT BETWEEN 1000 AND 1500;
-- 급여가 1000미만이거나 1500초과인 사원을 조회

SELECT * FROM employee WHERE commission = 300 OR commission = 500 OR commission = 1400;
-- 커미션이 300이거나 500이거나 1400인 사원 조회

SELECT * FROM employee WHERE hiredate BETWEEN '1981/01/01' AND '1981/12/31';
SELECT * FROM employee WHERE commission IN(300,500,1400);
-- 1981년도 입사한 사원의 정보를 조회

-- (IS NULL 값이 null인 것)
SELECT * FROM employee WHERE commission IS NOT NULL;

-- 문자열 일부 일치 검색 LIKE
SELECT * FROM employee WHERE ename LIKE '%A%';
-- %는 글자 개수도 모를 때
-- _는 글자 개수는 알 때
SELECT * FROM employee WHERE ename LIKE '_A%'; --두번째 글자가 A인 사람

SELECT * FROM employee 
WHERE salary >= 1200
ORDER BY ename ASC; -- 오름 차순으로 정렬,

SELECT * FROM employee 
WHERE salary >= 1200
ORDER BY ename DESC; -- 내림 차순 

SELECT * FROM employee 
WHERE salary >= 1200
ORDER BY job DESC, salary ASC; -- JOB으로 정렬, 그 중 같으면 급여로 오름차순 정렬.

------------------------------------------------------------------------------
SELECT ename, hiredate, to_char(hiredate,'YY-MM'), to_char(hiredate,'YYYY/MM/DD DAY')
FROM employee;

SELECT ename, hiredate
FROM employee
WHERE hiredate = to_date(19811117, 'YYYYMMDD');


SELECT ASCII('T'),ASCIISTR('밝'),CHR(84),UNISTR('\BC1D') FROM dual;

SELECT LENGTHC('오라클') FROM dual;

SELECT CONCAT('기초기술','활용'), '기초'||'기술'||'활용' FROM dual;

        --ename + " : " + job
SELECT ename||' : '|| job FROM employee;  

SELECT INSTR('자바에서 문자는 String이고 자바스크립트에서는 문자는 let이다','문자',10) FROM dual;
-- 

SELECT lower('StuDentName') FROM dual;
SELECT upper('StuDentName') FROM dual;
SELECT INITCAP('stuDentName') FROM dual;

SELECT REPLACE('자바에서 문자는 String이고 자바스크립트에서는 문자는 let이다','자바','JAVA') FROM dual;

SELECT TRANSLATE('자바에서 문자는 String이고 자바스크립트에서는 문자는 let이다','자바','JAVA') FROM dual;

SELECT eno,ename,dno FROM employee
WHERE ename='scott';    

SELECT eno,ename,dno FROM employee
WHERE ename=UPPER('scott');

SELECT eno,ename,dno FROM employee
WHERE ename=INITCAP('scott');

SELECT SUBSTR('응용SW기초기술활용',5,4) FROM dual;

SELECT REVERSE('domato') FROM dual;
-- 바이트 단위로 거꾸로 뒤집기

SELECT LPAD('회계',9,'-') FROM dual;

SELECT LPAD('love',9,'--') FROM dual;

SELECT '     자바     'FROM dual;
SELECT LTRIM('     자바     ')FROM dual;
SELECT RTRIM('     자바     ')FROM dual;
SELECT TRIM('     자바     ')FROM dual;
SELECT RTRIM('     자바     ')FROM dual;

SELECT LTRIM('ㅋㅋㅋㅋㅋㅋ 재밌다','ㅋ')FROM dual;
SELECT TRIM(LEADING,'*' FROM '***** 그린 아카데미 *****') FROM dual;
 
SELECT * FROM employ
WHERE SUBSTR(ename, -1,1) = 'N';

SELECT CELL(3.14) , FLOOR(3.14) , ROUND(3.14) FROM dual;

SELECT TRUNC(12345.12765, -2) FROM dual;

SELECT ADD_MONTHS('2022/05/24',-7) FROM dual;

SELECT to_DATE('2022/05/24')+5 FROM dual;

SELECT LAST_DAY('2022/05/24') FROM dual;

SELECT NEXT_DAY('2022/05/24','목요일') FROM dual;

SELECT ROUND(TO_DATE('2022/08/11'),'DY') FROM dual;

SELECT ename, salary, commission, NVL(commission,0), salary*12+NVL(commission,0) FROM employee;

SELECT ename, NVL2(commission,salary*12+commission,salary*12) FROM employee;

SELECT ename,dno,DECODE(dno,10,'교육부',
                            20,'총무',
                            30,'재정부',
                            40,'복지부',
                            '노동부') AS "부서명"
FROM employee;

SELECT ename, dno, CASE WHEN dno=10 THEN '교육부'
                        WHEN dno=20 THEN '총무부'
                        WHEN dno=30 THEN '재정부' 
                        WHEN dno=40 THEN '복지부'
                        ELSE '노동부' 
                        END AS "부서명"
FROM employee;

--01.
SELECT ename, salary, salary+300 FROM employee;
--02.
SELECT ename, salary, salary*12+100 AS "Year" FROM employee ORDER BY "Year" ;
--03.
SELECT ename, salary FROM employee ORDER BY salary ASC;
--04.
SELECT ename, dno FROM employee WHERE eno='7788';
--05.
SELECT ename, salary FROM employee WHERE NOT salary>=2000 AND salary<=3000;
--06.
SELECT ename, dno, hiredate FROM employee WHERE hiredate BETWEEN '1981/02/20' AND '1981/05/01';
--07.
SELECT ename, dno FROM employee WHERE dno=20 OR dno=30 ORDER BY ename DESC;
--08.
SELECT ename, salary, dno FROM employee 
WHERE salary BETWEEN 2000 AND 3000 AND 
dno IN(20,30) ORDER BY ename DESC ;

-------------------ch02-----------------------
--09.
SELECT ename, hiredate FROM employee WHERE hiredate LIKE '%81/%' ;
--10.
SELECT ename, manager FROM employee WHERE manager IS NULL ;
--11.
SELECT ename, salary, commission FROM employee WHERE commission IS NOT NULL ORDER BY salary DESC, commission DESC;
--12.
SELECT ename FROM employee WHERE ename LIKE '__R%';
--13.
SELECT ename FROM employee WHERE (ename LIKE '%A%' AND ename LIKE '%E%');
--14.
SELECT ename, job, salary FROM employee WHERE job IN('CLERK','SALESMAN') AND salary NOT IN(1600,950,1300);
--15.
SELECT ename, salary, commission FROM employee WHERE commission>=500;

-------------------ch04---------------------------
--01.
SELECT SUBSTR(hiredate,4,8) FROM employee;
--02.
SELECT SUBSTR(hiredate,4,8) FROM employee WHERE SUBSTR(hiredate,4,8) LIKE '04%';
SELECT * FROM employee WHERE SUBSTR(hiredate,4,2)='04';
--03.
SELECT ename, MOD(eno,2) FROM employee WHERE MOD(eno,2)=0;
SELECT * FROM employee WHERE MOD(eno,2)=0;
--04.
SELECT TO_CHAR(hiredate,'YY/MM/DD DY')
FROM employee;
--05. 
SELECT  TRUNC(sysdate-TO_DATE('2022/01/01','YYYY/MM/DD'));

SELECT TRUNC(TO_DATE('2022/11/17','YYYY/MM/DD')-sysdate) AS "수능 디데이"
FROM dual;
--06.
SELECT ename, NVL2(manager,manager,0) AS "상관 사번" FROM employee;
--07.DECODE 함수로 직급에 따라 급여를 인상.
--ANALYST 200, SALESMAN 180, MANAGER 150 , CLERK 100
SELECT ename, job, salary,
DECODE(job,'ANALYST',salary+200,
           'SALESMAN', salary+180,
           'MANAGER', salary+150,
           'CLERK', salary+100,
           salary) AS "인상된 급여"
FROM employee;

--------------------------------------------------------------------------
SELECT SUM(salary) AS "급여 총합",
       TRUNC(AVG(salary)) AS "평균 급여",
       MAX(salary) AS "최대 급여",
       MIN(salary) AS "최소 급여"
FROM employee;

SELECT COUNT(ename)
FROM employee;

SELECT COUNT(*)
FROM employee;

SELECT COUNT(commission) 
FROM employee;

SELECT SUM(commission)
FROM employee;

SELECT ename, MIN(salary)
FROM employee;

SELECT dno, job, TRUNC(AVG(salary)) AS "평균 급여"
FROM employee
GROUP BY dno, job
ORDER BY dno ASC, job DESC;

--그룹 결과의 제한 WHERE 대신 HAVING 으로 써야함. (행의 갯수가 안 맞음)
SELECT job, AVG(salary), SUM(salary)
FROM employee
--WHERE AVG(salary) >= 2000;
GROUP BY job
HAVING AVG(salary) >= 2000;

-- 부서별 최고 급여가 3000이상인 부서의 번호 와 해당 부서의 최고 급여를 구하세요.
SELECT dno, MAX(salary)
FROM employee
GROUP BY dno
HAVING MAX(salary)>=3000;

-- 매니저를 제외하고 급여 총액이 5000 이상인 담당 업무별 급여 총액과 해당 인원을 구하세요.
SELECT job, SUM(salary), COUNT(*)
FROM employee
WHERE job != 'MANAGER'
GROUP BY job
HAVING SUM(salary) >= 5000;

--부서별 평균 급여중 최고 평균 급여를 조회하기

SELECT ename, salary
FROM employee
WHERE salary=(SELECT MAX(salary) FROM employee);

SELECT dno, job, SUM(salary)
FROM employee
GROUP BY ROLLUP(dno, job);

--서브 쿼리 
--------------------------------------------------------------------------
--30번 부서의 최고 급여
SELECT MIN(salary)
FROM employee
WHERE dno=30;

--각 부서별 최소급여
SELECT dno, MIN(salary)
FROM employee
GROUP BY dno;

--30번 부서의 최소 급여보다 더 큰 최소급여를 가진 다른 부서
SELECT dno, MIN(salary)
FROM employee
GROUP BY dno
HAVING MIN(salary) > (SELECT MIN(salary)
                      FROM    employee
                      WHERE dno=30);
-- 세일즈맨 보다 급여가 낮은 사원
SELECT salary
FROM employee
WHERE job='SALESMAN';

SELECT ename, salary
FROM employee
WHERE salary < ALL (SELECT salary
                    FROM employee
                    WHERE job = 'SALESMAN') --1250,1500,1600
AND job<>'SALESMAN';

-- ANY 그 중 하나라도 일치하는 것 OR
-- ALL 전체에 무조건 일치하는 것 AND 

-------------------------------ch05 Group Function-----------------------------
--01.
SELECT MAX(salary) AS Maximun, 
       MIN(salary) AS Minimun, 
       SUM(salary) AS Sum, 
       TRUNC(AVG(salary)) AS Average
FROM employee;

--02.
SELECT job, 
       MAX(salary) AS Maximun,
       MIN(salary) AS Minimun,
       SUM(salary) AS Sum,
       TRUNC(AVG(salary)) AS Average
FROM employee
GROUP BY job;

--03.
SELECT job, COUNT(job)
FROM employee
GROUP BY job;

--04.
SELECT job, COUNT(MANAGER)
FROM employee
GROUP BY job;

SELECT COUNT(DISTINCT(manager))
FROM employee;

--05. 5000-800 = 4200
SELECT MAX(salary)-MIN(salary) AS DIFFERENCE
FROM employee;

--06. 
SELECT job, MIN(salary)
FROM employee
WHERE manager IS NOT NULL
GROUP BY job
HAVING MIN(salary) >= 2000 
ORDER BY MIN(salary) DESC;

--07.
SELECT dno AS DNO, 
       COUNT(dno) AS "Number of PeoPle", 
       ROUND(AVG(salary),2) AS Salary 
FROM employee
GROUP BY dno;

--08. gg decode
SELECT * FROM department;
SELECT dno AS DNO,
       DECODE(dno,10,'ACCOUNTING',
                  20,'RESEARCH',
                  30,'SALES',
                  40,'OPERATIONS') AS DName,
       DECODE(dno,10,'NEW YORK',
                  20,'DALLAS',
                  30,'CHICAGO',
                  40,'BOSTON') AS Location,
       COUNT(*) AS "Number of PeoPle",
       TRUNC(AVG(salary)) AS "Salary"
FROM employee
GROUP BY dno;
       
        
--09. gg 
SELECT job, dno, --부서의 10번 총합, 부서 20번의 총합, 30번의 총합 , SUM(salary)
        DECODE(dno,10,SUM(salary)) AS "부서 10",
        DECODE(dno,20,SUM(salary)) AS "부서 20",
        DECODE(dno,30,SUM(salary)) AS "부서 30",
        SUM(salary) AS "총액"
FROM employee
GROUP BY job, dno;




--------------------------CH6 QUIZ----------------------------------------------
SELECT * FROM employee;

--01.사원 번호가7788인 사원과 담당업무가같은 사원을 표시(사원이름과담당업무)하세요

SELECT ename, job
FROM employee
WHERE job = (SELECT job 
             FROM employee
             WHERE eno = 7788);
             
--02.사원번호가7499인 사원보다급여가 많은 사원을 표시(사원이름과담당업무)하세요

SELECT eno, job , salary
FROM employee
WHERE salary > ( SELECT salary
                 FROM   employee
                 WHERE eno = 7499 );
                 
--03. 최소 급여를 받는 사원의 이름, 담당업무및 급여를 표시하세요(그룹함수)
SELECT ename, job, salary
FROM employee
WHERE salary = (SELECT MIN(salary)
                FROM employee);

--04. 평균 급여가 가장 적은 업무를 찾아 직급과 평균 급여를 표시하세요
SELECT job, AVG(salary)
FROM employee
GROUP BY job
HAVING AVG(salary) = (SELECT MIN(AVG(salary))
                      FROM employee
                      GROUP BY job);

--05. 각 부서의 최소급여를받는 사원 이름,급여, 부서번호를표시하세요.
SELECT ename, salary, dno
FROM employee
WHERE salary = ANY(SELECT MIN(salary) FROM employee GROUP BY dno);

SELECT ename, salary, dno
FROM employee
WHERE salary IN(SELECT MIN(salary) FROM employee GROUP BY dno);


--06. 담당업무가분석가(ANALYST)인사원보다급여가 적으면서 업무가 분석가(ANALYST)아닌
--    사원(사원번호, 이름, 담당업무,급여)들을 표시하세요
SELECT eno,ename,job,salary
FROM employee
WHERE salary < ANY(SELECT salary 
                    FROM employee
                    WHERE job != 'ANALYST')
AND job<>'ANALYST'; -- job != 'ANALYST'

--07. 매니저 없는 사원의 이름을 표시하세요
SELECT ename,manager
FROM employee
WHERE ename = (SELECT ename FROM employee WHERE manager is null);

--08 매니저 있는 사원의 이름을 표시하세요
SELECT ename,manager
FROM employee
WHERE ename = ANY(SELECT ename FROM employee WHERE manager is not null);

--09 BLAKE와동일한 부서에 속한 사원의 이름과 입사일을 표시하는질의를 작성하세요.(단BLAKE는제외)
SELECT dno, ename, hiredate
FROM employee
WHERE dno = (SELECT dno FROM employee WHERE ename=('BLAKE')) AND ename != 'BLAKE'; -- ename <> 'BLAKE'

--10. 급여가 평균보다많은 사원들의 사원번호와 이름을 표시하되 결과를 급여에 대한 오름차순으로정렬하세요.
SELECT eno, ename, salary
FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee)
ORDER BY salary ASC;

--11. 이름에K가 포함된 사원과 같은 부서에서일하는 사원의 사원번호와이름을 표시하는질의를 작성하세요.
SELECT eno, ename
FROM employee
WHERE dno = ANY(SELECT dno FROM employee WHERE ename LIKE '%K%' );

--12. 부서위치가DALLAS인 사원의 이름과 부서번호 및 담당업무를표시하세요.
SELECT  eno,e.dno,job
FROM department d INNER JOIN employee e
ON d.dno = e.dno
WHERE d.loc = 'DALLAS';

--13. KING에게 보고하는사원의 이름과 급여를 표시하세요
SELECT ename,salary 
FROM employee
WHERE dno = (SELECT dno FROM employee WHERE ename = 'KING') AND job = 'MANAGER';

SELECT * FROM employee;
--14. RESEARCH 부서의 사원에 대한 부서번호, 사원번호 및 담당업무를출력하세요
SELECT * FROM department;

--15. 평균 급여보다많은 급여를 받고 이름에서M이 포함된 사원과 같은 부서에서
--    근무하는사원의사원번호, 이름, 급여를 출력하세요
SELECT eno,ename,salary
FROM employee
WHERE salary >= (SELECT AVG(salary) 
                    FROM employee)

AND dno IN (SELECT dno 
            FROM employee
            WHERE ename LIKE '%M%');


--16. 평균급여가가능 적은 업무를 찾으세요
SELECT job, AVG(salary)
FROM employee
GROUP BY job
HAVING AVG(salary) = (SELECT MIN(AVG(salary))
                        FROM employee
                        GROUP BY job);

--17. 부하직원을가진 사원의 사원번호와이름을 출력하세요

SELECT eno,ename 
FROM employee
WHERE eno IN (SELECT manager
                FROM employee);
--------------------------------------------------------------------------------
--JOIN
                
--7788사원의 이름과 급여 그리고 부서명을 알고 싶다 => 조인 
SELECT ename, salary, dname
FROM employee
WHERE eno = 7788;

--CATESIAN 조인 테이블1 COL X 테이블2 COL
SELECT * FROM department; --4 col
SELECT * FROM employee;  -- 14 col
SELECT * FROM department,employee; -- 56 col 

--EQUI 조인 중복제거
SELECT * 
FROM department,employee
WHERE department.dno = employee.dno;

--7788사원의 이름과 급여 그리고 부서명을 알고 싶다 => EQUI 조인 이용 
-- 한 테이블에만 있는 건 생략 가능 
SELECT ename, salary, dname
FROM department d, employee e
WHERE d.dno = e.dno
AND e.eno = 7788;

--NATURAL 조인
SELECT *
FROM department NATURAL JOIN employee;

SELECT ename, salary, dname, dno
FROM department d NATURAL JOIN employee e
WHERE e.eno=7788;

--JOIN USING 방식
SELECT *
FROM department JOIN employee
USING(dno)
WHERE eno=7788;

--JOIN ON
SELECT *
FROM department d JOIN employee e
ON d.dno = e.dno
WHERE e.eno=7788;

-- JOIN ON => INNER JOIN (표준)
SELECT *
FROM department d INNER JOIN employee e
ON d.dno = e.dno
WHERE e.eno = 7788;

--------------------------------------------------------------------------------
--NON-EQUI 조인 
SELECT * FROM salgrade;

SELECT e.ename, e.salary, s.grade
FROM employee e, salgrade s
WHERE e.salary BETWEEN s.losal AND s.hisal;

--------------------------------------------------------------------------------
-- 3개의 테이블을 합친 조인
-- 사원의 이름, 소속 부서 이름, 급여와 급여등급을 출력하세요
--      emp        depart           salgrade

SELECT *
FROM employee e, department d, salgrade s
WHERE e.dno=d.dno
AND e.salary > s.losal AND e.salary <= s.hisal;

--------------------------------------------------------------------------------
--SELF 조인

SELECT * FROM employee;

--사원이름과 담당 직장상사의 이름을 같이 출력해 봅시다.

SELECT eno, ename, eno, ename
FROM employee emp, employee manag
WHERE emp.manager = manag.eno;
-------------------------------------------------------------------------------
-- OUTER JOIN (표준)
SELECT * 
FROM department d LEFT OUTER JOIN employee e
ON d.dno=e.dno;

-- 오라클에서의 OUTER 조인 => null을 표시하고자 하는 테이블의 조건에 * 표시
--                          +가 표시 안된 테이블이 기준
SELECT * 
FROM department d, employee e
WHERE d.dno=e.dno(+);

-- 사원이름과 담당 직상상사의 이름을 같이 출력해 봅시다
-- 다만 상관 번호가 없는경우 그냥(NULL)을 출력한다

SELECT emp.eno, emp.ename, manag.eno, manag.ename
FROM employee emp, employee manag
WHERE emp.manager = manag.eno(+);

SELECT emp.eno, emp.ename, manag.eno, manag.ename
FROM employee emp LEFT OUTER JOIN employee manag
ON emp.manager = manag.eno;

-- 사원이름과 담당 직상상사의 이름을 같이 출력해 봅시다
-- 다만 상관 번호가 없는경우 NULL을 출력한다
-- 부하 직원이 없는 경우도 NULL로 출력한다
SELECT emp.eno, emp.ename, manag.eno, manag.ename
FROM employee emp FULL OUTER JOIN employee manag
ON emp.manager = manag.eno;
--------------------------------------------------------------------------------
-- DML 데이터 조작어 => 실질적으로 튜플의 내용을 변경 => 트랜젝션의 적용을 받는다.
SELECT * FROM employee;
-- INSERT 데이터 삽입
INSERT INTO employee(eno,ename,job,manager,hiredate,salary,commission,dno)
            VALUES(8121,'ALICE','CLERK',7788,sysdate,1200,100,10);
            
INSERT INTO employee(eno,ename,job,manager,hiredate,salary,commission,dno)
VALUES(8231,'KATHERINE','SALESMAN',7698,sysdate,1750,800,30);

--트렌젝션 정상적 종료
COMMIT;

SELECT * FROM employee;

INSERT INTO employee(eno)
VALUES (8500);

INSERT INTO employee(eno,ename)
VALUES (8600,NULL);

CREATE TABLE emp2
AS SELECT * FROM employee;

SELECT * FROM emp2;

CREATE TALBE emp3;
AS SELECT * FROM employee WHERE 0=1;

--INSERT INTO emp3;

-----ch07 조인 quiz -----------------------------------------------------------
--1.   Equi조인을 사용하여SCOTT 사원의  -- 부서번호와부서이름을출력하세요.
SELECT d.dno, dname
FROM department d , employee e
WHERE d.dno = e.dno
AND e.ename = 'SCOTT';

--2. Inner 조인과on연산자를사용하여사원이름과함께
--그 사원이 소속된 부서이름과지역명을출력하세요.
SELECT e.ename, dname, loc
FROM department d INNER JOIN employee e
ON d.dno = e.dno;

SELECT e.ename, dname, loc
FROM department d INNER JOIN employee e
ON d.dno = e.dno;

--3. INNER 조인Using 연산자를사용하여10번 부서에 속하는 
--모든 담당업무의고유 목록을 부서의지역명을포함하여출력하세요.
SELECT job, dname
FROM department d INNER JOIN employee e
USING(dno)
WHERE dno = 10;

SELECT * FROM employee;
SELECT * FROM department;
--4. Natural조인을 사용하여커미션을받는 모든 사원의 이름, 부서이름, 지역명을출력하세요
SELECT ename,dname,loc
FROM employee e NATURAL JOIN department d;

--5. Equal 조인과Wild카드를 사용해서이름에A가포함된 모든 사원의 이름과 부서명을출력하세요,
SELECT ename,dname
FROM employee e, department d
WHERE e.dno = d.dno 
AND ename LIKE '%A%';

--6. Natural 조인을 사용하여NEW York에 근무하는 
--모든 사원의 이름, 업무 부서번호및 부서명을출력하세요.
SELECT ename, dno, dname
FROM employee e NATURAL JOIN department d
WHERE loc = 'NEW YORK';

--7. Self Join을 사용하여사원의 이름및 사원 번호를 
--관리자 이름 및 관리자 번호와 함께 출력하세요. 각 열의 별칭은 사원이름(Employee) 사원번호(emp#) 
--관리자이름(Manager) 관리자번호(Mgr#)
SELECT employee.ename as "사원이름", employee.eno as "사원번호", 
        manager.ename as "관리자이름", manager.eno as "관리자번호"
FROM employee employee, employee manager
WHERE employee.manager = manager.eno;

--8.   Outter조인self 조인을 사용하여관리자가없는 사원을 포함하여사원번호를
--기준으로내림차순 정렬하여클릭하세요각 열의 별칭은 사원이름(Employee)사원번호(emp#)
--관리자이름(Manager)관리자번호(Mgr#)
SELECT emp.eno, emp.ename, manag.eno, manag.ename
FROM employee emp LEFT OUTER JOIN employee manag
ON emp.manager = manag.eno;

SELECT emp.eno, emp.ename, manag.eno, manag.ename
FROM employee emp, employee manag
WHERE emp.manager = manag.eno(+);

SELECT emp.eno, emp.ename, manag.eno, manag.ename
FROM employee emp LEFT OUTER JOIN employee manag
ON emp.manager = manag.eno;

--9. Self조인을 사용하여지정한 사원(SCOTT)의 이름, 부서번호, 지정한 사원과 
--동일한 부서에서근무하는 사원을 출력하세요각 열의 별칭은 이름, 부서번호, 동료로 지정하세요
SELECT e.ename as "이름", e.dno as"부서번호",sec.ename as "동료"
FROM employee e, employee sec
WHERE e.ename = 'SCOTT' AND e.dno= sec.dno;

--10. Self 조인을 사용하여WARD 사원보다늦게 입사한 사원의 이름과 입사일을출력하세요.,
SELECT e.ename,e.hiredate
FROM employee e, employee d
WHERE e.hiredate > ANY(SELECT d.hiredate FROM employee WHERE d.ename = 'WARD');

--11. Self조인을 사용하여관리자보다먼저 입사한모든 사원의 이름 및 
--입사일을관리자의이름 및입사입과함께 출력하세요. 각 열의 별칭은
--사원이름(Ename) 사원입사일(HIERDATE) 관리자 이름(Ename) 관리자 입사입(HIERDATE)로 출력하세요

SELECT e.ename as "사원이름", e.hiredate as "사원입사일",
       m.ename as"관리자 이름",m.hiredate as "관리자 입사일"
FROM employee e, employee m
WHERE e.hiredate < ANY(SELECT m.hiredate FROM employee WHERE m.job = 'MANAGER');

--------------------------------------------------------------------------------

--UPDATE 데이터 변경
--UPDATE 테이블명 SET WHERE
CREATE TABLE emp4
AS SELECT * FROM employee;

SELECT * FROM emp4;

--eno8500의 사원 이름 MARS
UPDATE emp4 SET ename='MARS', job = 'MANAGER' WHERE eno=8500;

UPDATE emp4 SET commission=500;

UPDATE emp4
SET salary = (SELECT losal
              FROM salgrade
              WHERE grade = 1)
WHERE dno is NULL;

-------------------------------------------------------------------------------
-- DELETE 데이터 삭제
-- DELETE FROM 테이블명 WHERE 조건
SELECT * FROM employee;

CREATE TABLE emp5
AS SELECT * FROM employee;

DELETE * FROM emp5
WHERE ename='ALICE';

INSERT INTO emp5
SELECT * FROM employee;

-- 부서명이 RESEARCH 소속의 사원을 전원 삭제하세요.
SELECT * FROM emp5;

DELETE FROM emp5
WHERE dname='RESEARCH';

SELECT * FROM department;

DELETE FROM emp5
WHERE dno= (SELECT dno
            FROM department
            WHERE dname='RESEARCH');
            
-------------------------------------------------------------------------------
--트렌젝션 -> commit ,rollback
CREATE TABLE emp6
AS SELECT * FROM employee;

SELECT * FROM emp6;

DELETE FROM emp6
WHERE dno is not null;

COMMIT;
------------------------------------------------------------------------------
--ch09 DDL
CREATE TABLE dept2(
    dno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13));
    
SELECT * FROM dept2;
DESC dept2;

CREATE TABLE dept3
AS SELECT eno, ename, salary*12 AS "ANI_SAL"
    FROM employee
    WHERE dno=20;
    
ALTER TABLE dept3
ADD (birth date);

ALTER TABLE dept3
ADD (addr VARCHAR2(100), phone VARCHAR2(13));

DESC dept3;

ALTER TABLE dept3
MODIFY addr VARCHAR2(500);

ALTER TABLE dept3
RENAME COLUMN addr TO ADDRESS; -- 컬럼 이름 변경

RENAME dept3 TO dept30; -- 테이블 이름 변경
DESC dept30;

----------- DOWN
ALTER TABLE dept30
DROP COLUMN phone;

ALTER TABLE dept30
SET UNUSED (ADDRESS);
-- 위와 같다 
ALTER TABLE dept30
DROP UNUSED COLUMNS;

DROP TABLE dept30;

CREATE TABLE dept3
AS SELECT * FROM employee;

TRUNCATE TABLE dept3;

SELECT * FROM dept30;

CREATE TABLE customer (
    id varchar2(20) CONSTRAINT customer_id_pk PRIMARY KEY,
    pwd varchar2(20) NOT NULL,
    name varchar2(20) NOT NULL
    );
    
DROP Table customer;
DESC customer;

INSERT INTO customer
VALUES('asdf','1234','kim');
INSERT INTO customer
VALUES('asdf','5678','park');
INSERT INTO customer
VALUES(null,'9876','Lee');



CREATE TABLE customer (
    id varchar2(20),
    pwd varchar2(20) NOT NULL,
    name varchar2(20) NOT NULL,
    jumsu number(3) CHECK(0<=jumsu AND jumsu<=100),
    CONSTRAINT customer_id_pk PRIMARY KEY(id)
    );
    
INSERT INTO customer
VALUES('asdf','1234','kim',65);
INSERT INTO customer
VALUES('qwer','1234','park',-65); --jumsu 예외 
    
DROP Table customer;
DESC customer;


CREATE TABLE customer (
    id varchar2(20),
    pwd varchar2(20) NOT NULL,
    name varchar2(20) DEFAULT '홍길동',
    CONSTRAINT customer_id_pk PRIMARY KEY(id)
    );
    
INSERT INTO customer
VALUES('qwer','1234','park'); 
INSERT INTO customer(id,pwd)
VALUES('asdf','1234'); 

SELECT * FROM customer;
    
    
--foreign key    
CREATE TABLE student(
    stuno varchar2(20) CONSTRAINT student_id_pk PRIMARY KEY,
    name varchar2(20) CONSTRAINT student_name_nn NOT NULL,
    majar varchar2(20)
);

CREATE TABLE registration(
    ernrollid varchar2(20) CONSTRAINT registration_id_pk PRIMARY KEY,
    stuno varchar2(20),
    subject varchar2(20) CONSTRAINT registration_subject_nn NOT NULL,
    CONSTRAINT registration_stuno_fk FOREIGN KEY(stuno) REFERENCES student(stuno)
);

INSERT INTO student
VALUES('s001','kim','math');
INSERT INTO student
VALUES('s002','smith','english');
INSERT INTO student
VALUES('s003','lee','korean');

SELECT * FROM student;

INSERT INTO registration
VALUES('E001','s001','대수학');
INSERT INTO registration
VALUES('E002','s004','미분기하학'); -- s004가 student에 없기 때문에 오류 발생

-------------------------------------------------------------------------------
CREATE TABLE stu_copy
AS SELECT * FROM student;

CREATE TABLE reg_copy
AS SELECT * FROM registration;

ALTER TABLE reg_copy
ADD CONSTRAINT reg_copy_stuno_fk FOREIGN KEY(stuno) REFERENCES student(stuno);

ALTER TABLE stu_copy
ADD CONSTRAINT stu_copy_stuno_pk PRIMARY KEY(stuno); 

ALTER TABLE reg_copy
ADD CONSTRAINT reg_copy_ernrollid_pk PRIMARY KEY(ernrollid);

ALTER TABLE stu_copy
MODIFY majar CONSTRAINT stu_copy_majar_nn NOT NULL;

ALTER TABLE stu_copy
DROP PRIMARY KEY;

ALTER TABLE stu_copy
DROP CONSTRAINT stu_copy_majar_nn; --CASCADE : 이와 연결된 기본키도 제거한다 
--------------------------------------------------------------------------------
--시퀀스
CREATE SEQUENCE seq_sample
START WITH 10
INCREMENT BY 10;

SELECT sequence_name, min_value, max_value, increment_by, cycle_flag
FROM user_sequences;

SELECT seq_sample.currval FROM dual;

SELECT seq_sample.nextval FROM dual;

CREATE TABLE member(
    m_info number PRIMARY KEY, 
    m_id varchar2(20) NOT NULL,
    m_pwd varchar2(100) NOT NULL
);
CREATE SEQUENCE member_seq;

INSERT INTO member
VALUES(member_seq.nextval,'asdf','1234');

SELECT * FROM member;

--'S'||to_char(member_seq.nextval)

ALTER SEQUENCE member_seq
INCREMENT BY 5;

SELECT * 
FROM user_sequences;

NOCACHE;
