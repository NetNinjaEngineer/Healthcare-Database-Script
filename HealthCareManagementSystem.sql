CREATE DATABASE HealthCareDB;
GO

USE HealthCareDB;
GO

CREATE TABLE Patients(
	PatientId INT PRIMARY KEY IDENTITY(1, 1),
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Gender VARCHAR(10) NOT NULL,
	Phone VARCHAR(20) NOT NULL,
	Email VARCHAR(100) NOT NULL
);
GO

CREATE TABLE Departments(
	DepartmentId INT PRIMARY KEY IDENTITY(1, 1),
	DepartmentName VARCHAR(50) NULL,
	DepartmentCost DECIMAL(8, 2) NULL
);
GO

CREATE TABLE Employees(
	EmployeeId INT PRIMARY KEY IDENTITY(1, 1),
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Gender VARCHAR(10) NOT NULL,
	JobTitle VARCHAR(20) NOT NULL,
	HireDate DATETIME2 NOT NULL,
	Salary DECIMAL(8, 2) NOT NULL,
	Phone VARCHAR(20) NOT NULL,
	DateOfBirth DATETIME2 NOT NULL,
	DepartmentId INT NOT NULL FOREIGN KEY REFERENCES Departments(DepartmentId)
);
GO

CREATE TABLE Appointments(
	AppointmentId INT PRIMARY KEY IDENTITY(1, 1),
	AppointmentDate Datetime2 NOT NULL,
	AppointmentTime Time NOT NULL,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(EmployeeId),
	Paid VARCHAR(10) NOT NULL DEFAULT 'UNPAID',
	PatientId INT NOT NULL FOREIGN KEY REFERENCES Patients(PatientId)
);
GO

CREATE TABLE Logins(
	Id INT PRIMARY KEY IDENTITY(1, 1),
	UserName VARCHAR(20) NOT NULL,
    Email VARCHAR(100) NULL,
	Password VARCHAR(50) NOT NULL,
	AuthCode VARCHAR(5) NULL,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(EmployeeId)
);

CREATE TABLE EmployeeSchedule(
	SchedualId INT PRIMARY KEY IDENTITY(1, 1),
	DayOfWeek INT NOT NULL,
	StartTime TIME NOT NULL,
	EndTime TIME NOT NULL,
	EmployeeId INT NOT NULL FOREIGN KEY REFERENCES Employees(EmployeeId)
);

CREATE TABLE Prescriptions(
	PrescriptionId INT PRIMARY KEY IDENTITY(1, 1),
	PatientId INT FOREIGN KEY REFERENCES Patients(PatientId),
	Diagnosis VARCHAR(100) NOT NULL,
);
GO

CREATE TABLE PatientsPrescriptions(
	ID INT PRIMARY KEY IDENTITY(1, 1),
	PrescriptionId INT FOREIGN KEY REFERENCES Prescriptions(PrescriptionId),
	MedicineName VARCHAR(30) NOT NULL,
	Dosage VARCHAR(20) NOT NULL,
	Times VARCHAR(20) NOT NULL
);
GO

CREATE TABLE Medicines(
	MedicineId INT PRIMARY KEY IDENTITY(1, 1),
	Name VARCHAR(20) NOT NULL,
	ExpireDate DATETIME2 NOT NULL,
	StockQuantity INT NOT NULL,
	UnitPrice DECIMAL(8, 2) NOT NULL,
	CurrentQuantity INT NOT NULL
);

CREATE TABLE MedicineDosages(
	MedicineId INT FOREIGN KEY REFERENCES Medicines(MedicineId),
	Dosage VARCHAR(15) NOT NULL
);

CREATE TABLE Stocks(
	StockId INT PRIMARY KEY IDENTITY(1, 1),
	MedicineId INT FOREIGN KEY REFERENCES Medicines(MedicineId),
	BoxQuantity INT NOT NULL,
	LastUpdated DATETIME2 NOT NULL
);

CREATE TABLE Suppliers(
	SupplierId INT PRIMARY KEY IDENTITY(1, 1),
	SupplierName VARCHAR(20) NOT NULL,
	Email VARCHAR(100) NOT NULL,
	Phone VARCHAR(20) NOT NULL
);

CREATE TABLE SuppliersMedicines(
	SupplierId INT FOREIGN KEY REFERENCES Suppliers(SupplierId),
	MedicineId INT FOREIGN KEY REFERENCES Medicines(MedicineId),
	PRIMARY KEY (SupplierId, MedicineId)
);

CREATE TABLE PharmacyTransactions (
    TransactionId INT PRIMARY KEY,
    PrescriptionId INT,
	MedicineId INT,
    QuantitySold INT,
    TransactionDate DATE,
    FOREIGN KEY (PrescriptionId) REFERENCES Prescriptions(PrescriptionId),
    FOREIGN KEY (MedicineId) REFERENCES Medicines(MedicineId)
);

INSERT INTO Appointments (AppointmentDate, AppointmentTime, EmployeeId, Paid, PatientId)
    VALUES
    ('2024-04-01', '09:00:00', 4, 'UNPAID', 1),
    ('2024-04-02', '10:00:00', 4, 'UNPAID', 2),
    ('2024-04-03', '11:00:00', 4, 'UNPAID', 3),
    ('2024-04-04', '12:00:00', 11, 'UNPAID', 4),
    ('2024-04-05', '13:00:00', 11, 'UNPAID', 5),
    ('2024-04-06', '14:00:00', 11, 'UNPAID', 6),
    ('2024-04-07', '15:00:00', 12, 'UNPAID', 7),
    ('2024-04-08', '16:00:00', 12, 'UNPAID', 8),
    ('2024-04-09', '17:00:00', 12, 'UNPAID', 9),
    ('2024-04-10', '18:00:00', 12, 'UNPAID', 10);



INSERT INTO Departments(DepartmentName, DepartmentCost)
	VALUES
	('Cardiology', 100),
	('Pediatrics', 150),
	('Orthopedics', 90),
	('Dermatology', 250),
	('Neurology', 1500),
	('Ophthalmology', 2500),
	('Gastroenterology', 1250),
	('Obstetrics and Gynecology', 3500),
	('Endocrinology', 800),
	('Receptionist', NULL),
	('Pharmacy', NULL),
	('Accounting', NULL),
	('Laboratory', NULL);

	INSERT INTO Departments (DepartmentName, DepartmentCost)
	VALUES ('ADMINSTRATION', NULL);


INSERT INTO Employees (FirstName, LastName, Gender, JobTitle, HireDate, Salary, Phone, DateOfBirth, DepartmentId)
VALUES
('John', 'Doe', 'Male', 'Doctor', '2023-11-08', 75000, '123-456-7890', '1990-05-15', 6),
  ('Jane', 'Smith', 'Female', 'Nurse', '2023-11-08', 60000, '456-789-0123', '1992-03-20', 1),
  ('Robert', 'Johnson', 'Male', 'Pharmacist', '2023-11-08', 80000, '789-012-3456', '1985-09-10', 11),
  ('Alice', 'Brown', 'Female', 'Nurse', '2023-11-08', 55000, '234-567-8901', '1988-07-25', 9),
  ('Michael', 'Clark', 'Male', 'Admin', '2023-11-08', 62000, '567-890-1234', '1991-12-30', 14),
  ('Sarah', 'Miller', 'Female', 'Nurse', '2023-11-08', 75000, '345-678-9012', '1987-04-05', 5),
  ('Olivia', 'Johnson', 'Female', 'Nurse', '2023-11-08', 48000, '456-789-0123', '1993-06-12', 6),
  ('James', 'Anderson', 'Male', 'Doctor', '2023-11-08', 85000, '789-012-3456', '1986-02-28', 1),
  ('Emily', 'White', 'Female', 'Doctor', '2023-11-08', 60000, '234-567-8901', '1991-03-15', 2),
  ('Daniel', 'Lee', 'Male', 'Analysis Doctor', '2023-11-08', 68000, '567-890-1234', '1990-09-22', 13),
  ('Ava', 'Brown', 'Female', 'Receptionist', '2023-11-08', 90000, '345-678-9012', '1984-11-03', 10),
  ('Liam', 'Wilson', 'Male', 'Accountant', '2023-11-08', 72000, '123-456-7890', '1995-07-11', 12),
  ('Sophia', 'Garcia', 'Female', 'Accountant', '2023-11-08', 67000, '456-789-0123', '1989-12-27', 12),
  ('Benjamin', 'Smith', 'Male', 'Accountant', '2023-11-08', 62000, '789-012-3456', '1991-04-09', 12),
  ('Mia', 'Martinez', 'Female', 'Receptionist', '2023-11-08', 74000, '234-567-8901', '1993-01-07', 10),
  ('Elijah', 'Harris', 'Male', 'Receptionist', '2023-11-08', 88000, '567-890-1234', '1987-10-14', 10),
  ('Charlotte', 'Davis', 'Female', 'Receptionist', '2023-11-08', 52000, '345-678-9012', '1990-02-01', 10);

INSERT INTO Patients(FirstName, LastName, Gender, Phone, Email)
VALUES
    ('John', 'Smith', 'Male', '123-456-7890', 'John@gmail.com'),
    ('Emily', 'Johnson', 'Female','111-222-3333', 'Emily@gmail.com'),
    ('David','Davis', 'Male', '777-888-9999', 'David@gmail.com'),
    ('Sarah','Williams', 'Female','444-555-6666','Sarah@gmail.com' ),
    ('Michael', 'Brown', 'Male', '555-123-4567', 'Michael@gmail.com'),
    ('Jennifer','Wilson', 'Female', '987-654-3210', 'Jennifer@gmail.com'),
    ('Christopher','Lee', 'Male','123-456-7870', 'Christopher@gmail.com'),
    ('Amanda', 'Taylor', 'Female', '789-456-7870', 'Amanda@gmail.com'),
    ('Samantha', 'Evans', 'Female','456-005-7870', 'Samantha@gmail.com');

INSERT INTO EmployeeSchedule(DayOfWeek, StartTime, EndTime, EmployeeId)
VALUES
    (1, '08:00:00', '12:00:00', 1),
    (2, '09:00:00', '13:00:00', 2),
    (3, '10:00:00', '14:00:00', 3),
    (4, '11:00:00', '15:00:00', 4),
    (5,'12:00:00', '16:00:00',  5),
    (6, '13:00:00', '17:00:00', 6),
    (0, '14:00:00', '18:00:00', 7),
	(0, '15:00:00', '19:00:00', 8),
    (5, '16:00:00', '20:00:00', 8),
    (5, '17:00:00', '21:00:00', 9),
    (5, '08:30:00', '12:30:00', 9),
    (3, '09:30:00', '13:30:00', 10),
    (4, '10:30:00', '14:30:00', 1),
    (2, '11:30:00', '15:30:00', 1),
    (1, '12:30:00', '16:30:00', 11),
    (4, '13:30:00', '17:30:00', 12),
    (6, '14:30:00', '18:30:00', 13);

	UPDATE EmployeeSchedule SET  DayOfWeek = 0 WHERE SchedualId = 7;
	UPDATE EmployeeSchedule SET  DayOfWeek = 0 WHERE SchedualId = 8;

INSERT INTO [Prescriptions] (PatientId, Diagnosis)
VALUES
    (1, 'Common cold' ),
    (2, 'Hypertension'),
    (3, 'Bronchitis'),
    (4, 'Influenza' ),
    (5, 'Diabetes'),
    (6, 'Migraine'),
    (7, 'Gastroenteritis'),
    (8, 'Allergies' ),
    (9, 'Arthritis' );

INSERT INTO [HealthCareDB].[dbo].[PatientsPrescriptions] (PrescriptionId, MedicineName, Dosage, Times)
VALUES
    (1, 'Aspirin'     ,'100mg', '2 times a day' ),
    (2, 'Lisinopril'  ,'10mg', '1 time a day'  ),
    (3, 'Amoxicillin' ,'500mg', '3 times a day'  ),
    (4, 'Ibuprofen'   ,'200mg', '4 times a day' ),
    (5, 'Atorvastatin','20mg', '1 time a day' ),
    (6, 'Metformin'   ,'1000mg', '2 times a day' ),
    (7, 'Losartan'    ,'50mg', '1 time a day'  ),
    (8, 'Omeprazole'  ,'40mg', '1 time a day' ),
    (9, 'Prednisone'  ,'5mg', '2 times a day'  );

CREATE OR ALTER VIEW dbo.ShowSchedule
AS
SELECT CONCAT(EMP.FirstName, ' ', EMP.LastName) AS Employee,
CASE
		WHEN ES.DayOfWeek = 0 THEN 'SUN'
		WHEN ES.DayOfWeek = 1 THEN 'MON'
		WHEN ES.DayOfWeek = 2 THEN 'TUE'
		WHEN ES.DayOfWeek = 3 THEN 'WED'
		WHEN ES.DayOfWeek = 4 THEN 'THU'
		WHEN ES.DayOfWeek = 5 THEN 'FRI'
		WHEN ES.DayOfWeek = 6 THEN 'SAT'
	ELSE 'INVALID DAY'
END AS DayOfWeek, ES.StartTime, ES.EndTime, EMP.JobTitle
FROM
EmployeeSchedule AS ES
INNER JOIN Employees AS EMP ON EMP.EmployeeId = ES.EmployeeId;

SELECT  * FROM dbo.ShowSchedule;

CREATE OR ALTER VIEW dbo.GetPatientsWithAppointments
AS
	SELECT A.AppointmentId, CONCAT(P.FirstName, ' ', P.LastName) AS Patient,
	 A.AppointmentDate, A.AppointmentTime, CONCAT(EMP.FirstName, ' ', EMP.LastName) AS Doctor,
	 DEP.DepartmentCost, A.Paid
	FROM Appointments A INNER JOIN Employees EMP 
	 ON A.EmployeeId = EMP.EmployeeId
	 AND LOWER(EMP.JobTitle) = LOWER('Doctor')
	INNER JOIN Patients P 
	 ON P.PatientId = A.PatientId
	INNER JOIN Departments DEP 
	 ON DEP.DepartmentId = EMP.DepartmentId;
GO

SELECT * FROM dbo.GetPatientsWithAppointments;

CREATE OR ALTER VIEW dbo.GetEmployeesWithDepartments
AS
	SELECT
	CONCAT(EMP.FirstName, ' ', EMP.LastName) AS Employee ,DEP.DepartmentName, EMP.JobTitle
	FROM Employees EMP INNER JOIN Departments DEP
	 ON EMP.DepartmentId = DEP.DepartmentId;
GO

SELECT * FROM dbo.GetEmployeesWithDepartments;

CREATE OR ALTER FUNCTION dbo.GetDepartmentId(@employeeId INT)
RETURNS INT
AS
BEGIN
    DECLARE @departmentId INT;

	SELECT @departmentId = DEP.DepartmentId FROM
	 Departments AS DEP INNER JOIN Employees AS EMP 
	  ON DEP.DepartmentId = EMP.DepartmentId
	   WHERE EMP.EmployeeId = @employeeId;

    RETURN @departmentId;
END;

CREATE OR ALTER PROCEDURE dbo.AddAppointment
    @EmployeeId INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Gender VARCHAR(10),
    @Phone VARCHAR(20),
	@Email VARCHAR(100)
AS
BEGIN
    DECLARE @PID INT;
	INSERT INTO Patients(FirstName, LastName, Gender, Phone, Email) VALUES(@FirstName, @LastName, @Gender, @Phone, @Email);
	SELECT @PID = SCOPE_IDENTITY() FROM Patients;

	INSERT INTO Appointments(AppointmentDate, AppointmentTime, Paid, EmployeeId, PatientId)
	 VALUES(GETDATE(), CONVERT(TIME, GETDATE()), 'UNPAID' ,@EmployeeId, @PID);
END
GO

EXEC dbo.AddAppointment 1, 'khalid', 'Emad', 'Male', '01556982921', 'ke9764790@gmail.com'
EXEC dbo.AddAppointment 1, 'Mohamed', 'Ehab', 'Male', '01145753861', 'me5260287@gmail.com'

-- come again
CREATE OR ALTER VIEW dbo.ShowPatientPrescriptions
AS
	SELECT CONCAT(P.FirstName, ' ', P.LastName) 
	 AS Patient, PP.MedicineName, PP.Dosage, PP.Times, PRES.Diagnosis,
	  CONCAT(EMP.FirstName, ' ', EMP.LastName) AS Doctor
	FROM Prescriptions PRES INNER JOIN PatientsPrescriptions PP
		ON PRES.PrescriptionId = PP.PrescriptionId 
		INNER JOIN Patients P ON P.PatientId = PRES.PatientId
		INNER JOIN Appointments A ON A.PatientId = P.PatientId
		INNER JOIN Employees EMP ON EMP.EmployeeId = A.EmployeeId
	WHERE
		EMP.JobTitle = 'Doctor';

GO

SELECT * FROM dbo.ShowPatientPrescriptions;

CREATE OR ALTER PROCEDURE PatientCareAgenda
 @employeeId INT
 AS
	SELECT CONCAT(EMP.FirstName, ' ', EMP.LastName) AS Doctor,
	A.AppointmentDate, A.AppointmentTime, CONCAT(P.FirstName, ' ', P.LastName) Patient
	FROM Appointments A INNER JOIN Employees EMP
	 ON A.EmployeeId = EMP.EmployeeId
	 AND EMP.EmployeeId = @employeeId
	INNER JOIN Patients P ON P.PatientId = A.PatientId
	WHERE EMP.JobTitle = 'Doctor';
 GO
 
 EXEC PatientCareAgenda 1;

CREATE OR ALTER PROCEDURE dbo.GetPatientPrescription
 @PrescriptionId INT
AS
BEGIN
	SELECT CONCAT(P.FirstName, ' ', P.LastName) AS Patient
	, PP.MedicineName, PP.Dosage, PP.Times, PRES.Diagnosis
	FROM PatientsPrescriptions PP INNER JOIN Prescriptions PRES
	 ON PP.PrescriptionId = PRES.PrescriptionId
	 AND PP.PrescriptionId = @PrescriptionId
	 INNER JOIN Patients P ON P.PatientId = PRES.PatientId
END
GO

EXEC dbo.GetPatientPrescription 14;

CREATE OR ALTER FUNCTION dbo.CheckDoctorAvailability(@doctorId INT, @dayOfWeek INT)
RETURNS VARCHAR(15)
AS
BEGIN
    DECLARE @available BIT;
	DECLARE @Result VARCHAR(15);

    SELECT @available = CASE
        WHEN @dayOfWeek = ES.DayOfWeek
            AND ES.EmployeeId = @doctorId
            THEN 1
        ELSE 0
    END
    FROM EmployeeSchedule ES
    INNER JOIN Employees E ON ES.EmployeeId = E.EmployeeId
    INNER JOIN Departments DEP ON DEP.DepartmentId = E.DepartmentId
    WHERE E.JobTitle = 'Doctor' AND E.EmployeeId = @doctorId;

	IF @available =1
		SET @Result = 'Available'
	ELSE
		SET @Result = 'UnAvailable'

	RETURN @Result;

END;

	

CREATE OR ALTER PROCEDURE dbo.AddDepartment
 @departmentName VARCHAR(50),
 @departmentCost DECIMAL(8, 2)
AS
BEGIN
	INSERT INTO Departments(DepartmentName, DepartmentCost)
		VALUES(@departmentName, @departmentCost);
END
GO

EXEC dbo.AddDepartment 'Surgery', 5000;

CREATE OR ALTER PROCEDURE dbo.AddEmployeeToDepartment
	@departmentId INT,
	@firstName VARCHAR(50),
	@lastName VARCHAR(50),
	@gender VARCHAR(10),
	@jobTitle VARCHAR(20),
	@hireDate DATETIME2,
	@salary DECIMAL(8, 2),
	@phone VARCHAR(20),
	@dateOfBirth DATETIME2
AS
BEGIN
	INSERT INTO Employees(FirstName, LastName, Gender, JobTitle, HireDate, Salary, Phone, DateOfBirth, DepartmentId)
		VALUES(@firstName, @lastName, @gender, @jobTitle, @hireDate,
		 @salary, @phone, @dateOfBirth, @departmentId);
END
GO

CREATE OR ALTER PROCEDURE dbo.AddPateint
	@firstName VARCHAR(50),
	@lastName VARCHAR(50),
	@gender VARCHAR(10),
	@phone VARCHAR(20),
	@email VARCHAR(100)
AS
BEGIN
	INSERT INTO Patients(FirstName, LastName, Gender, Phone, Email)
		VALUES(@firstName, @lastName, @gender, @phone, @email);
END
GO

EXEC dbo.AddPateint 'Mohamed', 'Ehab', 'Male', '01145753861', 
 'mohamed@test.com';

CREATE OR ALTER VIEW dbo.GetPateints
	AS
SELECT CONCAT(P.FirstName, ' ', P.LastName) AS FullName,
	Gender, Phone, Email
FROM Patients AS P;

SELECT * FROM dbo.GetPateints;

CREATE OR ALTER PROCEDURE dbo.AddEmployeeToSchedual
	@dayOfWeek INT,
	@startTime TIME,
	@endTime TIME,
	@firstName VARCHAR(50),
	@lastName VARCHAR(50),
	@gender VARCHAR(10),
	@jobTitle VARCHAR(20),
	@salary DECIMAL(8, 2),
	@phone VARCHAR(20),
	@dateOfBirth DATETIME2,
	@depId INT
AS
BEGIN
	DECLARE @employeeId INT;

	INSERT INTO Employees(FirstName, LastName, Gender, JobTitle, HireDate, Salary, Phone, DateOfBirth, DepartmentId)
		VALUES(@firstName, @lastName, @gender, @jobTitle, GETDATE(), @salary, @phone, @dateOfBirth, @depId);
		
	SELECT @employeeId = SCOPE_IDENTITY() FROM Employees;

	INSERT INTO EmployeeSchedule(DayOfWeek, StartTime, EndTime, EmployeeId)
		VALUES (@dayOfWeek, @startTime, @endTime, @employeeId);
END
GO

CREATE OR ALTER VIEW MedicineStock
AS
    SELECT 
        M.MedicineId,
        M.Name AS MedicineName,
        M.ExpireDate,
        M.StockQuantity,
        M.UnitPrice,
        M.CurrentQuantity,
        S.BoxQuantity,
        S.LastUpdated
    FROM Medicines M
    INNER JOIN Stocks S ON M.MedicineId = S.MedicineId;
GO

SELECT * FROM MedicineStock;

CREATE OR ALTER VIEW dbo.PatientsWithCheckupCosts
AS
SELECT CONCAT(P.FirstName, ' ', P.LastName) AS Patient,
CONCAT(EMP.FirstName, ' ', EMP.LastName) AS Doctor, A.AppointmentDate, 
A.AppointmentTime, P.Gender, DEPT.DepartmentCost AS "CostofDiagnosis", A.Paid
FROM Employees EMP INNER JOIN Departments DEPT
	ON EMP.DepartmentId = DEPT.DepartmentId
	INNER JOIN Appointments A 
	ON A.EmployeeId = EMP.EmployeeId
	INNER JOIN Patients P
	ON P.PatientId = A.PatientId;

SELECT * FROM dbo.PatientsWithCheckupCosts;

CREATE OR ALTER PROCEDURE dbo.GetPatientWithCheckupCostByFullName
	@fullName VARCHAR(50)
AS
	SELECT * FROM dbo.PatientsWithCheckupCosts
		WHERE Patient LIKE '%' + LOWER(@fullName) + '%';

EXEC dbo.GetPatientWithCheckupCostByFullName 'emi';

CREATE OR ALTER PROCEDURE dbo.GetPatientsByFullName
	@fullName VARCHAR(50)
AS
BEGIN
	SELECT *
	FROM Patients P 
	WHERE LOWER(CONCAT(P.FirstName, ' ', P.LastName)) LIKE '%' + LOWER(@fullName) + '%';
END
GO

EXEC dbo.GetPatientsByFullName 'Mohamed El';

CREATE OR ALTER PROCEDURE dbo.GetAppointmentFor
	@fullName VARCHAR(50)
AS
	SELECT * FROM GetPatientsWithAppointments PA 
		WHERE LOWER(PA.Patient) LIKE '%' + LOWER(@fullName) + '%';

EXEC dbo.GetAppointmentFor 'elhela';

CREATE OR ALTER PROCEDURE dbo.UpdatePaymentStatusForPatient
	@appointmentId INT
AS
	UPDATE Appointments SET Paid = 'PAID' 
		WHERE AppointmentId = @appointmentId;

EXEC dbo.UpdatePaymentStatusForPatient 2;


CREATE OR ALTER VIEW dbo.GetPaidAppointments
AS
	SELECT * FROM GetPatientsWithAppointments
		WHERE Paid = 'PAID';
GO

SELECT * FROM dbo.GetPaidAppointments;

-- Insert 100 suppliers with random data
DECLARE @Suppliers TABLE (
    [SupplierName] VARCHAR(100),
    [Email] VARCHAR(100),
    [Phone] VARCHAR(20)
);

DECLARE @Counter INT = 1;

WHILE @Counter <= 100
BEGIN
    INSERT INTO @Suppliers
    VALUES (
        'Supplier' + CAST(@Counter AS VARCHAR(3)),
        'supplier' + CAST(@Counter AS VARCHAR(3)) + '@example.com',
        '123-456-789' + RIGHT('00' + CAST(@Counter AS VARCHAR(3)), 3)
    );

    SET @Counter = @Counter + 1;
END;

INSERT INTO [HealthCareDB].[dbo].[Suppliers] ([SupplierName], [Email], [Phone])
SELECT [SupplierName], [Email], [Phone] FROM @Suppliers;

SELECT TOP (1000) [SupplierId], [SupplierName], [Email], [Phone]
FROM [HealthCareDB].[dbo].[Suppliers];

INSERT INTO [HealthCareDB].[dbo].[Medicines] (
    [Name],
    [ExpireDate],
    [StockQuantity],
    [UnitPrice],
    [CurrentQuantity]
)
VALUES
    ('Aspirin', '2023-12-31', 100, 2.50, 90),
    ('Ibuprofen', '2023-11-30', 50, 5.75, 40),
    ('Paracetamol', '2023-10-15', 75, 3.25, 60),
    ('Amoxicillin', '2023-09-20', 30, 8.00, 25),
    ('Omeprazole', '2023-08-31', 20, 15.50, 15),
    ('Ciprofloxacin', '2023-07-15', 40, 12.75, 35),
    ('Lisinopril', '2023-06-30', 60, 6.25, 55),
    ('Simvastatin', '2023-05-10', 25, 7.50, 20),
	('Acetaminophen', '2023-12-31', 100, 2.50, 90),
    ('Aspirin', '2023-11-30', 50, 5.75, 40),
    ('Ibuprofen', '2023-10-15', 75, 3.25, 60),
    ('Naproxen', '2023-09-20', 30, 8.00, 25),
    ('Omeprazole', '2023-08-31', 20, 15.50, 15),
    ('Ciprofloxacin', '2023-07-15', 40, 12.75, 35),
    ('Lisinopril', '2023-06-30', 60, 6.25, 55),
    ('Simvastatin', '2023-05-10', 25, 7.50, 20),
    ('Atorvastatin', '2023-04-15', 35, 10.25, 30),
    ('Losartan', '2023-03-20', 45, 4.75, 40),
    ('Levothyroxine', '2023-02-28', 55, 3.00, 50),
    ('Metformin', '2023-01-31', 65, 6.75, 60),
    ('Warfarin', '2022-12-15', 75, 9.50, 70),
    ('Gabapentin', '2022-11-30', 85, 7.25, 80),
    ('Amoxicillin', '2022-10-15', 95, 5.00, 90),
    ('Cephalexin', '2022-09-20', 105, 8.75, 100),
    ('Azithromycin', '2022-08-31', 115, 10.00, 110),
    ('Hydrochlorothiazide', '2022-08-15', 125, 4.25, 120),
    ('Furosemide', '2022-07-01', 135, 3.50, 130),
    ('Metoprolol', '2022-06-15', 145, 6.00, 140),
    ('Amlodipine', '2022-05-30', 155, 7.75, 150),
    ('Alprazolam', '2022-05-01', 165, 5.50, 160),
    ('Sertraline', '2022-04-10', 175, 8.25, 170),
    ('Oxycodone', '2022-03-20', 185, 12.00, 180),
    ('Hydrocodone', '2022-02-28', 195, 15.25, 190),
    ('Lorazepam', '2022-01-31', 205, 11.50, 200),
    ('Citalopram', '2021-12-15', 215, 9.75, 210),
    ('Diazepam', '2021-11-30', 225, 7.00, 220),
    ('Clonazepam', '2021-10-15', 235, 10.75, 230),
    ('Tramadol', '2021-09-20', 245, 8.50, 240),
    ('Codeine', '2021-08-31', 255, 5.25, 250),
    ('Morphine', '2021-08-15', 265, 14.00, 260),
    ('Methadone', '2021-07-01', 275, 13.25, 270),
    ('Buprenorphine', '2021-06-15', 285, 16.50, 280),
    ('Naltrexone', '2021-05-30', 295, 18.75, 290),
    ('Ezetimibe', '2021-05-01', 305, 19.00, 300),
    ('Sildenafil', '2021-04-10', 315, 8.00, 310),
    ('Tadalafil', '2021-03-20', 325, 12.25, 320),
    ('Finasteride', '2021-02-28', 335, 7.75, 330),
    ('Dutasteride', '2021-01-31', 345, 14.50, 340),
    ('Bimatoprost', '2020-12-15', 355, 18.25, 350),
    ('Timolol', '2020-11-30', 365, 11.50, 360),
    ('Brinzolamide', '2020-10-15', 375, 15.75, 370);

INSERT INTO [HealthCareDB].[dbo].[Medicines] (
    [Name],
    [ExpireDate],
    [StockQuantity],
    [UnitPrice],
    [CurrentQuantity]
)
VALUES
	('Dorzolamide', '2020-09-20', 385, 9.00, 380),
    ('Latranquil', '2020-08-31', 395, 7.25, 390),
    ('Propofol', '2020-08-15', 405, 16.00, 400),
    ('Ketamine', '2020-07-01', 415, 20.25, 410),
    ('Midazolam', '2020-06-15', 425, 17.50, 420),
    ('Fentanyl', '2020-05-30', 435, 21.75, 430),
    ('Morphine Sulfate', '2020-05-01', 445, 13.00, 440),
    ('Hydromorphone', '2020-04-10', 455, 14.25, 450),
    ('Oxymorphone', '2020-03-20', 465, 18.50, 460),
    ('Codeine Sulfate', '2020-02-28', 475, 11.75, 470),
    ('Gabapentin Enacarbil', '2019-12-15', 495, 9.25, 490),
    ('Pregabalin', '2019-11-30', 505, 8.50, 500),
    ('Topiramate', '2019-10-15', 515, 7.75, 510),
    ('Zonisamide', '2019-09-20', 525, 6.00, 520),
    ('Levetiracetam', '2019-08-31', 535, 5.25, 530),
    ('Carbamazepine', '2019-08-15', 545, 4.50, 540),
    ('Oxcarbazepine', '2019-07-01', 555, 3.75, 550),
    ('Lamotrigine', '2019-06-15', 565, 3.00, 560),
    ('Valproic Acid', '2019-05-30', 575, 2.25, 570),
    ('Divalproex Sodium', '2019-05-01', 585, 1.50, 580),
    ('Lacosamide', '2019-04-10', 595, 0.75, 590),
    ('Rufinamide', '2019-03-20', 605, 1.00, 600),
    ('Ezogabine', '2019-02-28', 615, 1.25, 610),
    ('Perampanel', '2019-01-31', 625, 1.50, 620),
    ('Vigabatrin', '2018-12-15', 635, 1.75, 630),
    ('Tiagabine', '2018-11-30', 645, 2.00, 640),
    ('Ethosuximide', '2018-10-15', 655, 2.25, 650),
    ('Clonazepam', '2018-09-20', 665, 2.50, 660),
    ('Clobazam', '2018-08-31', 675, 2.75, 670),
    ('Diazepam', '2018-08-15', 685, 3.00, 680),
    ('Lorazepam', '2018-07-01', 695, 3.25, 690),
    ('Midazolam', '2018-06-15', 705, 3.50, 700),
    ('Phenobarbital', '2018-05-30', 715, 3.75, 710),
    ('Phenytoin', '2018-05-01', 725, 4.00, 720),
    ('Primidone', '2018-04-10', 735, 4.25, 730),
    ('Vorinostat', '2018-03-20', 745, 4.50, 740),
    ('Panobinostat', '2018-02-28', 755, 4.75, 750),
    ('Romidepsin', '2018-01-31', 765, 5.00, 760),
    ('Belinostat', '2017-12-15', 775, 5.25, 770),
    ('Dronabinol', '2017-11-30', 785, 5.50, 780),
    ('Nabilone', '2017-10-15', 795, 5.75, 790),
    ('Sativex', '2017-09-20', 805, 6.00, 800),
    ('Tetrahydrocannabinol', '2017-08-31', 815, 6.25, 810),
	('Paracetamol Extra', '2023-11-30', 120, 3.50, 100),
    ('Ibuprofen XR', '2024-02-15', 80, 6.75, 60),
    ('Aspirin Plus', '2023-12-31', 90, 4.25, 75),
    ('Amoxicillin 500mg', '2023-10-31', 50, 8.00, 40),
    ('Omeprazole Capsules', '2024-01-15', 60, 15.25, 55),
    ('Ciprofloxacin 250mg', '2023-09-20', 70, 12.00, 65),
    ('Lisinopril 10mg', '2023-08-31', 30, 5.25, 25),
    ('Simvastatin 20mg', '2024-03-01', 100, 7.75, 90),
    ('Diclofenac Sodium', '2023-07-15', 40, 4.75, 35),
    ('Metformin 500mg', '2024-04-01', 65, 3.00, 60),
    ('Levothyroxine 50mcg', '2023-11-15', 55, 9.50, 50),
    ('Prednisone Tablets', '2024-02-28', 25, 5.00, 20),
    ('Clopidogrel 75mg', '2023-10-01', 85, 11.25, 80),
    ('Amlodipine 5mg', '2024-05-10', 20, 6.50, 15),
    ('Hydrochlorothiazide', '2023-12-15', 35, 4.00, 30),
    ('Warfarin 2mg', '2024-01-30', 45, 8.25, 40),
    ('Albuterol Inhaler', '2023-11-01', 15, 18.50, 10),
    ('Fluoxetine 20mg', '2024-02-15', 40, 7.00, 35),
    ('Tramadol 50mg', '2023-09-10', 60, 6.25, 55);

INSERT INTO [HealthCareDB].[dbo].[MedicineDosages] (
    [MedicineId],
    [Dosage]
)
VALUES
    (1, '500 mg'),    -- Acetaminophen
    (2, '325 mg'),    -- Aspirin
    (3, '200 mg'),    -- Ibuprofen
    (4, '220 mg'),    -- Naproxen
    (5, '20 mg'),     -- Omeprazole
    (6, '500 mg'),    -- Ciprofloxacin
    (7, '10 mg'),     -- Lisinopril
    (8, '20 mg'),     -- Simvastatin
    (9, '40 mg'),     -- Atorvastatin
    (10, '50 mg'),    -- Losartan
    (11, '75 mcg'),   -- Levothyroxine
    (12, '500 mg'),   -- Metformin
    (13, '5 mg'),     -- Warfarin
    (14, '300 mg'),   -- Gabapentin
    (15, '500 mg'),   -- Amoxicillin
    (16, '250 mg'),   -- Cephalexin
    (17, '500 mg'),   -- Azithromycin
    (18, '25 mg'),    -- Hydrochlorothiazide
    (19, '40 mg'),    -- Furosemide
    (20, '50 mg'),    -- Metoprolol
    (21, '5 mg'),     -- Amlodipine
    (22, '1 mg'),     -- Alprazolam
    (23, '50 mg'),    -- Sertraline
    (24, '5 mg'),     -- Oxycodone
    (25, '5 mg'),     -- Hydrocodone
    (26, '2 mg'),     -- Lorazepam
    (27, '20 mg'),    -- Citalopram
    (28, '5 mg'),     -- Diazepam
    (29, '1 mg'),     -- Clonazepam
    (30, '50 mg'),    -- Tramadol
    (31, '30 mg'),    -- Codeine
    (32, '10 mg'),    -- Morphine
    (33, '10 mg'),    -- Methadone
    (34, '8 mg'),     -- Buprenorphine
    (35, '50 mg'),    -- Naltrexone
    (36, '10 mg'),    -- Ezetimibe
    (37, '25 mg'),    -- Sildenafil
    (38, '20 mg'),    -- Tadalafil
    (39, '1 mg'),     -- Finasteride
    (40, '0.5 mg'),   -- Dutasteride
    (41, '1 mg'),     -- Bimatoprost
    (42, '5 mg'),     -- Timolol
    (43, '1 mg'),     -- Brinzolamide
    (44, '1 mg'),     -- Dorzolamide
    (45, '10 mg'),    -- Latranquil
    (46, '200 mg'),   -- Propofol
    (47, '50 mg'),    -- Ketamine
    (48, '5 mg'),     -- Midazolam
    (49, '25 mcg'),   -- Fentanyl
    (50, '15 mg'),    -- Morphine Sulfate
    (51, '8 mg'),     -- Hydromorphone
    (63, '250 mg'),   -- Valproic Acid
    (64, '250 mg'),   -- Divalproex Sodium
    (65, '50 mg'),    -- Lacosamide
    (66, '400 mg'),   -- Rufinamide
    (67, '100 mg'),   -- Ezogabine
    (68, '4 mg'),     -- Perampanel
    (69, '500 mg'),   -- Vigabatrin
    (70, '4 mg'),     -- Tiagabine
    (71, '500 mg'),   -- Ethosuximide
    (72, '2 mg'),     -- Clonazepam
    (73, '10 mg'),    -- Clobazam
    (74, '5 mg'),     -- Diazepam
    (75, '2 mg'),     -- Lorazepam
    (76, '1 mg'),     -- Midazolam
    (77, '50 mg'),    -- Phenobarbital
    (78, '100 mg'),   -- Phenytoin
    (79, '250 mg'),   -- Primidone
    (80, '100 mg'),   -- Vorinostat
    (81, '20 mg'),    -- Panobinostat
    (82, '10 mg'),    -- Romidepsin
    (83, '100 mg'),   -- Belinostat
    (84, '5 mg'),     -- Dronabinol
    (85, '5 mg'),     -- Nabilone
    (86, '10 mg'),    -- Sativex
    (87, '10 mg'),    -- Tetrahydrocannabinol
    (88, '10 mg'),    -- Marinol
    (89, '2 mg'),     -- Ropinirole
    (90, '0.5 mg'),   -- Pramipexole
    (91, '4 mg'),     -- Rotigotine
    (92, '10 mg'),    -- Apomorphine
    (93, '10 mg'),    -- Carbidopa/Levodopa
    (94, '200 mg'),   -- Entacapone
    (95, '1 mg'),     -- Rasagiline
    (96, '50 mg'),    -- Safinamide
    (97, '5 mg'),     -- Selegiline
    (98, '2 mg'),     -- Trihexyphenidyl
    (99, '1 mg'),     -- Benztropine
    (100, '100 mg');  -- Amantadine
	
INSERT INTO [HealthCareDB].[dbo].[MedicineDosages] (
    [MedicineId],
    [Dosage]
)
VALUES
    (101, '500mg'),   -- Paracetamol Extra
    (102, 'XR'),       -- Ibuprofen XR
    (103, 'Plus'),     -- Aspirin Plus
    (104, '500mg'),    -- Amoxicillin 500mg
    (105, 'Capsules'), -- Omeprazole Capsules
    (106, '250mg'),    -- Ciprofloxacin 250mg
    (107, '10mg'),     -- Lisinopril 10mg
    (108, '20mg'),     -- Simvastatin 20mg
    (109, 'Sodium'),   -- Diclofenac Sodium
    (110, '500mg'),   -- Metformin 500mg
    (111, '50mcg'),   -- Levothyroxine 50mcg
    (112, 'Tablets'), -- Prednisone Tablets
    (113, '75mg'),    -- Clopidogrel 75mg
    (114, '5mg'),     -- Amlodipine 5mg
    (115, 'Hydrochlorothia'), -- Hydrochlorothiazide
    (116, '2mg'),     -- Warfarin 2mg
    (117, 'Inhaler'),  -- Albuterol Inhaler
    (118, '20mg'),    -- Fluoxetine 20mg
    (119, '50mg');    -- Tramadol 50mg

INSERT INTO [HealthCareDB].[dbo].[MedicineDosages] (
    [MedicineId],
    [Dosage]
)
VALUES
    (120, '2mg'), -- Hydrochlorothiazide
    (121, '2mg'), -- Warfarin 2mg
    (122, '25mg'), -- Albuterol Inhaler
    (123, '20mg'), -- Fluoxetine 20mg
    (124, '50mg'); -- Tramadol 50mg

CREATE OR ALTER VIEW [dbo].[GetMedicinesWithDosages]
AS
	SELECT M.MedicineId,  M.Name, MD.Dosage, M.ExpireDate, 
	M.UnitPrice, M.StockQuantity, M.Image, M.ImagePath
	FROM Medicines M JOIN MedicineDosages MD
		ON M.MedicineId = MD.MedicineId;

SELECT * FROM [dbo].[GetMedicinesWithDosages];

CREATE OR ALTER PROCEDURE [dbo].[SearchMedicineBy]
	@medicineName VARCHAR(20)
AS
BEGIN
	SELECT * FROM [dbo].[GetMedicinesWithDosages]
		WHERE LOWER(Name) LIKE '%'+@medicineName+'%';
END
GO

EXEC [dbo].[SearchMedicineBy] 'TRaM';

CREATE OR ALTER PROCEDURE [dbo].[SearchMedicineBy]
	@medicineName VARCHAR(50)
AS
BEGIN
	SELECT *
	FROM Medicines M INNER JOIN MedicineDosages MD
		ON M.MedicineId = MD.MedicineId
	WHERE LOWER(M.Name) LIKE '%' + LOWER(@medicineName) + '%';
END
GO

CREATE OR ALTER PROCEDURE [dbo].[SearchDoctorBy]
	@doctorName VARCHAR(50)
AS
BEGIN
	SELECT *
	FROM Employees EMP WHERE EMP.JobTitle = 'Doctor'
	AND LOWER(CONCAT(EMP.FirstName, ' ', EMP.LastName))  
	LIKE '%' + LOWER(@doctorName) + '%';
END
GO

EXEC [dbo].[SearchDoctorBy] 'JAM';

EXEC [dbo].[SearchMedicineBy] 'SA'

CREATE OR ALTER PROCEDURE [dbo].[SearchEmployeeBy]
	@employeeName VARCHAR(50)
AS
BEGIN
	SELECT *
	FROM Employees EMP WHERE EMP.JobTitle <> 'Doctor'
	AND LOWER(CONCAT(EMP.FirstName, ' ', EMP.LastName))  
	LIKE '%' + LOWER(@employeeName) + '%';
END
GO

EXEC [dbo].[SearchEmployeeBy] 'john';


INSERT INTO [HealthCareDB].[dbo].[SuppliersMedicines] (
    [SupplierId],
    [MedicineId]
)
VALUES
    -- Suppliers for the first set of medicines
    (1, 1),   -- Aspirin
    (2, 2),   -- Ibuprofen
    (3, 3),   -- Paracetamol
    (4, 4),   -- Amoxicillin
    (5, 5),   -- Omeprazole
    (6, 6),   -- Ciprofloxacin
    (7, 7),   -- Lisinopril
    (8, 8),   -- Simvastatin
    (9, 1),   -- Aspirin (duplicate)
    (10, 2),  -- Ibuprofen (duplicate)
    (11, 9),  -- Naproxen
    (12, 5),  -- Omeprazole (duplicate)
    (13, 6),  -- Ciprofloxacin (duplicate)
    (14, 7),  -- Lisinopril (duplicate)
    (15, 8),  -- Simvastatin (duplicate)
    (16, 10), -- Atorvastatin
    (17, 11), -- Losartan
    (18, 12), -- Levothyroxine
    (19, 13), -- Metformin
    (20, 14), -- Warfarin
    (21, 3),  -- Acetaminophen
    (22, 1),  -- Aspirin (duplicate)
    (23, 2),  -- Ibuprofen (duplicate)
    (24, 15), -- Hydrochlorothiazide
    (25, 16), -- Furosemide
    (26, 17), -- Metoprolol
    (27, 18), -- Amlodipine
    (28, 19), -- Alprazolam
    (29, 20), -- Sertraline
    (30, 21), -- Oxycodone
    (31, 22), -- Hydrocodone
    (32, 23), -- Lorazepam
    (33, 24), -- Citalopram
    (34, 25), -- Diazepam
    (35, 26), -- Clonazepam
    (36, 27), -- Tramadol
    (37, 28), -- Codeine
    (38, 29), -- Morphine
    (39, 30), -- Methadone
    (40, 31), -- Buprenorphine
    (41, 75), -- Ketamine
    (42, 76), -- Midazolam
    (43, 77), -- Fentanyl
    (44, 78), -- Morphine Sulfate
    (45, 79), -- Hydromorphone
    (46, 80), -- Oxymorphone
    (47, 81), -- Codeine Sulfate
    (48, 82), -- Gabapentin Enacarbil
    (49, 83), -- Pregabalin
    (51, 84), -- Topiramate
    (52, 85), -- Zonisamide
    (53, 86), -- Levetiracetam
    (54, 87), -- Carbamazepine
    (55, 88), -- Oxcarbazepine
    (56, 89), -- Lamotrigine
    (57, 90), -- Valproic Acid
    (58, 91), -- Divalproex Sodium
    (59, 92), -- Lacosamide
    (60, 93), -- Rufinamide
    (61, 94), -- Ezogabine
    (62, 95), -- Perampanel
    (63, 96), -- Vigabatrin
    (64, 97), -- Tiagabine
    (65, 98), -- Ethosuximide
    (66, 99), -- Clonazepam
    (67, 100), -- Clobazam
    (68, 101), -- Diazepam
    (69, 102), -- Lorazepam
    (70, 103), -- Midazolam
    (71, 104), -- Phenobarbital
    (72, 105), -- Phenytoin
    (73, 106), -- Primidone
    (74, 107), -- Vorinostat
    (75, 108); -- Pan

CREATE OR ALTER VIEW [dbo].[MedicineInfo]
AS
	SELECT	CONCAT(M.Name, ' has ', CurrentQuantity, ' units ' , ' with cost $', UnitPrice) 
		AS MedicineInfo
	FROM Medicines M;
GO

SELECT * FROM [dbo].[MedicineInfo];
		 
CREATE OR ALTER VIEW [dbo].[GetMedicinesWithDosagesAndSuppliers]
AS
	SELECT M.MedicineId, M.Name, MD.Dosage, M.ExpireDate, M.UnitPrice, M.StockQuantity,
	S.SupplierName, S.Email, S.Phone
	FROM Medicines M INNER JOIN MedicineDosages MD
		ON M.MedicineId = MD.MedicineId
		INNER JOIN SuppliersMedicines SM ON SM.MedicineId = M.MedicineId
		INNER JOIN Suppliers S ON S.SupplierId = SM.SupplierId;

SELECT * FROM [dbo].[GetMedicinesWithDosagesAndSuppliers]

CREATE OR ALTER PROCEDURE [dbo].[GetMedicinesSuppliedBy]
	@supplierId	INT
AS
BEGIN
	SELECT M.MedicineId, M.Name, MD.Dosage, M.ExpireDate, M.UnitPrice, M.StockQuantity,
	S.SupplierName, S.Email, S.Phone
	FROM Medicines M INNER JOIN MedicineDosages MD
		ON M.MedicineId = MD.MedicineId
		INNER JOIN SuppliersMedicines SM ON SM.MedicineId = M.MedicineId
		INNER JOIN Suppliers S ON S.SupplierId = SM.SupplierId
		WHERE SM.SupplierId = @supplierId;

END
GO

EXEC [dbo].[GetMedicinesSuppliedBy] 1;

CREATE OR ALTER VIEW [dbo].[GetMinAndMaxUnitPriceForMedicine]
AS
	SELECT M.Name AS Medicine, M.UnitPrice
	FROM Medicines M WHERE M.UnitPrice = (SELECT MIN(UnitPrice) FROM Medicines) 
	OR UnitPrice = (SELECT MAX(UnitPrice) FROM Medicines);

SELECT * FROM [dbo].[GetMinAndMaxUnitPriceForMedicine];


CREATE OR ALTER VIEW [dbo].[GetMinAndMaxQuantityForMedicine]
AS
	SELECT M.Name AS Medicine, M.CurrentQuantity
	FROM Medicines M WHERE M.CurrentQuantity = (SELECT MIN(CurrentQuantity) FROM Medicines) 
	OR M.UnitPrice = (SELECT MAX(CurrentQuantity) FROM Medicines);

SELECT * FROM [dbo].[GetMinAndMaxQuantityForMedicine];

CREATE OR ALTER VIEW [dbo].[GetSuppliersWithMedicinesProvided]
AS
	SELECT S.SupplierName, S.Phone, S.Email, 
		COUNT(S.SupplierId) AS MedicinesProvided
    FROM
        SuppliersMedicines SM INNER JOIN Suppliers S 
			ON SM.SupplierId = S.SupplierId
    GROUP BY
        S.SupplierName,
        S.Email,
        S.Phone;
GO

SELECT * FROM [dbo].[GetSuppliersWithMedicinesProvided];

CREATE OR ALTER VIEW [dbo].[GetVIPSuppliersWithMedicinesProvided]
AS
	SELECT * FROM [dbo].[GetSuppliersWithMedicinesProvided]
		WHERE MedicinesProvided = (SELECT MAX(MedicinesProvided) 
		FROM [dbo].[GetSuppliersWithMedicinesProvided]);

SELECT * FROM [dbo].[GetVIPSuppliersWithMedicinesProvided];

-- 1 YEAR ==> 12 MONTH => 365 DAY => 24 * 365 = 8,760 HOURS NOT LEAP
-- 1 YEAR ==> 12 MONTH => 366 DAY => 24 * 366 = 8,766 HOURS LEAP

CREATE OR ALTER VIEW [dbo].[GetAgesForHiredEmployees]
AS
    SELECT CONCAT(EMP.FirstName, ' ', EMP.LastName) AS Employee, EMP.JobTitle,
        CASE 
            WHEN (YEAR(EMP.DateOfBirth) % 4 = 0 AND YEAR(EMP.DateOfBirth) % 100 <> 0) OR YEAR(EMP.DateOfBirth) % 400 = 0
                THEN DATEDIFF(HOUR, EMP.DateOfBirth, GETDATE()) / 8766
            ELSE DATEDIFF(HOUR, EMP.DateOfBirth, GETDATE()) / 8760
        END AS Age
    FROM Employees EMP;
GO

SELECT * FROM [dbo].[GetAgesForHiredEmployees];

CREATE OR ALTER VIEW EmployeeLoginInfo
AS
    SELECT 
        L.Id,
        E.EmployeeId,
        CONCAT(E.FirstName, ' ', E.LastName) AS EmployeeName,
        L.UserName,
        L.Email,
        L.AuthCode
    FROM Logins L
    INNER JOIN Employees E ON L.EmployeeId = E.EmployeeId;
GO

CREATE OR ALTER VIEW LowStockMedicines
AS
    SELECT 
        M.MedicineId,
        M.Name AS MedicineName,
        M.CurrentQuantity,
        S.BoxQuantity,
        CASE
            WHEN M.CurrentQuantity <= 10 THEN 'You must increase medicine quantity'
			WHEN S.BoxQuantity <= 4 THEN 'You must increase box quantity'
            ELSE 'Sufficient'
        END AS StockStatus
    FROM Medicines M
    INNER JOIN Stocks S ON M.MedicineId = S.MedicineId;
GO

SELECT * FROM LowStockMedicines;

CREATE OR ALTER VIEW UpcomingAppointments
AS
    SELECT 
        A.AppointmentId,
        A.AppointmentDate,
        A.AppointmentTime,
        CONCAT(E.FirstName, ' ', E.LastName) AS EmployeeName,
        CONCAT(P.FirstName, ' ', P.LastName) AS PatientName,
        A.Paid
    FROM Appointments A
    INNER JOIN Employees E ON A.EmployeeId = E.EmployeeId
    INNER JOIN Patients P ON A.PatientId = P.PatientId
    WHERE A.AppointmentDate > GETDATE();
GO

CREATE OR ALTER VIEW CurrentAppointments
AS
    SELECT 
        A.AppointmentId,
        A.AppointmentDate,
        A.AppointmentTime,
        CONCAT(E.FirstName, ' ', E.LastName) AS EmployeeName,
        CONCAT(P.FirstName, ' ', P.LastName) AS PatientName,
        A.Paid
    FROM Appointments A
    INNER JOIN Employees E ON A.EmployeeId = E.EmployeeId
    INNER JOIN Patients P ON A.PatientId = P.PatientId
    WHERE CONVERT(DATE, A.AppointmentDate) = CONVERT(DATE, GETDATE());
GO

SELECT * FROM UpcomingAppointments;
SELECT * FROM CurrentAppointments;


CREATE OR ALTER VIEW TopSalaryEmployees
AS
    SELECT 
        EmployeeId,
        CONCAT(FirstName, ' ', LastName) AS EmployeeName,
        JobTitle,
        Salary
    FROM Employees
    WHERE Salary = (SELECT MAX(Salary) FROM Employees);
GO

SELECT * FROM TopSalaryEmployees;

CREATE OR ALTER VIEW ExpiringMedicines
AS
    SELECT 
        MedicineId,
        Name AS MedicineName,
        ExpireDate,
        CASE
            WHEN DATEDIFF(DAY, GETDATE(), ExpireDate) < 20 THEN 'Expiring Soon'
            ELSE 'Valid'
        END AS ExpiryStatus
    FROM Medicines;
GO

SELECT * FROM ExpiringMedicines;

CREATE OR ALTER VIEW BirthdayCelebrations
AS
    SELECT 
        EmployeeId,
        CONCAT(FirstName, ' ', LastName) AS EmployeeName,
        DateOfBirth
    FROM Employees
    WHERE MONTH(DateOfBirth) = MONTH(GETDATE());
GO

SELECT * FROM BirthdayCelebrations;


CREATE OR ALTER VIEW OutOfStockMedicines
AS
    SELECT 
        M.MedicineId,
        M.Name AS MedicineName,
        M.CurrentQuantity
    FROM Medicines M
    INNER JOIN Stocks S ON M.MedicineId = S.MedicineId
    WHERE M.CurrentQuantity = 0;
GO

SELECT * FROM OutOfStockMedicines;

CREATE OR ALTER VIEW ReorderMedicines
AS
    SELECT 
        M.MedicineId,
        M.Name AS MedicineName,
        M.CurrentQuantity,
        S.BoxQuantity,
        CASE
            WHEN M.CurrentQuantity < (S.BoxQuantity / 2) THEN 'Below Reorder Level'
            ELSE 'Sufficient'
        END AS ReorderStatus
    FROM Medicines M
    INNER JOIN Stocks S ON M.MedicineId = S.MedicineId;
GO

CREATE OR ALTER VIEW SupplierPerformance
AS
    SELECT 
        S.SupplierId,
        S.SupplierName,
        COUNT(SM.MedicineId) AS SuppliedMedicineCount,
        MAX(M.ExpireDate) AS LatestSupplyExpiry
    FROM Suppliers S
    INNER JOIN SuppliersMedicines SM ON S.SupplierId = SM.SupplierId
    INNER JOIN Medicines M ON SM.MedicineId = M.MedicineId
    GROUP BY S.SupplierId, S.SupplierName;
GO

SELECT * FROM SupplierPerformance;

CREATE OR ALTER PROCEDURE [dbo].[UpdateEmployeeSalary]
    @EmployeeId INT,
    @NewSalary DECIMAL(8, 2)
AS
BEGIN
    UPDATE Employees
    SET Salary = @NewSalary
    WHERE EmployeeId = @EmployeeId;
END;

CREATE OR ALTER PROCEDURE [dbo].[RecordMedicineSale]
    @PrescriptionId INT,
    @MedicineId INT,
    @QuantitySold INT,
    @TransactionDate DATE
AS
BEGIN
    INSERT INTO PharmacyTransactions (PrescriptionId, MedicineId, QuantitySold, TransactionDate)
    VALUES (@PrescriptionId, @MedicineId, @QuantitySold, @TransactionDate);
END;

CREATE OR ALTER PROCEDURE [dbo].[AddNewMedicine]
    @Name VARCHAR(20),
    @ExpireDate DATETIME2,
    @StockQuantity INT,
    @UnitPrice DECIMAL(8, 2),
    @CurrentQuantity INT
AS
BEGIN
    INSERT INTO Medicines (Name, ExpireDate, StockQuantity, UnitPrice, CurrentQuantity)
    VALUES (@Name, @ExpireDate, @StockQuantity, @UnitPrice, @CurrentQuantity);
END;

CREATE OR ALTER FUNCTION [dbo].[CheckMedicineExpiry]
    (@ExpireDate DATETIME2)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @ExpiryStatus VARCHAR(20);
    SET @ExpiryStatus = 
        CASE
            WHEN @ExpireDate < GETDATE() THEN 'Expired'
            WHEN DATEDIFF(DAY, GETDATE(), @ExpireDate) < 30 THEN 'Expiring Soon'
            ELSE 'Valid'
        END;
    RETURN @ExpiryStatus;
END;

CREATE OR ALTER PROCEDURE [dbo].[GenerateAuthCode]
    @AuthCodeOut VARCHAR(5) OUTPUT
AS
BEGIN
    SET @AuthCodeOut = RIGHT(NEWID(), 5);
END;

DECLARE @GeneratedCode VARCHAR(5);
EXEC GenerateAuthCode @GeneratedCode OUTPUT;
SELECT @GeneratedCode AS 'GeneratedCode';

DECLARE @generatedAuthCode VARCHAR(5);
EXEC [dbo].[GenerateAuthCode] @generatedAuthCode OUTPUT;
SELECT @generatedAuthCode AS 'AUTH CODE';

CREATE OR ALTER FUNCTION [dbo].[CalculateTotalCost]
    (@UnitPrice DECIMAL(8, 2), @Quantity INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalCost DECIMAL(10, 2);
    SET @TotalCost = @UnitPrice * @Quantity;
    RETURN @TotalCost;
END;


CREATE OR ALTER PROCEDURE [dbo].[GenerateRandomPasswordProcedure]
    @Length INT, @GeneratedPassword VARCHAR(20) OUTPUT
AS
BEGIN
    DECLARE @Chars VARCHAR(50) = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    DECLARE @Password VARCHAR(20);
    SET @Password = '';
    
    WHILE LEN(@Password) < @Length
    BEGIN
        SET @Password = @Password + SUBSTRING(@Chars, CAST(CEILING(RAND() * LEN(@Chars)) AS INT), 1);
    END
	SET @GeneratedPassword = @Password;
END;

DECLARE @generatedPassword VARCHAR(50);
EXEC [dbo].[GenerateRandomPasswordProcedure] 10, @generatedPassword OUTPUT;
SELECT @generatedPassword AS 'PASSWORD';

-- New Features
CREATE OR ALTER FUNCTION dbo.CalculateTotalUnitPrice()
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @Total DECIMAL(10, 2);

    SELECT @Total = SUM(UnitPrice)
    FROM Medicines;

    RETURN @Total;
END;

SELECT dbo.CalculateTotalUnitPrice() AS TOTAL;


CREATE OR ALTER VIEW [dbo].[EmployeePerformanceSummary]
AS
SELECT CONCAT(EMP.FirstName, ' ', EMP.LastName) AS Employee,
	EMP.JobTitle, COUNT(A.AppointmentId) AS TotalAppointments
FROM Appointments A INNER JOIN Employees EMP
	ON A.EmployeeId = EMP.EmployeeId
WHERE LOWER(EMP.JobTitle) = 'doctor'
GROUP BY EMP.JobTitle, EMP.FirstName, EMP.LastName;

SELECT * FROM EmployeePerformanceSummary;

CREATE OR ALTER VIEW [dbo].[GetTotalAppointmentsForDepartments]
AS
SELECT DEPT.DepartmentName, 
	COUNT(A.AppointmentId) AS TotalAppointments
FROM Departments DEPT JOIN Employees EMP 
	ON DEPT.DepartmentId = EMP.DepartmentId JOIN Appointments A 
	ON A.EmployeeId = EMP.EmployeeId
	WHERE A.AppointmentDate = GETDATE()
GROUP BY DEPT.DepartmentName;

SELECT * FROM GetTotalAppointmentsForDepartments;

CREATE OR ALTER VIEW [dbo].[GetTotalCheckupCostForDepartments]
AS
SELECT DEPT.DepartmentName, 
	COUNT(A.AppointmentId) AS TotalAppointments,
	SUM(CONVERT(money, DEPT.DepartmentCost, 0)) AS TotalCost
FROM Departments DEPT JOIN Employees EMP
	ON DEPT.DepartmentId = EMP.DepartmentId
JOIN Appointments A ON A.EmployeeId = EMP.EmployeeId
WHERE LOWER(A.Paid) = LOWER('PAID')
GROUP BY DEPT.DepartmentName;

SELECT * FROM [dbo].[GetTotalCheckupCostForDepartments];

CREATE OR ALTER FUNCTION [dbo].[CalculateTotalCheckupCostsPaid]()
RETURNS DECIMAL(10, 2)
AS
BEGIN
	DECLARE @Total DECIMAL(10, 2);
	SELECT	@Total = SUM(TotalCost) 
		FROM [dbo].[GetTotalCheckupCostForDepartments];
	RETURN @Total;
END
GO

SELECT [dbo].[CalculateTotalCheckupCostsPaid]() AS TotalCheckupCostsPaid;


CREATE OR ALTER VIEW [dbo].[PatientPrescriptionHistory]
AS
	SELECT
		Patients.FirstName + ' ' + Patients.LastName AS PatientName,
		Prescriptions.Diagnosis,
		STRING_AGG(PatientsPrescriptions.MedicineName, ', ') AS PrescribedMedicines
	FROM
		Patients
		JOIN Prescriptions ON Patients.PatientId = Prescriptions.PatientId
		JOIN PatientsPrescriptions ON Prescriptions.PrescriptionId = PatientsPrescriptions.PrescriptionId
	GROUP BY
		Patients.FirstName, Patients.LastName, Prescriptions.Diagnosis;
	GO

SELECT * FROM PatientPrescriptionHistory;

CREATE OR ALTER VIEW [dbo].[MonthlyRevenueAnalysis]
AS
SELECT
    YEAR(TransactionDate) AS TransactionYear,
    MONTH(TransactionDate) AS TransactionMonth,
    SUM(UnitPrice * QuantitySold) AS MonthlyRevenue
FROM
    PharmacyTransactions
INNER JOIN Medicines ON PharmacyTransactions.MedicineId = Medicines.MedicineId
GROUP BY
    YEAR(TransactionDate), MONTH(TransactionDate)
GO

SELECT * FROM [dbo].[MonthlyRevenueAnalysis];

CREATE OR ALTER VIEW [dbo].[ShowEmployeeSchedule]
AS
SELECT
    Employees.FirstName + ' ' + Employees.LastName AS EmployeeName,
	STRING_AGG(CASE
		WHEN ES.DayOfWeek = 0 THEN 'SUN'
		WHEN ES.DayOfWeek = 1 THEN 'MON'
		WHEN ES.DayOfWeek = 2 THEN 'TUE'
		WHEN ES.DayOfWeek = 3 THEN 'WED'
		WHEN ES.DayOfWeek = 4 THEN 'THU'
		WHEN ES.DayOfWeek = 5 THEN 'FRI'
		WHEN ES.DayOfWeek = 6 THEN 'SAT'
		ELSE 'Invalid'
	END, ', ') AS DAYS,
    STRING_AGG(CONVERT(VARCHAR, StartTime, 108) + '-' + CONVERT(VARCHAR, EndTime, 108), ', ') AS Schedule
FROM
    Employees
INNER JOIN EmployeeSchedule ES ON Employees.EmployeeId = ES.EmployeeId
GROUP BY
    Employees.FirstName, Employees.LastName;
GO

SELECT * FROM ShowEmployeeSchedule;

CREATE OR ALTER VIEW [dbo].[PatientAppointmentHistory]
AS
SELECT
    Patients.FirstName + ' ' + Patients.LastName AS PatientName,
    COUNT(Appointments.AppointmentId) AS TotalAppointments,
    MIN(AppointmentDate) AS     ,
    MAX(AppointmentDate) AS LastAppointment
FROM
    Patients
LEFT JOIN Appointments ON Patients.PatientId = Appointments.PatientId
GROUP BY
    Patients.FirstName, Patients.LastName;
GO

SELECT * FROM [dbo].[PatientAppointmentHistory];
