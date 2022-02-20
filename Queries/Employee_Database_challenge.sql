--retrieve employees table
SELECT emp_no, first_name, last_name
FROM employees;

--retrieve titles table
SELECT title, from_date, to_date
FROM titles;

--join both table and create new one 
SELECT em.emp_no,
	em.first_name,
	em.last_name, 
	ti.title, 
	ti.from_date, 
	ti.to_date
INTO retirement_titles
FROM employees as em
INNER JOIN titles as ti
ON 	em.emp_no = ti.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY em.emp_no;

select * from retirement_titles 

-- filter distict title and create new table
SELECT DISTINCT ON (ret.emp_no) ret.emp_no,
ret.first_name,
ret.last_name,
ret.title
INTO unique_titles
FROM retirement_titles as ret
WHERE ret.to_date= '9999-01-01' 
ORDER BY ret.emp_no, ret.to_date DESC;

SELECT COUNT (title) as count, title
INTO retiring_titles
FROM unique_titles 
GROUP BY title
ORDER BY count DESC

----Retrieve data, create a new one base on mentoship elegilability
SELECT DISTINCT ON (em.emp_no)em.emp_no, 
em.first_name, 
em.last_name,
em.birth_date,
dem.from_date,
dem.to_date,
ti.title
INTO mentorship_elegibility
FROM employees as em
INNER JOIN dept_manager as dem
ON em.emp_no = dem.emp_no
INNER JOIN Titles as ti
ON dem.emp_no =ti.emp_no
WHERE (dem.to_date = '9999-01-01') AND
	(em.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY em.emp_no	

SELECT*FROM mentorship_elegibility



