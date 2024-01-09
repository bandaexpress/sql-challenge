CREATE TABLE public."Departments" (
    dept_no character varying(255) NOT NULL,
    dept_name character varying(255) NOT NULL,
	CONSTRAINT "pk_Departments" PRIMARY KEY (dept_no)
);


CREATE TABLE public."Dept_emp" (
    emp_no integer NOT NULL,
    dept_no character varying(255) NOT NULL,
	CONSTRAINT "pk_Dept_emp" PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE public."Dept_manager" (
    dept_no character varying(255) NOT NULL,
    emp_no integer NOT NULL,
	CONSTRAINT "pk_Dept_manager" PRIMARY KEY (dept_no, emp_no)
);

CREATE TABLE public."Employees" (
    emp_no integer NOT NULL,
    emp_title_id character varying(255) NOT NULL,
    birth_date date NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    sex character varying(255) NOT NULL,
    hire_date date NOT NULL,
	CONSTRAINT "pk_Employees" PRIMARY KEY (emp_no)
);


CREATE TABLE public."Salaries" (
    emp_no integer NOT NULL,
    salary integer NOT NULL,
	CONSTRAINT "pk_Salaries" PRIMARY KEY (emp_no)
);


CREATE TABLE public."Titles" (
    title_id character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
	CONSTRAINT "pk_Titles" PRIMARY KEY (title_id)
);