-- practices01
-- 기본 SQL 문제입니다. 

-- 문제1. // 한줄 나오도록 
-- 사번이 10944인 사원의 이름은(전체 이름)

select concat(first_name, last_name) from employees where emp_no = 10944;

-- 문제2.  // alias 사용해라 
-- 전체직원의 다음 정보를 조회하세요. 가장 선임부터 출력이 되도록 하세요. 출력은 "이름", "성별",  "입사일" 순서이고 “이름”, “성별”, “입사일로 컬럼 이름을 대체해 보세요. 

select concat(first_name, last_name) as '이름' , gender as '성별' , hire_date as '입사일' 
from employees
order by hire_date asc;

-- 문제3. 
-- 여직원과 남직원은 각 각 몇 명이나 있나요?
-- 여직원 남직원 10 20 이런 식으로 나와야 한다 
-- 쿼리 한번 때려서 여직원 구하고 한번 쿼리 때려서 남직원 구한다 

select count(*) as '남자' from employees where gender = 'M';
select count(*) as '여자' from employees where gender = 'F';



-- 문제4. // salaries 에서 count 를 세어라 현재 ~ 어쩌고 이런 식으로 where 절에 to_date 가 999-01-01  과 같다고 세워준다 
-- 현재 근무하고 있는 직원 수는 몇 명입니까? (salaries 테이블을 사용합니다.) 

select count(emp_no) as '직원 수' from salaries where to_date = '9999-01-01';

-- 문제5. // distinct 
-- 부서는 총 몇 개가 있나요? 

select count(distinct(dept_name)) as "부서 수"  from departments;

-- 문제6. // dept_manager 에서 현재 조건을 걸어주고 count 를 세어라 
-- 현재 부서 매니저는 몇 명이나 있나요?(역임 매너저는 제외)

select count(distinct(emp_no)) as "부서 매니저 수" from dept_manager 
where to_date ='9999-01-01';


-- 문제7. // departments 에서 출력해주면 된다. 이름이 긴 순서대로 length 함수를 사용하면 된다. 함수의 위치는 from 절에만 없으면 된다 
-- 전체 부서를 출력하려고 합니다. 순서는 부서이름이 긴 순서대로 출력해 보세요.

select distinct(dept_name) as "부서의 이름"  from departments 
order by length(dept_name) desc;

-- 문제8. 
-- 현재 급여가 120,000이상 받는 사원은 몇 명이나 있습니까?

select count(emp_no) as "사원의 수" from salaries 
where salary >=120000 and to_date ='9999-01-01';

-- 문제9.
-- 어떤 직책들이 있나요? 중복 없이 이름이 긴 순서대로 출력해 보세요.

 select distinct(title) as '직책 이름' from titles order by length(title) desc;

-- 문제10 // 직책 테이블은 titles 이다 현재 조건을 걸어라 
-- 현재 Enginner 직책의 사원은 총 몇 명입니까?

select count(emp_no) as "Engineer 사원" from titles 
where title = "Engineer" and to_date = '9999-01-01';

-- 문제11 // 
-- 사번이 13250(Zeydy)인 직원의  직책 변경 상황을 시간순으로 출력해보세요.

select * from titles where emp_no = 13250
order by to_date asc; 









