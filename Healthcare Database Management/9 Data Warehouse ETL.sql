insert into disease_dw.date_dim ("date", "year", "month", "day")
(
SELECT "date",
EXTRACT(year FROM "date") AS year,
EXTRACT(month FROM "date") AS month,
EXTRACT(day FROM "date") AS day FROM
(SELECT generate_series('01-11-2023'::date, '30-11-2023'::date, '1 day'::interval) ::date AS "date")series);

create or replace view disease_dw.diagnosis_fact_etl as(
select 
loc.location_ID,
pat.patient_ID,
doc.doctor_ID,
dis.disease_ID,
prs.prescription_ID,
vis.date_ID,
dia.disease_severity_code,
dia.Weight_kg,
dia.Temperature_F,
dia.Systolic_Blood_Pressure_mmHg,
dia.Diastolic_Blood_Pressure_mmHg
from "location" loc	
left join Patient pat on pat.patient_location_id = loc.location_id
left join Diagnosis dia on dia.patient_id = pat.patient_id
left join Prescription prs on dia.prescription_id = prs.prescription_id
left join Doctor doc on doc.doctor_id = dia.doctor_id
left join Disease_Severity sev on sev.disease_severity_code = dia.disease_severity_code
left join Disease dis on dis.disease_id = dia.disease_id
left join disease_dw.date_dim vis on dia.diagnosis_date = vis.date
);

create or replace view disease_dw.inventory_fact_etl as(
select 	
vis.date_ID,
med.medicine_id,
inv.instock_indicator	
from Medicine med
left join pharmacy_inventory inv on med.medicine_id = inv.medicine_id
left join disease_dw.date_dim vis on inv.inventory_date = vis.date
);
	
insert into disease_dw.location_dim (location_id, city_name, state_name, country_name)
(select * from "location");

insert into disease_dw.patient_dim (patient_ID, patient_name, patient_age, patient_gender)
(select patient_ID, patient_name, patient_age, patient_gender from patient);

insert into disease_dw.doctor_dim (doctor_ID, doctor_name, doctor_speciality, experience_years)
(select doctor_ID, doctor_name, doctor_speciality, experience_years from doctor);

insert into disease_dw.disease_dim (disease_ID, disease_name, disease_description)
(select disease_ID, disease_name, disease_description from disease);

insert into disease_dw.medicine_dim (medicine_id, medicine_name, dosage_description, medicine_manufacturer, active_ingredient_name)
(select * from medicine);

insert into disease_dw.prescription_dim (prescription_id, prescription_line_id, medicine_id, prescribed_dosage_description)
(select * from Prescription);

insert into disease_dw.disease_severity_dim (disease_severity_code, disease_severity_description)
(select * from disease_severity);

insert into disease_dw.diagnosis_fact
(select * from disease_dw.diagnosis_fact_etl);

insert into disease_dw.inventory_fact
(select * from disease_dw.inventory_fact_etl);