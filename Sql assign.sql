CREATE DATABASE hospitalsss;

USE hospitalsss;

CREATE TABLE Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender ENUM('Male','Female','Others'),
    ContactInfo VARCHAR(50)
);
CREATE TABLE Doctor (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Specialty VARCHAR(50),
    Phone VARCHAR(20),
    Email VARCHAR(100)
);
CREATE TABLE Appointment (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    Reason VARCHAR(100),
    Status ENUM('Scheduled','Completed','Cancelled'),

    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);
CREATE TABLE Prescription (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Medication VARCHAR(100),
    Dosage VARCHAR(50),
    StartDate DATE,
    EndDate DATE,

    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);
CREATE TABLE Billing (
    BillingID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    Amount DECIMAL(10,2),
    BillingDate DATE,
    Status VARCHAR(30),

    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);
CREATE TABLE MedicalRecord (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    Diagnosis VARCHAR(100),
    Treatment VARCHAR(100),
    RecordDate DATE,
    Notes TEXT,

    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);
-- Patients
INSERT INTO Patient (FirstName, LastName, DateOfBirth, Gender, ContactInfo)
VALUES
('Nabin', 'Rai', '1985-02-14', 'Male', '9861111111'),
('Maya', 'Lama', '1992-08-30', 'Female', '9862222222'),
('Kiran', 'Gurung', '1979-12-05', 'Male', '9863333333'),
('Sunita', 'Basnet', '2000-01-20', 'Female', '9864444444'),
('Prakash', 'Bhandari', '1997-06-18', 'Male', '9865555555');

-- Doctors
INSERT INTO Doctor (FirstName, LastName, Specialty, Phone, Email)
VALUES
('Deepak', 'Shah', 'General Medicine', '9871111111', 'deepak@hospital.com'),
('Laxmi', 'Maharjan', 'Gynecology', '9872222222', 'laxmi@hospital.com'),
('Rajesh', 'KC', 'ENT', '9873333333', 'rajesh@hospital.com'),
('Bina', 'Rana', 'Psychiatry', '9874444444', 'bina@hospital.com'),
('Keshav', 'Bhattarai', 'Oncology', '9875555555', 'keshav@hospital.com');

-- Appointments
INSERT INTO Appointment (PatientID, DoctorID, AppointmentDate, Reason, Status)
VALUES
(6, 6, '2026-06-01', 'Routine Checkup', 'Scheduled'),
(7, 7, '2026-06-02', 'Pregnancy Consultation', 'Scheduled'),
(8, 8, '2026-06-03', 'Ear Pain', 'Completed'),
(9, 9, '2026-06-04', 'Anxiety Issues', 'Cancelled'),
(10, 10, '2026-06-05', 'Cancer Screening', 'Scheduled');

-- Prescriptions
INSERT INTO Prescription (PatientID, DoctorID, Medication, Dosage, StartDate, EndDate)
VALUES
(6, 6, 'Vitamin D', '1000 IU', '2026-06-01', '2026-06-15'),
(7, 7, 'Folic Acid', '5mg', '2026-06-02', '2026-06-12'),
(8, 8, 'Antibiotic Drops', '2 drops', '2026-06-03', '2026-06-07'),
(9, 9, 'Sertraline', '50mg', '2026-06-04', '2026-06-20'),
(10, 10, 'Chemotherapy Drug', '200mg', '2026-06-05', '2026-06-25');

-- Billing
INSERT INTO Billing (PatientID, Amount, BillingDate, Status)
VALUES
(6, 1500.00, '2026-06-01', 'Paid'),
(7, 2500.00, '2026-06-02', 'Pending'),
(8, 1800.50, '2026-06-03', 'Paid'),
(9, 3200.75, '2026-06-04', 'Pending'),
(10, 4500.00, '2026-06-05', 'Paid');

-- Medical Records
INSERT INTO MedicalRecord (PatientID, Diagnosis, Treatment, RecordDate, Notes)
VALUES
(6, 'Vitamin Deficiency', 'Supplements', '2026-06-01', 'Needs sunlight exposure'),
(7, 'Pregnancy', 'Prenatal Care', '2026-06-02', 'Regular monitoring required'),
(8, 'Ear Infection', 'Antibiotics', '2026-06-03', 'Follow-up in 1 week'),
(9, 'Depression', 'Therapy + Medication', '2026-06-04', 'Counseling advised'),
(10, 'Breast Cancer', 'Chemotherapy', '2026-06-05', 'Ongoing treatment plan');

SELECT PatientID, SUM(Amount) AS TotalAmount
FROM Billing
GROUP BY PatientID;


SELECT d.FirstName, d.LastName, COUNT(a.AppointmentID) AS AppointmentCount
FROM Doctor d
JOIN Appointment a
ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorID, d.FirstName, d.LastName;


SELECT AVG(Amount) AS AverageBilling
FROM Billing;


SELECT MAX(Amount) AS MaximumAmount,
       MIN(Amount) AS MinimumAmount
FROM Billing;


SELECT d.FirstName, d.LastName,
       COUNT(p.PrescriptionID) AS PrescriptionCount
FROM Doctor d
JOIN Prescription p
ON d.DoctorID = p.DoctorID
GROUP BY d.DoctorID, d.FirstName, d.LastName
HAVING COUNT(p.PrescriptionID) > 2;


SELECT Diagnosis,
       COUNT(RecordID) AS RecordCount
FROM MedicalRecord
GROUP BY Diagnosis;


SELECT p.FirstName, p.LastName, m.Diagnosis
FROM Patient p
JOIN MedicalRecord m
ON p.PatientID = m.PatientID;


SELECT a.AppointmentDate,
       p.FirstName AS PatientFirstName,
       p.LastName AS PatientLastName,
       d.FirstName AS DoctorFirstName,
       d.LastName AS DoctorLastName
FROM Appointment a
JOIN Patient p
ON a.PatientID = p.PatientID
JOIN Doctor d
ON a.DoctorID = d.DoctorID;


SELECT pr.MedicationName,
       p.FirstName AS PatientFirstName,
       p.LastName AS PatientLastName,
       d.FirstName AS DoctorFirstName,
       d.LastName AS DoctorLastName
FROM Prescription pr
JOIN Patient p
ON pr.PatientID = p.PatientID
JOIN Doctor d
ON pr.DoctorID = d.DoctorID;

SELECT p.FirstName, p.LastName,
       b.BillingID, b.Amount, b.BillingDate
FROM Patient p
LEFT JOIN Billing b
ON p.PatientID = b.PatientID;


SELECT d.FirstName, d.LastName,
       a.AppointmentID, a.AppointmentDate
FROM Doctor d
LEFT JOIN Appointment a
ON d.DoctorID = a.DoctorID;


SELECT p.FirstName, p.LastName,
       SUM(b.Amount) AS TotalBilled
FROM Patient p
JOIN Billing b
ON p.PatientID = b.PatientID
GROUP BY p.PatientID, p.FirstName, p.LastName;


SELECT a.AppointmentDate,
       a.Reason,
       a.Status,
       p.Gender,
       p.Phone,
       p.Email
FROM Appointment a
JOIN Patient p
ON a.PatientID = p.PatientID;


SELECT *
FROM Appointment
WHERE Status = 'Scheduled'
AND AppointmentDate > '2026-01-01';


SELECT *
FROM Patient
WHERE FirstName LIKE 'A%';


SELECT *
FROM Billing
WHERE Amount BETWEEN 500 AND 2000;

SELECT *
FROM Prescription
WHERE MedicationName IN ('Paracetamol', 'Ibuprofen', 'Amoxicillin');


SELECT *
FROM MedicalRecord
WHERE Treatment LIKE '%Surgery%'
OR Notes IS NOT NULL;


ALTER TABLE Patient
ADD BloodGroup VARCHAR(5);


ALTER TABLE Doctor
MODIFY Phone VARCHAR(20);
