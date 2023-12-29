DROP TABLE IF EXISTS disease_dw.diagnosis_fact CASCADE;
DROP TABLE IF EXISTS disease_dw.inventory_fact CASCADE;
DROP TABLE IF EXISTS disease_dw.location_dim;
DROP TABLE IF EXISTS disease_dw.patient_dim;
DROP TABLE IF EXISTS disease_dw.doctor_dim;
DROP TABLE IF EXISTS disease_dw.disease_dim;
DROP TABLE IF EXISTS disease_dw.prescription_dim;
DROP TABLE IF EXISTS disease_dw.medicine_dim CASCADE;
DROP TABLE IF EXISTS disease_dw.date_dim CASCADE;
DROP TABLE IF EXISTS disease_dw.disease_severity_dim;

--Location Dimension
create table disease_dw.location_dim 
(
	location_id int NOT NULL,
	city_name VARCHAR(100) NOT NULL,
	state_name VARCHAR(100) NOT NULL,
	country_name VARCHAR(100) NOT NULL,
	PRIMARY KEY (location_id)
);

--Patient Dimension
CREATE TABLE disease_dw.patient_dim 
(
	patient_ID INT NOT NULL,
	patient_name VARCHAR(50) NOT NULL,
	patient_age INT NOT NULL,
	patient_gender VARCHAR(10) NOT NULL,
	PRIMARY KEY (patient_ID)
);

--Doctor Dimension
CREATE TABLE disease_dw.doctor_dim 
(	
	doctor_ID INT NOT NULL,
	doctor_name VARCHAR(50) NOT NULL,
	doctor_speciality VARCHAR(50) NOT NULL,
	experience_years INT NOT NULL,
	PRIMARY KEY (doctor_ID)
);

--Disease Dimension
CREATE TABLE disease_dw.disease_dim 
(	
	disease_ID INT NOT NULL,
	disease_name VARCHAR(50) NOT NULL,
	disease_description VARCHAR(200) NOT NULL,
	PRIMARY KEY (disease_ID)
);

--Medicine Dimension
create table disease_dw.medicine_dim 
(
	medicine_id int NOT NULL,
	medicine_name VARCHAR(50) NOT NULL,
	dosage_description VARCHAR(50) NOT NULL,
	medicine_manufacturer VARCHAR(50) NOT NULL,
	active_ingredient_name VARCHAR(50) NOT NULL,
	PRIMARY KEY (medicine_id)
);

--Prescription Dimension
create table disease_dw.prescription_dim 
(
	prescription_id int NOT NULL,
	prescription_line_id int NOT NULL,
	medicine_id int NOT NULL references disease_dw.medicine_dim (medicine_id),
	prescribed_dosage_description VARCHAR(50) NOT NULL,
	PRIMARY KEY (prescription_id)
);


--Visit date dimension
create table disease_dw.date_dim
(
	date_ID serial,
	"date" date NOT NULL,
	"year" int NOT NULL,
	"month" int NOT NULL,
	"day" int NOT NULL,
	PRIMARY KEY (date_ID)
);

--Disease Severity Dimension
CREATE TABLE disease_dw.disease_severity_dim 
(
	disease_severity_code INT,
	disease_severity_description VARCHAR(10) NOT NULL,
	PRIMARY KEY (disease_severity_code)
);

--Diagnosis Fact
create table disease_dw.diagnosis_fact
(
	location_ID INT references disease_dw.location_dim (location_ID),
	patient_ID INT references disease_dw.patient_dim (patient_ID),
	doctor_ID INT references disease_dw.doctor_dim (doctor_ID),
	disease_ID INT references disease_dw.disease_dim (disease_ID),
	prescription_ID INT references disease_dw.prescription_dim (prescription_ID),
	visit_date_ID INT references disease_dw.date_dim (date_ID),
	disease_severity_ID INT references disease_dw.disease_severity_dim (disease_severity_code),
	Weight_kg Decimal(10,2) NOT NULL,
	Temperature_F Decimal(10,2) NOT NULL,
	Systolic_Blood_Pressure_mmHg Decimal(10,2) NOT NULL,
	Diastolic_Blood_Pressure_mmHg Decimal(10,2) NOT NULL,
	primary key (location_ID, patient_ID, doctor_ID, disease_ID, prescription_ID, visit_date_ID, disease_severity_ID)
);

--Inventory Fact
create table disease_dw.inventory_fact
(
	inventory_date_ID INT references disease_dw.date_dim (date_ID),
	medicine_ID INT references disease_dw.medicine_dim (medicine_ID),
	instock_indicator INT,
	primary key (inventory_date_ID, medicine_ID)	
);