DROP TABLE IF EXISTS Pharmacy_Inventory CASCADE;
DROP TABLE IF EXISTS Prescription CASCADE;
DROP TABLE IF EXISTS Medicine;
DROP TABLE IF EXISTS Diagnosis;
DROP TABLE IF EXISTS Disease_Severity;
DROP TABLE IF EXISTS Disease;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS "location";

CREATE TABLE "location" (
Location_ID serial ,
City_Name VARCHAR(50) NOT NULL,
State_Name VARCHAR(50) NOT NULL,
Country_Name VARCHAR(50) NOT NULL,
PRIMARY KEY (Location_ID)
);

CREATE TABLE Patient (
Patient_ID serial ,
Patient_Name VARCHAR(50) NOT NULL,
Patient_Age INT NOT NULL,
Patient_Gender VARCHAR(10) NOT NULL,
Patient_Location_ID INT,
PRIMARY KEY (Patient_ID)
);
 
CREATE TABLE Doctor (
Doctor_ID serial,
Doctor_Name VARCHAR(50) NOT NULL,
Doctor_Speciality VARCHAR(50) NOT NULL,
Experience_Years INT NOT NULL,
PRIMARY KEY (Doctor_ID)
);

CREATE TABLE Disease (
Disease_ID serial,
Disease_Name VARCHAR(50) NOT NULL,
Disease_Description VARCHAR(200) NOT NULL,
PRIMARY KEY (Disease_ID)
);

CREATE TABLE Disease_Severity (
Disease_Severity_Code INT,
Disease_Severity_Description VARCHAR(10) NOT NULL,
PRIMARY KEY (Disease_Severity_Code)
);

CREATE TABLE Diagnosis (
Diagnosis_ID serial ,
Patient_ID INT NOT NULL,
Doctor_ID INT NOT NULL,
Diagnosis_Date DATE NOT NULL,
Disease_ID INT NOT NULL,
Prescription_ID serial,
Disease_Severity_Code INT NOT NULL,
Weight_kg Decimal(10,2) NOT NULL,
Temperature_F Decimal(10,2) NOT NULL,
Systolic_Blood_Pressure_mmHg Decimal(10,2) NOT NULL,
Diastolic_Blood_Pressure_mmHg Decimal(10,2) NOT NULL,
PRIMARY KEY (Diagnosis_ID)
);

CREATE TABLE Medicine (
Medicine_ID serial,
Medicine_Name VARCHAR(50) NOT NULL,
Dosage_Description VARCHAR(50) NOT NULL,
Medicine_Manufacturer VARCHAR(50) NOT NULL,
Active_Ingredient_Name VARCHAR(200) NOT NULL,
PRIMARY KEY (Medicine_ID)
);

CREATE TABLE Prescription (
Prescription_ID serial,
Prescription_Line_ID INT NOT NULL,
Medicine_ID INT NOT NULL,
Prescribed_Dosage_Description VARCHAR(50) NOT NULL,
PRIMARY KEY(Prescription_ID),
FOREIGN KEY (Medicine_ID) REFERENCES Medicine(Medicine_ID)
);

CREATE TABLE Pharmacy_Inventory(
Inventory_Date Date,
Medicine_ID INT NOT NULL,
Instock_Indicator INT NOT NULL,
PRIMARY KEY (Inventory_Date, Medicine_ID)
);

--Referential integrity
alter table Patient add FOREIGN KEY (Patient_Location_ID) REFERENCES "location"(Location_ID) on update cascade on delete cascade;
alter table Diagnosis add FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID) on update cascade on delete cascade;
alter table Diagnosis add FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID) on update cascade on delete cascade;
alter table Diagnosis add FOREIGN KEY (Disease_ID) REFERENCES Disease(Disease_ID) on update cascade on delete cascade;
alter table Diagnosis add FOREIGN KEY (Disease_Severity_Code) REFERENCES Disease_Severity(Disease_Severity_Code) on update cascade;
alter table Prescription add FOREIGN KEY (Medicine_ID) REFERENCES Medicine(Medicine_ID) on update cascade on delete cascade;
alter table Pharmacy_Inventory add FOREIGN KEY (Medicine_ID) REFERENCES Medicine(Medicine_ID) on update cascade on delete cascade;