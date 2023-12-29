--List Doctors and their Specialities
SELECT Doctor_Name, Doctor_Speciality, Experience_Years
FROM Doctor;

--List of Patients and their location details
SELECT P.patient_name, P.patient_age, P.patient_gender, L.city_name, L.state_name, L.country_name
FROM Patient P
JOIN "location" L on P.patient_location_id = L.location_id;

--List all Patients along with their Diagnosis information
SELECT
P.Patient_ID, P.Patient_Name, P.Patient_Age, P.Patient_Gender,
D.Diagnosis_Date, DS.Disease_Name, SEV.Disease_Severity_Description
FROM Patient P
JOIN Diagnosis D ON P.Patient_ID = D.Patient_ID
JOIN Disease DS ON D.Disease_ID = DS.Disease_ID
JOIN Disease_Severity SEV ON SEV.disease_severity_code = D.disease_severity_code
ORDER BY D.Diagnosis_Date;

--Report on Aspirine Inventory
SELECT  INV.Inventory_Date, INV.Instock_Indicator
FROM  Medicine M
JOIN Pharmacy_Inventory INV ON M.Medicine_ID = INV.Medicine_ID
WHERE M.Medicine_Name = 'Aspirin';