CREATE TABLE cat_bp (
    id INT PRIMARY KEY NOT NULL,
    cat VARCHAR(32)
);

CREATE TABLE cat_chol_exam (
    id INT PRIMARY KEY NOT NULL,
    cat VARCHAR(32)
);

CREATE TABLE cat_gluc_exam (
    id INT PRIMARY KEY NOT NULL,
    cat VARCHAR(32)
);

CREATE TABLE cat_eye (
    id INT PRIMARY KEY NOT NULL,
    cat VARCHAR(5)
);

CREATE TABLE cat_gender (
    id INT PRIMARY KEY NOT NULL,
    cat VARCHAR(8)
);

CREATE TABLE cat_chest_pain (
    id INT PRIMARY KEY NOT NULL,
    cat VARCHAR(20)
);

CREATE TABLE cardio(
    c_id INT PRIMARY KEY NOT NULL,
    c_age INT,
    c_gender_id INT REFERENCES cat_gender(id),
    c_height INT,
    c_weight INT,
    c_blood_pressure_id INT REFERENCES cat_bp(id),
    c_cholesterol_id INT REFERENCES cat_chol_exam(id),
    c_glucose_id INT REFERENCES cat_gluc_exam(id),
    c_smoke BOOLEAN,
    c_alcohol BOOLEAN,
    c_active BOOLEAN,
    c_cardio_disease BOOLEAN,
    c_hypertension BOOLEAN,
    c_diabetes BOOLEAN
);

CREATE TABLE heart(
    h_id INT PRIMARY KEY NOT NULL,
    h_age INT,
    h_gender_id INT REFERENCES cat_gender(id),
    h_chest_pain_type_id INT REFERENCES cat_chest_pain(id),
    h_blood_pressure_id INT REFERENCES cat_bp(id),
    h_cholesterol_id INT REFERENCES cat_chol_exam(id),
    h_diabetes BOOLEAN,
    h_max_heart_rate INT, 
    h_cad BOOLEAN,
    h_heart_disease BOOLEAN,
    h_hypertension BOOLEAN
);

CREATE TABLE kidney(
    k_id INT PRIMARY KEY NOT NULL,
    k_age INT,
    k_cad BOOLEAN,
    k_blood_pressure_id INT REFERENCES cat_bp(id),
    k_hypertension BOOLEAN,
    k_glucose_id INT REFERENCES cat_gluc_exam(id),
    k_diabetes BOOLEAN,
    k_appetite BOOLEAN,
    k_pedal_edema BOOLEAN,
    k_anemia BOOLEAN,
    k_kidney_disease BOOLEAN
);

CREATE TABLE ocular_diagnostic_keywords(
    odk_id INT PRIMARY KEY NOT NULL,
    odk_diagnostic VARCHAR(64)
);

CREATE TABLE ocular(
    o_id INT PRIMARY KEY NOT NULL,
    o_age INT,
    o_gender_id INT REFERENCES cat_gender(id),
    o_normal BOOLEAN,
    o_o_diabetes BOOLEAN,
    o_glaucoma BOOLEAN,
    o_cataract BOOLEAN,
    o_hypertension BOOLEAN,
    o_myopia BOOLEAN,
    o_other BOOLEAN
);

CREATE TABLE ocular_diagnostics(
    od_id INT PRIMARY KEY NOT NULL,
    od_case_id INT REFERENCES ocular(o_id),
    od_diag_id INT REFERENCES ocular_diagnostic_keywords(odk_id),
    od_eye_id INT REFERENCES cat_eye(id)
);


CREATE TABLE india_states(
    ins_id INT PRIMARY KEY NOT NULL,
    ins_state VARCHAR(42)
);

CREATE TABLE covid_india(
    cin_id INT PRIMARY KEY NOT NULL,
    cin_date DATE,
    cin_state_id INT REFERENCES india_states(ins_id),
    cin_indians INT,
    cin_foreigns INT,
    cin_cured INT,
    cin_deaths INT,
    cin_confirmed INT
);

CREATE TABLE italy_regions(
    itr_id INT PRIMARY KEY NOT NULL,
    itr_region VARCHAR(32)
);

CREATE TABLE italy_provinces(
    itp_id INT PRIMARY KEY NOT NULL,
    itp_region_id INT REFERENCES italy_regions(itr_id),
    itp_province VARCHAR(42),
    itp_abbreviation VARCHAR(2)  
);

CREATE TABLE covid_italy(
    cit_id INT PRIMARY KEY NOT NULL,
    cit_date DATE,
    cit_province INT REFERENCES italy_provinces(itp_id),
    cit_cases INT,
    cit_latitude DOUBLE PRECISION,
    cit_longitude DOUBLE PRECISION
);

