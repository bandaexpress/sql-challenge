DROP TABLE IF EXISTS public."Departments" CASCADE;
DROP TABLE IF EXISTS public."Dept_manager" CASCADE;
DROP TABLE IF EXISTS public."Employees" CASCADE;
DROP TABLE IF EXISTS public."Salaries" CASCADE;
DROP TABLE IF EXISTS public."Titles" CASCADE;
DROP TABLE IF EXISTS public."Dept_emp" CASCADE;

CREATE TABLE "Titles" (
    "title_id" VARCHAR(255)   NOT NULL,
	"title" VARCHAR(255)   NOT NULL,
	CONSTRAINT "pk_Titles" PRIMARY KEY ("title_id")
);

CREATE TABLE "Employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR(255)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(255)   NOT NULL,
    "last_name" VARCHAR(255)   NOT NULL,
    "sex" VARCHAR(255)   NOT NULL,
    "hire_date" DATE   NOT NULL,
	CONSTRAINT "pk_Employees" PRIMARY KEY ("emp_no"),
    CONSTRAINT "fk_Employees_Titles" FOREIGN KEY ("emp_title_id") REFERENCES "Titles" ("title_id") ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE "Salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
	CONSTRAINT "pk_Salaries" PRIMARY KEY ("emp_no"),
    CONSTRAINT "fk_Salaries_Employees" FOREIGN KEY ("emp_no") REFERENCES "Employees" ("emp_no") ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE "Departments" (
    "dept_no" VARCHAR(255)   NOT NULL,
    "dept_name" VARCHAR(255)   NOT NULL,
	CONSTRAINT "pk_Departments" PRIMARY KEY ("dept_no")
);

CREATE TABLE "Dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(255)   NOT NULL,
	CONSTRAINT "pk_Dept_emp" PRIMARY KEY ("emp_no", "dept_no"),
    CONSTRAINT "fk_Dept_emp_Employees" FOREIGN KEY ("emp_no") REFERENCES "Employees" ("emp_no") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "fk_Dept_emp_Departments" FOREIGN KEY ("dept_no") REFERENCES "Departments" ("dept_no") ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE "Dept_manager" (
    "dept_no" VARCHAR(255)   NOT NULL,
    "emp_no" INT   NOT NULL,
	CONSTRAINT "pk_Dept_manager" PRIMARY KEY ("dept_no", "emp_no"),
    CONSTRAINT "fk_Dept_manager_Employees" FOREIGN KEY ("emp_no") REFERENCES "Employees" ("emp_no") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "fk_Dept_manager_Departments" FOREIGN KEY ("dept_no") REFERENCES "Departments" ("dept_no") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- DATA ANALYSIS

-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT emp.emp_no, emp.last_name, emp.first_name, emp.sex, sal.salary
FROM "Employees" AS emp
INNER JOIN "Salaries" AS sal ON emp.emp_no = sal.emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM "Employees"
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM "Dept_manager" AS dm
JOIN "Departments" AS d ON dm.dept_no = d.dept_no
JOIN "Employees" AS e ON dm.emp_no = e.emp_no;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, de.dept_no, d.dept_name
FROM "Dept_emp" AS de
JOIN "Employees" AS e ON de.emp_no = e.emp_no
JOIN "Departments" AS d ON de.dept_no = d.dept_no;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM "Employees"
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT e.emp_no, e.last_name, e.first_name
FROM "Dept_emp" AS de
JOIN "Employees" AS e ON de.emp_no = e.emp_no
WHERE de.dept_no = 'Sales';

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM "Dept_emp" AS de
JOIN "Employees" AS e ON de.emp_no = e.emp_no
JOIN "Departments" AS d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, COUNT(*) AS frequency
FROM "Employees"
GROUP BY last_name
ORDER BY frequency DESC;