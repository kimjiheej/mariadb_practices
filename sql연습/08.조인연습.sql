-- 
-- inner join 
-- 

-- 예제 1) 현재, 근무하고 있는 직원의 이름과 직책을 모두 출력하세요. 

select a.first_name, b.title
from employees a, titles b 
where a.emp_no = b.emp_no  -- join 조건 (n-1) 
and b.to_date = '9999-01-01';      -- row 선택 조건 

-- 예제 2) 현재 근무하고 있는 직원의 이름과 직책을 모두 출력하되, 여성 엔지니어(Engnieer)만 출력하세요 

select a.emp_no, a.first_name, b.title
from employees a, titles b 
where a.emp_no = b.emp_no 
and b.to_date = '9999-01-01' and a.gender = 'f' and b.title = 'Engineer';

-- 
-- ANSI/ISO SQL1999 Join 표준문법 
-- 

-- 1) natural join 
-- 조인 대상이 되는 두 테이블에 이름이 같은 공통 컬럼이 있으면 
-- 조인 조건을 명시하지 않고 암묵적으로 조인이 된다. 

select a.first_name, b.title from employees a natural join titles b 
where b.to_date = '9999-01-01';

 
-- 2) join ~ using 
select count(*)
from 
salaries a join titles b  using(emp_no) 
where a.to_date = '9999-01-01' 
and b.to_date= '9999-01-01';

-- 3) join ~ on 

-- 예제) 현재, 직책별 평균 연봉을 큰 순서대로 출력 하세요. 

select a.title, avg(b.salary) 
from titles a join salaries b on a.emp_no = b.emp_no 
where a.to_date='9999-01-01' and b.to_date = '9999-01-01' 
group by a.title
order  by avg(b.salary) desc;












-- join ~ using 





-- join ~ on 

-- 실습문제1 
-- 현재, 직원별 근무 부서를 출력해 보세요. 
-- 사번, 직원이름(first_name), 부서명 순으로 출력하세요 

select a.emp_no, a.first_name, b.dept_name 
from employees a, departments b, dept_emp c 
where a.emp_no = c.emp_no and b.dept_no = c.dept_no 
and c.to_date = '9999-01-01';

-- 실습문제 2 
-- 현재, 지금되고 있는 급여를 출력해 보세요. 
-- 사번, 이름 , 급여 순으로 출력  

select a.emp_no, a.first_name, b.salary 
from employees a, salaries b 
where a.emp_no = b.emp_no and b.to_date = '9999-01-01';

-- 실습문제 3 
-- 현재 , 직책별 평균연봉과 직원수를 구하되 직원수가 100명 이상인 직책만 출력하세요. 
-- projection : 직책 평균연봉 직원수 

select avg(b.salary) , count(*) 
from titles a, salaries b 
where a.emp_no = b.emp_no 
and a.to_date = '9999-01-01' 
and b.to_date = '9999-01-01' 
group by a.title 
having count(*) >=100;

-- 실습 문제 4 
-- 현재, 부서별로 직책이 Engineer 인 직원들에 대해서만 평균 연봉을 구하세요. 
-- 부서이름 평균 급여 


select a.dept_name, avg(d.salary) from 
departments a, dept_emp b, titles c , salaries d 
where a.dept_no = b.dept_no 
and b.emp_no = c.emp_no 
and c.emp_no = d.emp_no 
and b.to_date = '9999-01-01' 
and c.to_date = '9999-01-01' 
and d.to_date = '9999-01-01' 
and c.title = 'Engineer'
group by a.dept_name 
order by avg(d.salary) desc;
















