-- retirement eligibility
select first_name, last_name
from employees
where (birth_date between '1952-01-01' and '1955-12-31') 
and (hire_date between '1985-01-01' and '1988-12-31');

-- number of employees retiring
select count(first_name)
from employees
where (birth_date between '1952-01-01' and '1955-12-31') 
and (hire_date between '1985-01-01' and '1988-12-31');

-- selecting the original retirement eligibility into a table
select first_name, last_name
into retirement_info
from employees
where (birth_date between '1952-01-01' and '1955-12-31') 
and (hire_date between '1985-01-01' and '1988-12-31');

-- selecting all from new table retirement_info
select * from retirement_info;

select * from retirement_info;

-- join departments and dept_manager
select d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
from departments as d
inner join dept_manager as dm
on d.dept_no = dm.dept_no;

drop table if exists current_emp;

-- joining retirement info with dept_emp
select r.emp_no,
	d.dept_no,
	r.first_name,
	r.last_name,
	d.to_date
into current_emp
from retirement_info as r
left join dept_emp as d
on r.emp_no = d.emp_no
where d.to_date = ('9999-01-01');

select * from current_emp;

-- employee count by dept no
select count(ce.emp_no), de.dept_no
into retiring_by_dept
from current_emp as ce
left join dept_emp as de
on ce.emp_no = de.emp_no
group by de.dept_no
order by de.dept_no;

-- creating a 3 joined table called emp_info with retiring emp info
select e.emp_no,
	e.first_name,
	e.last_name,
	e.gender,
	(s.salary),
	de.to_date
into emp_info
from employees as e
inner join salaries as s
on (e.emp_no = s.emp_no)
inner join dept_emp as de
on (e.emp_no = de.emp_no)
where (e.birth_date between '1952-01-01' and '1955-12-31')
and (e.hire_date between '1985-01-01' and '1988-12-31')
and (de.to_date = '9999-01-01');

-- getting current employee manager info 
select dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.last_name,
	ce.first_name,
	dm.from_date,
	dm.to_date
into manager_info
from dept_manager as dm
inner join departments as d
on (dm.dept_no = d.dept_no)
inner join current_emp as ce
on (dm.emp_no = ce.emp_no);

--  getting current employees and their department info
select ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
into dept_info
from current_emp as ce
inner join dept_emp as de
on (ce.emp_no = de.emp_no)
inner join departments as d
on (de.dept_no = d.dept_no);

-- retirees in sales
select ri.emp_no,
	ri.first_name,
	ri.last_name,
	d.dept_name
from retirement_info as ri
inner join dept_emp as de
on (ri.emp_no = de.emp_no)
inner join departments as d
on (de.dept_no = d.dept_no)
where d.dept_name = 'Sales';

-- sales and dev
select ri.emp_no,
	ri.first_name,
	ri.last_name,
	d.dept_name
from retirement_info as ri
inner join dept_emp as de
on (ri.emp_no = de.emp_no)
inner join departments as d
on (de.dept_no = d.dept_no)
where d.dept_name in ('Sales', 'Development');

-- finding the number that are approachin retirement AND still work there
select count(e.emp_no)
from employees as e
inner join dept_emp as de
on e.emp_no = de.emp_no
where (e.birth_date between '1952-01-01' and '1955-12-31') 
and (e.hire_date between '1985-01-01' and '1988-12-31')
and (de.to_date = '9999-01-01');
-- answer: 33,118

-- number currently working at ph
select count(emp_no)
from dept_emp
where to_date = '9999-01-01';
-- a: 240,124

-- finding the number of titles retiring and currently working
select e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
into n_retirement_titles
from current_emp as e
inner join titles as ti
on (e.emp_no = ti.emp_no)
order by e.emp_no;
--
select distinct on (emp_no) *
into n_unique_titles
from n_retirement_titles
order by emp_no, to_date desc;
--
select count(emp_no) as "number", title
from n_unique_titles
group by title
order by "number" desc;