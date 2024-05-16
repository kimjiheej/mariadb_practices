-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
-- 현재 평균 연봉을 구한다 
-- 그리고 그 연봉보다 많이 받는 직원들을 출력한다 

SELECT COUNT(e.emp_no) AS "직원의수"
FROM employees e
WHERE emp_no IN (
    SELECT s.emp_no
    FROM salaries s
    WHERE s.salary > (SELECT AVG(salary) FROM salaries WHERE to_date = '9999-01-01')
    AND s.to_date = '9999-01-01'
);


-- 단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
-- 문제2. 
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서, 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
SELECT  e.emp_no AS 사번, e.first_name AS 이름, d.dept_name AS 부서, s.salary AS 연봉
FROM employees e, dept_emp de, departments d, salaries s
WHERE 
    e.emp_no = de.emp_no AND
    de.dept_no = d.dept_no AND
    e.emp_no = s.emp_no AND
    (de.dept_no, s.salary) IN (
        SELECT de1.dept_no, MAX(s1.salary)
        FROM dept_emp de1
        JOIN salaries s1 ON de1.emp_no = s1.emp_no
        WHERE s1.to_date = '9999-01-01'
        GROUP BY de1.dept_no
    )
ORDER BY 
    연봉 DESC;
    
	

-- 문제3. 
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 

-- 자신의 부서 평균 급여를 구한다 

SELECT a.emp_no, a.first_name, b.salary
FROM employees a, salaries b, dept_emp c,
    (SELECT 
        c.dept_no, AVG(b.salary) AS avg_salary
    FROM
        employees a, salaries b, dept_emp c
    WHERE
        a.emp_no = b.emp_no
            AND a.emp_no = c.emp_no
            AND b.to_date = '9999-01-01'
            AND c.to_date = '9999-01-01'
    GROUP BY c.dept_no) d
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND c.dept_no = d.dept_no
        AND b.salary > d.avg_salary
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01';
        
        


-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
-- employee 테이블. dept_manager 테이블. 부서이름 

SELECT a.emp_no,
    a.first_name as name,
    d.first_name as manager_name,
    e.dept_name
FROM
    employees a,
    dept_emp b,
    dept_manager c,
    employees d,
    departments e
WHERE
    a.emp_no = b.emp_no
        AND b.dept_no = c.dept_no
        AND d.emp_no = d.emp_no
        AND c.dept_no = e.dept_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01';
        
        
    

    
-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.

-- 평균 연봉이 가장  높은 부서를 먼저 구하고 그 안에서 사번. 이름. 직책 . 연봉을 조회한 후 연봉 순으로 출력한다. 
SELECT a.emp_no, a.first_name AS name,
    b.title,
    c.salary
FROM employees a, titles b, salaries c, dept_emp d
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND a.emp_no = d.emp_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
        AND d.to_date = '9999-01-01'
        AND d.dept_no = (SELECT 
            dept_no
        FROM (SELECT dept_no, AVG(salary) AS avg_salary FROM
                salaries a, dept_emp b
            WHERE a.emp_no = b.emp_no AND a.to_date = '9999-01-01'
			AND b.to_date = '9999-01-01'
            GROUP BY dept_no
            ORDER BY avg_salary DESC
            LIMIT 0 , 1) a) ORDER BY c.salary DESC;
            

            
		
-- 문제6.
-- 평균 연봉이 가장 높은 부서는? 
-- 영업 20000 

-- 평균 연봉이 가장 높은 것을 고른다
-- 그 후 부서를 찾아준다 

SELECT  d.dept_name AS 부서이름,AVG(s.salary) AS 평균연봉
FROM dept_emp de, salaries s, departments d
WHERE 
    de.emp_no = s.emp_no AND
    de.dept_no = d.dept_no AND
    s.to_date = '9999-01-01' AND
    de.to_date = '9999-01-01'
GROUP BY de.dept_no, d.dept_name
ORDER BY 평균연봉 DESC
LIMIT 1;




-- 문제7.
-- 평균 연봉이 가장 높은 직책?
-- 개발자 20000 
-- 직책별 평균 연봉을 계산해준다. 
-- 직책을 찾아준다 

SELECT t.title AS 직책, ROUND(AVG(s.salary), 1) AS 평균연봉
FROM titles t, salaries s
WHERE t.emp_no = s.emp_no AND s.to_date = '9999-01-01'
GROUP BY t.title
ORDER BY 평균연봉 DESC
LIMIT 1;



-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.

SELECT 
    f.dept_name AS '부서이름',
    a.first_name AS '사원이름',
    d.salary AS '연봉',
    g.first_name AS '매니저 이름',
    e.salary AS '매니저 연봉'
FROM
    employees a,
    dept_emp b,
    dept_manager c,
    salaries d,
    salaries e,
    departments f,
    employees g
WHERE
    a.emp_no = b.emp_no
        AND c.dept_no = b.dept_no
        AND a.emp_no = d.emp_no
        AND c.emp_no = e.emp_no
        AND c.dept_no = f.dept_no
        AND c.emp_no = g.emp_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
        AND d.to_date = '9999-01-01'
        AND e.to_date = '9999-01-01'
        AND d.salary > e.salary;
