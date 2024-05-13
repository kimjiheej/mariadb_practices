-- 
-- 문자열 함수 
-- 

-- upper 
select upper('seoul'), ucase('SeouL') from dual;

select upper(first_name) from employees;

-- lower 
select lower('SEOUL'), lcase('SeouL') from dual;
select lower(first_name) from employees;

-- substring(문자열, index, length) 
select substring('Hello World', 3,2);

-- 예제: 1989년에 입사한 직원들의 이름, 입사일의 출력 
select first_name, hire_Date from employees 
where substring(hire_date, 1, 4) = '1989'; 

-- lpad(왼쪽 정렬), rpad(오른쪽 정렬) 
select lpad('1234', 10, '-'), rpad('1234', 10, '-')  from dual; 

-- 예제 ) 직원들의 월급을 오른족 정렬 (빈공간은 *) 
select lpad(salary, 10, '*') from salaries;

-- trim, ltim, rtim 
select concat("---", ltim('   hello     '), "---"),
       concat("---", rtim('   hello     '), "---"),
	   concat("---", trim(leading 'x' from 'xxxhellxxx'), "---"), 
       concat("---", trim(trailing 'x' from 'xxxhellxxx'), "---"), 
       concat("---", trim(both 'x' from 'xxxhellxxx'), "---")
from dual;

-- length 
select length("Hello World") from dual;














