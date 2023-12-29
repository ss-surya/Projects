-- Doctor-Patients Gender
SELECT DD.Doctor_Name, PD.Patient_Gender, COUNT(DISTINCT DF.Patient_ID) AS Patients
FROM disease_dw.diagnosis_fact DF
JOIN disease_dw.patient_dim PD ON DF.Patient_ID = PD.Patient_ID
JOIN disease_dw.doctor_dim DD ON DF.Doctor_ID = DD.Doctor_ID
GROUP BY 1,2;

-- Doctor-Patients Severity
SELECT DD.Doctor_Name, DS.disease_severity_description, COUNT(DISTINCT DF.Patient_ID) AS Patients
FROM disease_dw.diagnosis_fact DF
JOIN disease_dw.disease_severity_dim DS ON DF.disease_severity_ID = DS.disease_severity_code
JOIN disease_dw.doctor_dim DD ON DF.Doctor_ID = DD.Doctor_ID
GROUP BY 1,2;

--Daily Patient Visits
SELECT DD.Date, COUNT(DISTINCT DF.patient_ID) AS Patients
FROM disease_dw.diagnosis_fact DF
JOIN disease_dw.date_dim DD ON DF.visit_date_ID = DD.date_ID
GROUP BY 1
ORDER BY 1;

--Top 3 Common Disease
SELECT DD.disease_name as disease, count(distinct patient_id) AS Patients
FROM disease_dw.diagnosis_fact DF
JOIN disease_dw.disease_dim DD on DF.disease_id=DD.disease_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;

--Average Age of Patients by Disease
SELECT Disease_Name, AVG(Patient_Age) :: INT AS Average_Patient_Age
FROM
(SELECT
PD.Patient_id, PD.Patient_Age, DD.Disease_Name
FROM disease_dw.diagnosis_fact DF
JOIN disease_dw.disease_dim DD ON DF.Disease_ID = DD.Disease_ID
JOIN disease_dw.patient_dim PD ON DF.Patient_ID = PD.Patient_ID
GROUP BY 1,2,3) Q
GROUP BY 1;

--Instock Indicator
SELECT MD.medicine_name, MF.instock_indicator
FROM disease_dw.inventory_fact MF
JOIN disease_dw.date_dim DD ON MF.inventory_date_id=DD.date_id
JOIN disease_dw.medicine_dim MD ON MF.medicine_id=MD.medicine_id
WHERE DD.date = (CURRENT_DATE-30)
GROUP BY 1,2