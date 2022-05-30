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
DESC EMPLOYEE; -- employee ����

SELECT sysdate FROM dual; --���� ��¥ 

SELECT * FROM employee; 

SELECT eno, ename, job, manager, hiredate, salary, commission, dno FROM green14.employee;

SELECT ename, salary, salary*12 FROM employee;

SELECT ename, salary, salary*12+commission FROM employee;

SELECT ename, salary, salary*12+NVL(commission, 0) AS "�� ��" FROM employee; --NVL(,) commission�� ���ٸ� 0

SELECT DNO FROM employee;

SELECT DISTINCT DNO FROM employee; --DISTINCT : �ߺ� ����

SELECT ename, salary FROM employee WHERE ename='SMITH'; -- ''(o), ""(x)
-- �˰�ʹ�, �̸��� �޿��� ������̺� �ִ� �̸��� ���̽��� ���.

SELECT * FROM employee WHERE salary <= 1500;

SELECT * FROM employee WHERE ename != 'SMITH';

SELECT * FROM employee WHERE NOT hiredate <= '1981/05/31' AND salary >= 1200;
-- NOT �ٷ� �ڸ� ����

SELECT * FROM employee WHERE salary <=1500 AND salary >= 1000;
SELECT * FROM employee WHERE salary BETWEEN 1000 AND 1500;
-- �޿� 1000~1500 ������ ����� ��ȸ

SELECT * FROM employee WHERE salary <1000 OR salary > 1500;
SELECT * FROM employee WHERE salary NOT BETWEEN 1000 AND 1500;
-- �޿��� 1000�̸��̰ų� 1500�ʰ��� ����� ��ȸ

SELECT * FROM employee WHERE commission = 300 OR commission = 500 OR commission = 1400;
-- Ŀ�̼��� 300�̰ų� 500�̰ų� 1400�� ��� ��ȸ

SELECT * FROM employee WHERE hiredate BETWEEN '1981/01/01' AND '1981/12/31';
SELECT * FROM employee WHERE commission IN(300,500,1400);
-- 1981�⵵ �Ի��� ����� ������ ��ȸ

-- (IS NULL ���� null�� ��)
SELECT * FROM employee WHERE commission IS NOT NULL;

-- ���ڿ� �Ϻ� ��ġ �˻� LIKE
SELECT * FROM employee WHERE ename LIKE '%A%';
-- %�� ���� ������ �� ��
-- _�� ���� ������ �� ��
SELECT * FROM employee WHERE ename LIKE '_A%'; --�ι�° ���ڰ� A�� ���

SELECT * FROM employee 
WHERE salary >= 1200
ORDER BY ename ASC; -- ���� �������� ����,

SELECT * FROM employee 
WHERE salary >= 1200
ORDER BY ename DESC; -- ���� ���� 

SELECT * FROM employee 
WHERE salary >= 1200
ORDER BY job DESC, salary ASC; -- JOB���� ����, �� �� ������ �޿��� �������� ����.

------------------------------------------------------------------------------
SELECT ename, hiredate, to_char(hiredate,'YY-MM'), to_char(hiredate,'YYYY/MM/DD DAY')
FROM employee;

SELECT ename, hiredate
FROM employee
WHERE hiredate = to_date(19811117, 'YYYYMMDD');


SELECT ASCII('T'),ASCIISTR('��'),CHR(84),UNISTR('\BC1D') FROM dual;

SELECT LENGTHC('����Ŭ') FROM dual;

SELECT CONCAT('���ʱ��','Ȱ��'), '����'||'���'||'Ȱ��' FROM dual;

        --ename + " : " + job
SELECT ename||' : '|| job FROM employee;  

SELECT INSTR('�ڹٿ��� ���ڴ� String�̰� �ڹٽ�ũ��Ʈ������ ���ڴ� let�̴�','����',10) FROM dual;
-- 

SELECT lower('StuDentName') FROM dual;
SELECT upper('StuDentName') FROM dual;
SELECT INITCAP('stuDentName') FROM dual;

SELECT REPLACE('�ڹٿ��� ���ڴ� String�̰� �ڹٽ�ũ��Ʈ������ ���ڴ� let�̴�','�ڹ�','JAVA') FROM dual;

SELECT TRANSLATE('�ڹٿ��� ���ڴ� String�̰� �ڹٽ�ũ��Ʈ������ ���ڴ� let�̴�','�ڹ�','JAVA') FROM dual;

SELECT eno,ename,dno FROM employee
WHERE ename='scott';    

SELECT eno,ename,dno FROM employee
WHERE ename=UPPER('scott');

SELECT eno,ename,dno FROM employee
WHERE ename=INITCAP('scott');

SELECT SUBSTR('����SW���ʱ��Ȱ��',5,4) FROM dual;

SELECT REVERSE('domato') FROM dual;
-- ����Ʈ ������ �Ųٷ� ������

SELECT LPAD('ȸ��',9,'-') FROM dual;

SELECT LPAD('love',9,'--') FROM dual;

SELECT '     �ڹ�     'FROM dual;
SELECT LTRIM('     �ڹ�     ')FROM dual;
SELECT RTRIM('     �ڹ�     ')FROM dual;
SELECT TRIM('     �ڹ�     ')FROM dual;
SELECT RTRIM('     �ڹ�     ')FROM dual;

SELECT LTRIM('������������ ��մ�','��')FROM dual;
SELECT TRIM(LEADING,'*' FROM '***** �׸� ��ī���� *****') FROM dual;
 
SELECT * FROM employ
WHERE SUBSTR(ename, -1,1) = 'N';

SELECT CELL(3.14) , FLOOR(3.14) , ROUND(3.14) FROM dual;

SELECT TRUNC(12345.12765, -2) FROM dual;

SELECT ADD_MONTHS('2022/05/24',-7) FROM dual;

SELECT to_DATE('2022/05/24')+5 FROM dual;

SELECT LAST_DAY('2022/05/24') FROM dual;

SELECT NEXT_DAY('2022/05/24','�����') FROM dual;

SELECT ROUND(TO_DATE('2022/08/11'),'DY') FROM dual;

SELECT ename, salary, commission, NVL(commission,0), salary*12+NVL(commission,0) FROM employee;

SELECT ename, NVL2(commission,salary*12+commission,salary*12) FROM employee;

SELECT ename,dno,DECODE(dno,10,'������',
                            20,'�ѹ�',
                            30,'������',
                            40,'������',
                            '�뵿��') AS "�μ���"
FROM employee;

SELECT ename, dno, CASE WHEN dno=10 THEN '������'
                        WHEN dno=20 THEN '�ѹ���'
                        WHEN dno=30 THEN '������' 
                        WHEN dno=40 THEN '������'
                        ELSE '�뵿��' 
                        END AS "�μ���"
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

SELECT TRUNC(TO_DATE('2022/11/17','YYYY/MM/DD')-sysdate) AS "���� ����"
FROM dual;
--06.
SELECT ename, NVL2(manager,manager,0) AS "��� ���" FROM employee;
--07.DECODE �Լ��� ���޿� ���� �޿��� �λ�.
--ANALYST 200, SALESMAN 180, MANAGER 150 , CLERK 100
SELECT ename, job, salary,
DECODE(job,'ANALYST',salary+200,
           'SALESMAN', salary+180,
           'MANAGER', salary+150,
           'CLERK', salary+100,
           salary) AS "�λ�� �޿�"
FROM employee;

--------------------------------------------------------------------------
SELECT SUM(salary) AS "�޿� ����",
       TRUNC(AVG(salary)) AS "��� �޿�",
       MAX(salary) AS "�ִ� �޿�",
       MIN(salary) AS "�ּ� �޿�"
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

SELECT dno, job, TRUNC(AVG(salary)) AS "��� �޿�"
FROM employee
GROUP BY dno, job
ORDER BY dno ASC, job DESC;

--�׷� ����� ���� WHERE ��� HAVING ���� �����. (���� ������ �� ����)
SELECT job, AVG(salary), SUM(salary)
FROM employee
--WHERE AVG(salary) >= 2000;
GROUP BY job
HAVING AVG(salary) >= 2000;

-- �μ��� �ְ� �޿��� 3000�̻��� �μ��� ��ȣ �� �ش� �μ��� �ְ� �޿��� ���ϼ���.
SELECT dno, MAX(salary)
FROM employee
GROUP BY dno
HAVING MAX(salary)>=3000;

-- �Ŵ����� �����ϰ� �޿� �Ѿ��� 5000 �̻��� ��� ������ �޿� �Ѿװ� �ش� �ο��� ���ϼ���.
SELECT job, SUM(salary), COUNT(*)
FROM employee
WHERE job != 'MANAGER'
GROUP BY job
HAVING SUM(salary) >= 5000;

--�μ��� ��� �޿��� �ְ� ��� �޿��� ��ȸ�ϱ�

SELECT ename, salary
FROM employee
WHERE salary=(SELECT MAX(salary) FROM employee);

SELECT dno, job, SUM(salary)
FROM employee
GROUP BY ROLLUP(dno, job);

--���� ���� 
--------------------------------------------------------------------------
--30�� �μ��� �ְ� �޿�
SELECT MIN(salary)
FROM employee
WHERE dno=30;

--�� �μ��� �ּұ޿�
SELECT dno, MIN(salary)
FROM employee
GROUP BY dno;

--30�� �μ��� �ּ� �޿����� �� ū �ּұ޿��� ���� �ٸ� �μ�
SELECT dno, MIN(salary)
FROM employee
GROUP BY dno
HAVING MIN(salary) > (SELECT MIN(salary)
                      FROM    employee
                      WHERE dno=30);
-- ������� ���� �޿��� ���� ���
SELECT salary
FROM employee
WHERE job='SALESMAN';

SELECT ename, salary
FROM employee
WHERE salary < ALL (SELECT salary
                    FROM employee
                    WHERE job = 'SALESMAN') --1250,1500,1600
AND job<>'SALESMAN';

-- ANY �� �� �ϳ��� ��ġ�ϴ� �� OR
-- ALL ��ü�� ������ ��ġ�ϴ� �� AND 

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
SELECT job, dno, --�μ��� 10�� ����, �μ� 20���� ����, 30���� ���� , SUM(salary)
        DECODE(dno,10,SUM(salary)) AS "�μ� 10",
        DECODE(dno,20,SUM(salary)) AS "�μ� 20",
        DECODE(dno,30,SUM(salary)) AS "�μ� 30",
        SUM(salary) AS "�Ѿ�"
FROM employee
GROUP BY job, dno;




--------------------------CH6 QUIZ----------------------------------------------
SELECT * FROM employee;

--01.��� ��ȣ��7788�� ����� ������������ ����� ǥ��(����̸���������)�ϼ���

SELECT ename, job
FROM employee
WHERE job = (SELECT job 
             FROM employee
             WHERE eno = 7788);
             
--02.�����ȣ��7499�� ������ٱ޿��� ���� ����� ǥ��(����̸���������)�ϼ���

SELECT eno, job , salary
FROM employee
WHERE salary > ( SELECT salary
                 FROM   employee
                 WHERE eno = 7499 );
                 
--03. �ּ� �޿��� �޴� ����� �̸�, �������� �޿��� ǥ���ϼ���(�׷��Լ�)
SELECT ename, job, salary
FROM employee
WHERE salary = (SELECT MIN(salary)
                FROM employee);

--04. ��� �޿��� ���� ���� ������ ã�� ���ް� ��� �޿��� ǥ���ϼ���
SELECT job, AVG(salary)
FROM employee
GROUP BY job
HAVING AVG(salary) = (SELECT MIN(AVG(salary))
                      FROM employee
                      GROUP BY job);

--05. �� �μ��� �ּұ޿����޴� ��� �̸�,�޿�, �μ���ȣ��ǥ���ϼ���.
SELECT ename, salary, dno
FROM employee
WHERE salary = ANY(SELECT MIN(salary) FROM employee GROUP BY dno);

SELECT ename, salary, dno
FROM employee
WHERE salary IN(SELECT MIN(salary) FROM employee GROUP BY dno);


--06. ���������м���(ANALYST)�λ�����ٱ޿��� �����鼭 ������ �м���(ANALYST)�ƴ�
--    ���(�����ȣ, �̸�, ������,�޿�)���� ǥ���ϼ���
SELECT eno,ename,job,salary
FROM employee
WHERE salary < ANY(SELECT salary 
                    FROM employee
                    WHERE job != 'ANALYST')
AND job<>'ANALYST'; -- job != 'ANALYST'

--07. �Ŵ��� ���� ����� �̸��� ǥ���ϼ���
SELECT ename,manager
FROM employee
WHERE ename = (SELECT ename FROM employee WHERE manager is null);

--08 �Ŵ��� �ִ� ����� �̸��� ǥ���ϼ���
SELECT ename,manager
FROM employee
WHERE ename = ANY(SELECT ename FROM employee WHERE manager is not null);

--09 BLAKE�͵����� �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ����Ǹ� �ۼ��ϼ���.(��BLAKE������)
SELECT dno, ename, hiredate
FROM employee
WHERE dno = (SELECT dno FROM employee WHERE ename=('BLAKE')) AND ename != 'BLAKE'; -- ename <> 'BLAKE'

--10. �޿��� ��պ��ٸ��� ������� �����ȣ�� �̸��� ǥ���ϵ� ����� �޿��� ���� �����������������ϼ���.
SELECT eno, ename, salary
FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee)
ORDER BY salary ASC;

--11. �̸���K�� ���Ե� ����� ���� �μ��������ϴ� ����� �����ȣ���̸��� ǥ���ϴ����Ǹ� �ۼ��ϼ���.
SELECT eno, ename
FROM employee
WHERE dno = ANY(SELECT dno FROM employee WHERE ename LIKE '%K%' );

--12. �μ���ġ��DALLAS�� ����� �̸��� �μ���ȣ �� ��������ǥ���ϼ���.
SELECT  eno,e.dno,job
FROM department d INNER JOIN employee e
ON d.dno = e.dno
WHERE d.loc = 'DALLAS';

--13. KING���� �����ϴ»���� �̸��� �޿��� ǥ���ϼ���
SELECT ename,salary 
FROM employee
WHERE dno = (SELECT dno FROM employee WHERE ename = 'KING') AND job = 'MANAGER';

SELECT * FROM employee;
--14. RESEARCH �μ��� ����� ���� �μ���ȣ, �����ȣ �� ������������ϼ���
SELECT * FROM department;

--15. ��� �޿����ٸ��� �޿��� �ް� �̸�����M�� ���Ե� ����� ���� �μ�����
--    �ٹ��ϴ»���ǻ����ȣ, �̸�, �޿��� ����ϼ���
SELECT eno,ename,salary
FROM employee
WHERE salary >= (SELECT AVG(salary) 
                    FROM employee)

AND dno IN (SELECT dno 
            FROM employee
            WHERE ename LIKE '%M%');


--16. ��ձ޿������� ���� ������ ã������
SELECT job, AVG(salary)
FROM employee
GROUP BY job
HAVING AVG(salary) = (SELECT MIN(AVG(salary))
                        FROM employee
                        GROUP BY job);

--17. �������������� ����� �����ȣ���̸��� ����ϼ���

SELECT eno,ename 
FROM employee
WHERE eno IN (SELECT manager
                FROM employee);
--------------------------------------------------------------------------------
--JOIN
                
--7788����� �̸��� �޿� �׸��� �μ����� �˰� �ʹ� => ���� 
SELECT ename, salary, dname
FROM employee
WHERE eno = 7788;

--CATESIAN ���� ���̺�1 COL X ���̺�2 COL
SELECT * FROM department; --4 col
SELECT * FROM employee;  -- 14 col
SELECT * FROM department,employee; -- 56 col 

--EQUI ���� �ߺ�����
SELECT * 
FROM department,employee
WHERE department.dno = employee.dno;

--7788����� �̸��� �޿� �׸��� �μ����� �˰� �ʹ� => EQUI ���� �̿� 
-- �� ���̺��� �ִ� �� ���� ���� 
SELECT ename, salary, dname
FROM department d, employee e
WHERE d.dno = e.dno
AND e.eno = 7788;

--NATURAL ����
SELECT *
FROM department NATURAL JOIN employee;

SELECT ename, salary, dname, dno
FROM department d NATURAL JOIN employee e
WHERE e.eno=7788;

--JOIN USING ���
SELECT *
FROM department JOIN employee
USING(dno)
WHERE eno=7788;

--JOIN ON
SELECT *
FROM department d JOIN employee e
ON d.dno = e.dno
WHERE e.eno=7788;

-- JOIN ON => INNER JOIN (ǥ��)
SELECT *
FROM department d INNER JOIN employee e
ON d.dno = e.dno
WHERE e.eno = 7788;

--------------------------------------------------------------------------------
--NON-EQUI ���� 
SELECT * FROM salgrade;

SELECT e.ename, e.salary, s.grade
FROM employee e, salgrade s
WHERE e.salary BETWEEN s.losal AND s.hisal;

--------------------------------------------------------------------------------
-- 3���� ���̺��� ��ģ ����
-- ����� �̸�, �Ҽ� �μ� �̸�, �޿��� �޿������ ����ϼ���
--      emp        depart           salgrade

SELECT *
FROM employee e, department d, salgrade s
WHERE e.dno=d.dno
AND e.salary > s.losal AND e.salary <= s.hisal;

--------------------------------------------------------------------------------
--SELF ����

SELECT * FROM employee;

--����̸��� ��� �������� �̸��� ���� ����� ���ô�.

SELECT eno, ename, eno, ename
FROM employee emp, employee manag
WHERE emp.manager = manag.eno;
-------------------------------------------------------------------------------
-- OUTER JOIN (ǥ��)
SELECT * 
FROM department d LEFT OUTER JOIN employee e
ON d.dno=e.dno;

-- ����Ŭ������ OUTER ���� => null�� ǥ���ϰ��� �ϴ� ���̺��� ���ǿ� * ǥ��
--                          +�� ǥ�� �ȵ� ���̺��� ����
SELECT * 
FROM department d, employee e
WHERE d.dno=e.dno(+);

-- ����̸��� ��� �������� �̸��� ���� ����� ���ô�
-- �ٸ� ��� ��ȣ�� ���°�� �׳�(NULL)�� ����Ѵ�

SELECT emp.eno, emp.ename, manag.eno, manag.ename
FROM employee emp, employee manag
WHERE emp.manager = manag.eno(+);

SELECT emp.eno, emp.ename, manag.eno, manag.ename
FROM employee emp LEFT OUTER JOIN employee manag
ON emp.manager = manag.eno;

-- ����̸��� ��� �������� �̸��� ���� ����� ���ô�
-- �ٸ� ��� ��ȣ�� ���°�� NULL�� ����Ѵ�
-- ���� ������ ���� ��쵵 NULL�� ����Ѵ�
SELECT emp.eno, emp.ename, manag.eno, manag.ename
FROM employee emp FULL OUTER JOIN employee manag
ON emp.manager = manag.eno;
--------------------------------------------------------------------------------
-- DML ������ ���۾� => ���������� Ʃ���� ������ ���� => Ʈ�������� ������ �޴´�.
SELECT * FROM employee;
-- INSERT ������ ����
INSERT INTO employee(eno,ename,job,manager,hiredate,salary,commission,dno)
            VALUES(8121,'ALICE','CLERK',7788,sysdate,1200,100,10);
            
INSERT INTO employee(eno,ename,job,manager,hiredate,salary,commission,dno)
VALUES(8231,'KATHERINE','SALESMAN',7698,sysdate,1750,800,30);

--Ʈ������ ������ ����
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

-----ch07 ���� quiz -----------------------------------------------------------
--1.   Equi������ ����Ͽ�SCOTT �����  -- �μ���ȣ�ͺμ��̸�������ϼ���.
SELECT d.dno, dname
FROM department d , employee e
WHERE d.dno = e.dno
AND e.ename = 'SCOTT';

--2. Inner ���ΰ�on�����ڸ�����Ͽ�����̸����Բ�
--�� ����� �Ҽӵ� �μ��̸���������������ϼ���.
SELECT e.ename, dname, loc
FROM department d INNER JOIN employee e
ON d.dno = e.dno;

SELECT e.ename, dname, loc
FROM department d INNER JOIN employee e
ON d.dno = e.dno;

--3. INNER ����Using �����ڸ�����Ͽ�10�� �μ��� ���ϴ� 
--��� �������ǰ��� ����� �μ����������������Ͽ�����ϼ���.
SELECT job, dname
FROM department d INNER JOIN employee e
USING(dno)
WHERE dno = 10;

SELECT * FROM employee;
SELECT * FROM department;
--4. Natural������ ����Ͽ�Ŀ�̼����޴� ��� ����� �̸�, �μ��̸�, ������������ϼ���
SELECT ename,dname,loc
FROM employee e NATURAL JOIN department d;

--5. Equal ���ΰ�Wildī�带 ����ؼ��̸���A�����Ե� ��� ����� �̸��� �μ���������ϼ���,
SELECT ename,dname
FROM employee e, department d
WHERE e.dno = d.dno 
AND ename LIKE '%A%';

--6. Natural ������ ����Ͽ�NEW York�� �ٹ��ϴ� 
--��� ����� �̸�, ���� �μ���ȣ�� �μ���������ϼ���.
SELECT ename, dno, dname
FROM employee e NATURAL JOIN department d
WHERE loc = 'NEW YORK';

--7. Self Join�� ����Ͽ������ �̸��� ��� ��ȣ�� 
--������ �̸� �� ������ ��ȣ�� �Բ� ����ϼ���. �� ���� ��Ī�� ����̸�(Employee) �����ȣ(emp#) 
--�������̸�(Manager) �����ڹ�ȣ(Mgr#)
SELECT employee.ename as "����̸�", employee.eno as "�����ȣ", 
        manager.ename as "�������̸�", manager.eno as "�����ڹ�ȣ"
FROM employee employee, employee manager
WHERE employee.manager = manager.eno;

--8.   Outter����self ������ ����Ͽ������ڰ����� ����� �����Ͽ������ȣ��
--�������γ������� �����Ͽ�Ŭ���ϼ��䰢 ���� ��Ī�� ����̸�(Employee)�����ȣ(emp#)
--�������̸�(Manager)�����ڹ�ȣ(Mgr#)
SELECT emp.eno, emp.ename, manag.eno, manag.ename
FROM employee emp LEFT OUTER JOIN employee manag
ON emp.manager = manag.eno;

SELECT emp.eno, emp.ename, manag.eno, manag.ename
FROM employee emp, employee manag
WHERE emp.manager = manag.eno(+);

SELECT emp.eno, emp.ename, manag.eno, manag.ename
FROM employee emp LEFT OUTER JOIN employee manag
ON emp.manager = manag.eno;

--9. Self������ ����Ͽ������� ���(SCOTT)�� �̸�, �μ���ȣ, ������ ����� 
--������ �μ������ٹ��ϴ� ����� ����ϼ��䰢 ���� ��Ī�� �̸�, �μ���ȣ, ����� �����ϼ���
SELECT e.ename as "�̸�", e.dno as"�μ���ȣ",sec.ename as "����"
FROM employee e, employee sec
WHERE e.ename = 'SCOTT' AND e.dno= sec.dno;

--10. Self ������ ����Ͽ�WARD ������ٴʰ� �Ի��� ����� �̸��� �Ի���������ϼ���.,
SELECT e.ename,e.hiredate
FROM employee e, employee d
WHERE e.hiredate > ANY(SELECT d.hiredate FROM employee WHERE d.ename = 'WARD');

--11. Self������ ����Ͽ������ں��ٸ��� �Ի��Ѹ�� ����� �̸� �� 
--�Ի��������������̸� ���Ի��԰��Բ� ����ϼ���. �� ���� ��Ī��
--����̸�(Ename) ����Ի���(HIERDATE) ������ �̸�(Ename) ������ �Ի���(HIERDATE)�� ����ϼ���

SELECT e.ename as "����̸�", e.hiredate as "����Ի���",
       m.ename as"������ �̸�",m.hiredate as "������ �Ի���"
FROM employee e, employee m
WHERE e.hiredate < ANY(SELECT m.hiredate FROM employee WHERE m.job = 'MANAGER');

--------------------------------------------------------------------------------

--UPDATE ������ ����
--UPDATE ���̺�� SET WHERE
CREATE TABLE emp4
AS SELECT * FROM employee;

SELECT * FROM emp4;

--eno8500�� ��� �̸� MARS
UPDATE emp4 SET ename='MARS', job = 'MANAGER' WHERE eno=8500;

UPDATE emp4 SET commission=500;

UPDATE emp4
SET salary = (SELECT losal
              FROM salgrade
              WHERE grade = 1)
WHERE dno is NULL;

-------------------------------------------------------------------------------
-- DELETE ������ ����
-- DELETE FROM ���̺�� WHERE ����
SELECT * FROM employee;

CREATE TABLE emp5
AS SELECT * FROM employee;

DELETE * FROM emp5
WHERE ename='ALICE';

INSERT INTO emp5
SELECT * FROM employee;

-- �μ����� RESEARCH �Ҽ��� ����� ���� �����ϼ���.
SELECT * FROM emp5;

DELETE FROM emp5
WHERE dname='RESEARCH';

SELECT * FROM department;

DELETE FROM emp5
WHERE dno= (SELECT dno
            FROM department
            WHERE dname='RESEARCH');
            
-------------------------------------------------------------------------------
--Ʈ������ -> commit ,rollback
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
RENAME COLUMN addr TO ADDRESS; -- �÷� �̸� ����

RENAME dept3 TO dept30; -- ���̺� �̸� ����
DESC dept30;

----------- DOWN
ALTER TABLE dept30
DROP COLUMN phone;

ALTER TABLE dept30
SET UNUSED (ADDRESS);
-- ���� ���� 
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
VALUES('qwer','1234','park',-65); --jumsu ���� 
    
DROP Table customer;
DESC customer;


CREATE TABLE customer (
    id varchar2(20),
    pwd varchar2(20) NOT NULL,
    name varchar2(20) DEFAULT 'ȫ�浿',
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
VALUES('E001','s001','�����');
INSERT INTO registration
VALUES('E002','s004','�̺б�����'); -- s004�� student�� ���� ������ ���� �߻�

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
DROP CONSTRAINT stu_copy_majar_nn; --CASCADE : �̿� ����� �⺻Ű�� �����Ѵ� 
--------------------------------------------------------------------------------
--������
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
