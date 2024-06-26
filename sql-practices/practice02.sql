-- 문제 1. 
-- 최고임금(salary)과  최저임금을 “최고임금, “최저임금”프로젝션 타이틀로 함께 출력해 보세요. 두 임금의 차이는 얼마인가요? 함께 “최고임금 – 최저임금”이란 타이틀로 출력해 보세요.
-- 이 회사 역사 이래로 최저와 최고를 출력해라. 총 3개가 나와야 한다. 최고 최저 그리고 두 임금의 갭이 같이 나와야 한다 

SELECT 
    MAX(salary) AS "최고임금", 
    MIN(salary) AS "최저임금", 
    MAX(salary) - MIN(salary) AS "최고임금-최저임금"
FROM salaries;

-- 문제2.
-- 마지막으로 신입사원이 들어온 날은 언제 입니까? 다음 형식으로 출력해주세요.
-- 예) 2014년 07월 10일

SELECT DATE_FORMAT(MAX(hire_date), '%Y년 %m월 %d일') AS "마지막 신입사원 입사일"
FROM employees;


-- 문제3.
-- 가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력해주세요.
-- 예) 2014년 07월 10일
-- employee 가서 하면 된다. group by 사용하는 것이 아니라 그냥 년도만 출력해라... 

SELECT DATE_FORMAT(MIN(hire_date), '%Y년 %m월 %d일') AS "가장 오래 근속한 직원의 입사일"
FROM employees;
-- 문제4.
-- 현재, 이 회사의 평균 연봉은 얼마입니까?
-- 
select AVG(salary) as "회사의 평균 연봉" 
from salaries;
-- 문제5.
-- 현재 이 회사의 최고/최저 연봉은 얼마입니까?
-- where 절이 있는 것이다. to_date 사용하기 

select max(salary) as "최고 연봉", min(salary) as "최저 연봉"
from salaries where to_date='9999-01-01';

-- 문제6.
-- 제일 어린 사원의 나이와 최 연장자의 나이는 ? 
-- 나이만 출력해주면 된다 !!. 기준은 현재이다 2024년 기준으로 나이를 찾아야 한다. 현재를 기준으로 ! employees 에서 max min 을 사용하면 된다 ~~ 

SELECT 
    MAX(TIMESTAMPDIFF(YEAR, birth_date, CURDATE())) AS "최연장자 나이",
    MIN(TIMESTAMPDIFF(YEAR, birth_date, CURDATE())) AS "제일 어린 사원 나이"
FROM employees;
