-- 1
select department_name, city, country_name
from departments d
join locations l on l.location_id=d.location_id
join countries c on c.country_id=l.country_id
join regions r on r.region_id=c.region_id
where region_name = "Europe";

select distinct region_name
from departments d
join locations l on l.location_id=d.location_id
join countries c on c.country_id=l.country_id
join regions r on r.region_id=c.region_id;

-- 2
select max(salary) maximo, job_id from employees
where job_id like "AC%"
group by job_id;

select max_salary maximo, job_title 
from jobs
where job_title like "%President%"
group by job_title;

-- 3
select distinct job_id from employees
where month(hire_date) in (1,2,3)
and commission_pct is not null;

select last_name, email, hire_date 
from employees
where department_id in (90, 60, 100)
and year(hire_date) between 1990 and 1995;

-- 4
select count(employee_id) total, department_id
from job_history
group by job_id
order by count(employee_id) desc limit 1;

select count(employee_id) total, department_id
from job_history
group by job_id
having count(employee_id) >= all 
(
	select count(employee_id)
	from job_history
	group by job_id
)
limit 1;

select count(location_id) total, country_id
from locations
group by country_id
order by count(location_id) desc limit 1;

-- 5
select d.department_id, d.department_name, d.manager_id
from departments d
join employees e on e.department_id=d.department_id
where last_name like "K%g";

select e.last_name, j.start_date, j.job_id, e.job_id
from employees e
join job_history j on j.employee_id=e.employee_id
where last_name like "K%a%";

-- 6
select last_name, salary, job_title, min_salary, dayname(hire_date) day
from employees e
join jobs j on j.job_id=e.job_id
where job_title like "%Manager%"
and dayname(hire_date) like "Tuesday";

select department_name, job_title, last_name, salary, max_salary, dayname(hire_date) day
from departments d
join employees e on e.employee_id=d.manager_id
join jobs j on j.job_id=e.job_id 
where dayname(hire_date) like "Tuesday"
and salary < max_salary;

-- 7
select 
	e.last_name "empleado", 
	e.job_id "puesto empleado", 
	j.last_name jefe, 
    e.department_id "departamento empleado", 
    j.department_id "departmento jefe"
from employees e
join employees j on e.manager_id=j.employee_id
where e.department_id != j.department_id
and e.job_id = "ST_MAN";

select 
	e.last_name "empleado", 
    j.last_name jefe,
	e.salary "salario empleado", 
    j.salary "salario jefe"
from employees e
join employees j on e.manager_id=j.employee_id
where e.department_id != j.department_id
and (j.salary-e.salary)<7000;

-- 8
select department_name
from departments
where department_id not in (
	select department_id from employees
    where department_id is not null
)
order by 1 asc limit 3;

select department_name
from departments d
left join employees e on e.department_id=d.department_id
where employee_id is null
order by 1 asc limit 3;

select count(employee_id)
from employees
where employee_id not in (
	select employee_id from job_history
);
select count(e.employee_id) total
from employees e
left join job_history j on e.employee_id=j.employee_id
where j.employee_id is null;

-- 9
select count(e.employee_id) total, city
from departments d
join locations l on l.location_id=d.location_id
join countries c on c.country_id=l.country_id
join regions r on r.region_id=c.region_id
join employees e on e.department_id=d.department_id
where region_name = "Europe"
group by city;

select count(e.employee_id) total, city
from departments d
join employees e on e.department_id=d.department_id
join locations l on l.location_id=d.location_id
join countries c on c.country_id=l.country_id
where job_id like "%ST%"
group by city;

-- 10
select round(avg(salary), 2) media, department_name
from departments d
join employees e on e.department_id=d.department_id
where department_name like "%e"
group by department_name
having avg(salary) > all (
	select min_salary from jobs
    where job_title like "Fiance Manager"
    or job_title like "Account"
)
order by media;

select floor(avg(year(hire_date))) media, department_name
from departments d
join employees e on e.department_id=d.department_id
where department_name like "%g"
group by department_name
having floor(avg(year(hire_date))) > all (
	select year(start_date) from job_history
    where job_id like "AC%"
)
order by media asc;