create database hr_processfinal;
show databases;
use hr_processfinal;

create table core_data(
Employee_name varchar(100),
Employee_Number	int primary key,
State  varchar(10),
Zip	int,
Age	int,
Sex	varchar(10),
MaritalDesc	varchar(100),
CitizenDesc	varchar(50),
Hispanic_Latino	char(10),
RaceDesc varchar(50),
Reason_For_Term varchar(100),	
Employment_Status varchar(100),	
Department	varchar(100),
Position varchar(100),
Pay_Rate float,
Manager_Name varchar(100),
Employee_Source varchar(100),	
Performance_Score varchar(100)
);

create table secondary_table(
Employee_Name varchar(100),	
Employee_Number	int primary key,
MarriedID int,
MaritalStatusID int,	
GenderID int,
EmpStatus_ID int,
DeptID	int,
Perf_ScoreID int,	
Age	int,
Pay_Rate float,	
State varchar(10),
Zip	int,
Sex	varchar(10),
MaritalDesc	varchar(100),
CitizenDesc	varchar(50),
Hispanic_Latino	varchar(10),
RaceDesc varchar(50),
Days_Employed	int,
Reason_For_Term	varchar(100),
Employment_Status	varchar(100),
Department	varchar(100),
Position	varchar(100),
Manager_Name	varchar(100),
Employee_Source	varchar(100),
Performance_Score varchar(100),
foreign key (Employee_Number) references core_data(Employee_Number) ON DELETE RESTRICT ON UPDATE CASCADE
);

create table tertiary_table(
Employee_Name	varchar(100),
EmpID	int primary key,
MarriedID	int,
MaritalStatusID	int,
GenderID	int,
EmpStatusID	int,
DeptID	int,
PerfScoreID	int,
FromDiversityJobFairID	int,
Pay_Rate float,	
Termd	int,
PositionID	int,
Position	varchar(100),
State	varchar(10),
Zip	int,
Sex	varchar(10),
MaritalDesc	varchar(100),
CitizenDesc	varchar(50),
Hispanic_Latino varchar(10),	
RaceDesc	varchar(50),
TermReason	varchar(100),
EmploymentStatus varchar(100),	
Department	varchar(100),
Manager_Name varchar(100),	
ManagerID	int,
RecruitmentSource varchar(100),	
PerformanceScore varchar(100),
EngagementSurvey	float,
EmpSatisfaction	int,
SpecialProjectsCount	int,
DaysLateLast30 int,
foreign key (EmpID) references core_data(Employee_Number) ON DELETE RESTRICT ON UPDATE CASCADE
);

create table production_sheet(
Employee_Name 	varchar(100),
RaceDesc	varchar(50),	
EmploymentStatus varchar(100),	
Department	varchar(100),
Position	varchar(100),
Pay	float,
Manager_Name	varchar(100),
PerformanceScore	varchar(100),
Abutments_Hour_Wk_1	int,
Abutments_Hour_Wk_2	int,
Daily_Error_Rate	int,
90_day_Complaints int
);


alter  table production_sheet
add column Pay varchar(100);

create table recruiting_costs(
Employment_Source	varchar(100) primary key,
January 	int,
February	int,
March	int,
April	int,
May	int,
June	int,
July	int,
August	int,
September	int,
October	int,
November	int,
December	int,
Total int
);

select * from core_data;

select * from secondary_table;

select * from recruiting_costs;

select * from production_sheet;

select * from tertiary_table;

/*departments with highest turnover*/
SELECT Department, COUNT(*) AS Termination_Count
FROM core_data
WHERE Reason_For_Term IS NOT NULL
GROUP BY Department
ORDER BY Termination_Count DESC;

/*employees with top performance score*/
SELECT Employee_Name, Performance_Score
FROM core_data
ORDER BY Performance_Score DESC
LIMIT 10;


/*Average Age of Employees by Gender*/
SELECT Sex, count(Sex) AS count
FROM core_data
GROUP BY Sex;

/*Employees with Highest Performance Score in Each Department*/
SELECT Department, Employee_Name, Performance_Score
FROM core_data c1
WHERE Performance_Score = (
    SELECT MAX(Performance_Score)
    FROM core_data c2
    WHERE c1.Department = c2.Department
);





/*Employees with Above-Average Pay Rates in Their Department*/
SELECT c.Employee_Name, c.Department, c.Pay_Rate
FROM core_data c
JOIN (
    SELECT Department, AVG(Pay_Rate) AS Avg_Pay_Rate
    FROM core_data
    GROUP BY Department
) AS avg_pay ON c.Department = avg_pay.Department
WHERE c.Pay_Rate > avg_pay.Avg_Pay_Rate;

/*Average Pay Rate for Employees in Each Position*/
SELECT Position, AVG(Pay_Rate) AS Average_Pay_Rate
FROM core_data
GROUP BY Position;

