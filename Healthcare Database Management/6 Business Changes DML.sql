--Update Patient Information:
UPDATE Patient
SET Patient_Age = 23
WHERE Patient_ID = 6;

--Add New Diagnosis Entry for a Patient
INSERT INTO Diagnosis (Patient_ID, Doctor_ID, Diagnosis_Date, Disease_ID, Disease_Severity_Code, Weight_kg, Temperature_F, Systolic_Blood_Pressure_mmHg, Diastolic_Blood_Pressure_mmHg)
VALUES (3, 5,'25-11-2023', 10, 1, 77.5, 99.4, 127, 87.0);

--Update Medicine Dosage Description:
UPDATE Medicine
SET Dosage_Description = 'Take one tablet twice daily'
WHERE Medicine_ID = 1;

--Remove a Patient and Cascade Deletion
DELETE FROM Patient
WHERE Patient_ID = 10;

-- Add a new doctor
INSERT INTO Doctor (Doctor_Name, Doctor_Speciality, Experience_Years)
VALUES ('Dr. Anderson', 'Cardiologist', 8);

