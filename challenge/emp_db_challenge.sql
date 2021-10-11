-- determine the number of retiring employees per title
-- identify emp who are eligible to participate in mentorship

select e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
into retirement_titles
from employees as e
inner join titles as ti
on (e.emp_no = ti.emp_no)
where (e.birth_date between '1952-01-01' and '1955-12-31')
order by e.emp_no;


-- using distinct on to keep only the most recent title
select distinct on (emp_no) *
into unique_titles
from retirement_titles
order by emp_no, to_date desc;

-- count the number of people
select count(emp_no) as "number", title
into titles_retiring
from unique_titles
group by title
order by "number" desc;

-- distinct meployee eligible for mentorship
select distinct on(e.emp_no)
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	ti.title
into mentor_eligibility
from employees as e
inner join dept_emp as de
on (e.emp_no = de.emp_no)
inner join titles as ti
on (e.emp_no = ti.emp_no)
where (de.to_date = '9999-01-01')
and (e.birth_date between '1965-01-01' and '1965-12-31')
order by e.emp_no;