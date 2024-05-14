
-- 문제 1.  조인 시켜서 풀어라 
-- 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.
   
   select e.emp_no, e.first_name, b.salary 
   from employees e, salaries b 
   where e.emp_no = b.emp_no
   and b.to_date='9999-01-01'
   order by b.salary desc;
   
-- 문제2. 
-- 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.

select e.emp_no, e.first_name, t.title
from employees e, titles t 
where e.emp_no = t.emp_no and  t.to_date = '9999-01-01'
order by e.first_name asc;

 

-- 문제3.
-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요..
 select e.emp_no, e.first_name, k.dept_name
 from employees e, dept_emp d, departments k 
 where e.emp_no = d.emp_no and d.dept_no = k.dept_no  
 order by e.first_name asc;

-- 문제4.
-- 전체 현재 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.

select e.emp_no, e.first_name, s.salary, t.title, d.dept_name from 
employees e, titles t, departments d, dept_emp dd, salaries s 
where e.emp_no = t.emp_no
 and d.dept_no = dd.dept_no
 and e.emp_no = dd.emp_no
 and e.emp_no = s.emp_no
and dd.to_date='9999-01-01'
and t.to_date='9999-01-01'
order by e.first_name asc;


-- 문제5.
-- 'Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요.
--  (현재 ‘Technique Leader’의 직책(으로 근무하는 사원은 고려하지 않습니다.) 이름은 first_name과 last_name을 합쳐 출력 합니다. to_Date 이 9999 가 아닌 얘들만 찾아라. 이름은 first name 만 하자 

select e.emp_no, e.first_name from 
employees e, titles t 
where e.emp_no = t.emp_no 
and t.title = 'Technique Leader' and t.to_date not like '9999-%';
-- 문제6. 
-- 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.

select e.first_name, d.dept_name, t.title  from 
employees e, titles t, departments d, dept_emp dd 
where e.emp_no = dd.emp_no and d.dept_no = dd.dept_no and e.emp_no = t.emp_no 
 and e.last_name like 'S%';

-- 문제7. 
-- 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력하세요.
-- projection : 사번 이름 급여 타이틀 

select   e.first_name, s.salary, t.title from
employees e, salaries s, titles t 
where e.emp_no = s.emp_no and e.emp_no = t.emp_no
and t.title = 'Engineer' and s.salary >=40000
and s.to_date='9999-01-01' and t.to_date='9999-01-01'
order by s.salary desc;

-- 문제8. 그냥 5000 이 넘는 직책이나 출력해라 
-- 현재 평균 급여가 5000이 넘는 직책을 직책, 평균 급여로 평균급여가 큰 순서대로 출력하시오 

select t.title, avg(s.salary) from 
employees e, salaries s, titles t 
where e.emp_no = s.emp_no and e.emp_no = t.emp_no 
and s.to_date='9999-01-01' and t.to_date='9999-01-01'
group by t.title
having avg(s.salary) >=5000
order by avg(s.salary) desc;

-- 문제9. 
-- 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요. 
-- projection : 부서명 평균연봉 

select d.dept_name, avg(s.salary) from 
employees e, departments d, salaries s, dept_emp dd 
where e.emp_no = dd.emp_no and  d.dept_no = dd.dept_no and e.emp_no = s.emp_no 
and s.to_date='9999-01-01' and dd.to_date='9999-01-01'
group by d.dept_name
order by avg(s.salary) desc;

-- 문제10. 
-- 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.
-- projection : 직책명 평균 연봉 

select t.title, avg(s.salary)  from 
employees e, titles t, salaries s 
where e.emp_no = t.emp_no and e.emp_no = s.emp_no
and t.to_date='9999-01-01' and s.to_date='9999-01-01'
group by t.title 
order by avg(s.salary) desc;

