# Pewlett-Hackard-Analysis

---

In this challenge I used PostgreSQL with pgAdmin to comprehend a large dataset made up of overlapping .csv files containing various data about employment at the company Pewlett-Hackard. PH is worried about structuring for an incoming wave of retirements, and this data will allow them to make crucial decisions about development for leadership roles.

---

## Results

1. I found that a staggering 33,118 employees in the given data are potentially up for retirement in the next few years for PH
    - this comprises about 14% of the 240,124 curently working employees
    - to obtain these number, I wrote this query
        ~~~
            select count(e.emp_no)
            from employees as e
            inner join dept_emp as de
            on e.emp_no = de.emp_no
            where (e.birth_date between '1952-01-01' and '1955-12-31') 
            and (e.hire_date between '1985-01-01' and '1988-12-31')
            and (de.to_date = '9999-01-01');  
        ~~~

2. The number of retirees by position seems larger than the number available to retire because it includes those who have already retired
    - but it does show a general trend where senior positions are retiring in much larger numbers than non senior positions

3. The number of eligible mentors that PH can use to train their replacements might be too low
    - it depends on how many replacements you are willing to allow one person to train
    - but it seems like at the very least around a 10 to one relationship between those eligible to mentor and those who could be leaving

4. It seems like PH should enact their plan to keep some on part time for mentorship purposes
    - selecting for current employees even, the data seem to suggest that senior roles alone account for around 20,000 postitions that need filled
    
---

## Conclusion

Total number of roles that need to be filled in the coming years is somewhere around 30,000. A majority of these roles are senior positions. This is entirely too many positions to ask 1500 eligible mentors to train. I would suggest that PH look to other methods of filling positions.