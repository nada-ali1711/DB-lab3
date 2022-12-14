create schema depatrments;
use depatrments;
/*#############################################################################*/
Create Table DEPT(
Dnumber INT Not Null,
Dname Varchar(20),
Founded Date,
Mgr_ssn Varchar(20),
Budget Varchar(30),
Primary Key (Dnumber)
);

Create Table EMPLOYEE(
Ssn Varchar(20) Not Null,
Ename Varchar(20),
Bdate Date,
Dno INT ,
Salary float,
Primary Key (Ssn),
Foreign Key (Dno) References DEPT(Dnumber)
);

alter table DEPT add constraint fk1
foreign key (Mgr_ssn)
references EMPLOYEE (Ssn) on update cascade on delete set null;

/*#############################################################################*/

/*add tubles to DEPT Table*/ 
Insert into DEPT values("1","CSED", "1970-10-30", null, "5000000000");
Insert into DEPT values("5","biology", "1888-1-6", null, "400000000");
Insert into DEPT values("6","communication", "1970-10-30", null, "5000000000");
Insert into DEPT values("7","production", "1830-7-6", null, "400000000");


Insert into EMPLOYEE values("1511", "Hassan Mahfouz", "1999-11-30", 1, 12000);
Insert into EMPLOYEE values("2511","Ahmed Mohamed", "1979-8-30", 1, 8000);
Insert into EMPLOYEE values("3148","Abbas Mahfouz", "2001-11-5", 1, 3000);
Insert into EMPLOYEE values("3679","Mahfouz", "1547-11-30", 1, 5000);
Insert into EMPLOYEE values("1479","Ahmed Omar", "2001-8-30", 1, 8000);
Insert into EMPLOYEE values("1561","Amira", "1898-2-8", 1, 8000);
Insert into EMPLOYEE values("1546","Shahd Ayman", "1867-2-8", 1, 8000);
Insert into EMPLOYEE values("1460","Shahd Mohamed", "1867-2-8", 1, "8000");

Insert into EMPLOYEE values("5045","Bassam Mahfouz", "1888-1-6", 5, 13000);
Insert into EMPLOYEE values("1568","Shahd", "1867-2-8", 5, 8000);
Insert into EMPLOYEE values("8637","Dina Khaled", "1977-2-8", 5, 3000);
Insert into EMPLOYEE values("7896","Omar", "2002-11-5", 5, 3000);
Insert into EMPLOYEE values("8623","Dina ALi", "1977-2-8", 5, 3000);
Insert into EMPLOYEE values("1659","Amira", "1898-2-8", 5, 8000);
Insert into EMPLOYEE values("5556","Mohamed Ali", "1897-7-5", 5, 8000);

Insert into EMPLOYEE values(4478,"Fahmy Mahfouz", "1999-10-30", 6, 20000);
Insert into EMPLOYEE values("7789","Ahmed Ali", "1877-1-6", 6, 3000);

Insert into EMPLOYEE values("3397","Ali Hassan", "1677-1-6", 7, 30000);
Insert into EMPLOYEE values("3398","Hassan khaled", "1688-12-6", 7, 5000);

/*#############################################################################*/


update DEPT 
SET Mgr_ssn = "1511"
where Dnumber = 1;

update DEPT 
SET Mgr_ssn = "5045"
where Dnumber = 5;

update DEPT 
SET Mgr_ssn ="4478"
where Dnumber = 6;

update DEPT 
SET Mgr_ssn = "3397"
where Dnumber = 7;

/*#############################################################################*/

Select * 
From Dept;

Select * 
From EMPLOYEE;

/*#############################################################################*/
/*returns the number of employees working for the department Dnumber*/

DELIMITER //
CREATE FUNCTION Count_Emp (dnumber INT) RETURNS INT DETERMINISTIC
BEGIN
	DECLARE num_employee INT;
	select Count(Ssn) into num_employee from EMPLOYEE where Dno = dnumber;
	RETURN num_employee;
END
//
DELIMITER ;

/*TEST the Fumction*/
SELECT Dnumber, Count_Emp(Dnumber) as 'num_employees', Dname, Founded, Mgr_ssn, Budget from DEPT;

/*#############################################################################*/
/*ensures Year(DEPT.Founded) >=1960 for all departments else set it "01-1-1960"*/

DELIMITER //
CREATE PROCEDURE ensuresFoundYear()  
BEGIN  
	UPDATE DEPT
	SET Founded = CASE
		WHEN  year(Founded) < 1960 THEN "1960-1-1"
		ELSE Founded
		END;
END

//
DELIMITER ;

CALL ensuresFoundYear();

select *
From DEPT;

/*#############################################################################*/
/* trigger to ensure that no department has more than 8 employees*/

DELIMITER //  
Create Trigger before_insert_employee   
BEFORE INSERT ON EMPLOYEE FOR EACH ROW  
BEGIN  
DECLARE num_employee INT;
select Count(Ssn) into num_employee from EMPLOYEE where Dno = New.Dno;
IF num_employee >= 8 THEN signal sqlstate '45000';  
END IF;  
END // 
DELIMITER ;

/*Insert into Dep 1*/
Insert into EMPLOYEE values("5632","Osama Ali", "1997-7-5", 1, 8000);

/*Insert into Dep 5*/
Insert into EMPLOYEE values("5642","Osama Mohamed", "1967-12-5", 5, 8000);

delete from EMPLOYEE
where EMPLOYEE.Ssn = "5478";

/*#############################################################################*/
/*trigger to implement "ON UPDATE CASCADE" for the foreign key EMPLOYEE.Dno.  */

DELIMITER // 
Create Trigger before_update_Dnumber
BEFORE UPDATE ON DEPT FOR EACH ROW
BEGIN
    UPDATE EMPLOYEE
	SET EMPLOYEE.Dno = CASE
		WHEN EMPLOYEE.Dno  <=> OLD.Dnumber THEN null
		ELSE EMPLOYEE.Dno
		END;
END //
DELIMITER ;

DELIMITER // 
Create Trigger casc_after_update_Dnumber
After UPDATE ON DEPT FOR EACH ROW
BEGIN
    UPDATE EMPLOYEE
	SET EMPLOYEE.Dno = CASE
		WHEN EMPLOYEE.Dno  <=> null THEN NEW.Dnumber
		ELSE EMPLOYEE.Dno
		END;
END //
DELIMITER ;


/*Test Case*/
update DEPT  
set DEPT.Dnumber = 101
where DEPT.Dnumber = 1;

Select * 
From Dept;

Select * 
From EMPLOYEE;
/*#############################################################################*/
/* trigger to ensure that whenever an employee is given a raise in 
salary, his department manager's salary must be increased to be at least as 
much. 
*/

DELIMITER //
CREATE PROCEDURE updateSal(IN Ssn Varchar(20), IN inc float)  
BEGIN  
DECLARE s numeric;
DECLARE d INT;
declare m_ssn Varchar(20);
declare mgs float;

SELECT Salary, Dno INTO s, d
FROM EMPLOYEE
WHERE EMPLOYEE.Ssn = Ssn;

SELECT Mgr_ssn, Salary INTO m_ssn, mgs
FROM DEPT, EMPLOYEE
where DEPT.Dnumber = d AND DEPT.Mgr_ssn = EMPLOYEE.Ssn;

UPDATE EMPLOYEE
SET EMPLOYEE.Salary = s  + s * inc
Where EMPLOYEE.Ssn = Ssn;

UPDATE EMPLOYEE
SET EMPLOYEE.Salary = CASE
		WHEN mgs  < (s  + s * inc)  THEN (s  + s * inc)
		ELSE mgs
		END
Where EMPLOYEE.Ssn = m_ssn;
END//
DELIMITER ;

call updateSal("1546", 0.6);

Select * 
From EMPLOYEE;

Select * 
From Dept;

