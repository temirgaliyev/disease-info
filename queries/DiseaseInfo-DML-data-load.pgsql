COPY cat_bp
FROM '/home/yelmurat/uni/adbms/project/data/preprocessed/cat_bp.csv' 
CSV 
HEADER
;

COPY cat_chest_pain 
FROM '/home/yelmurat/uni/adbms/project/data/preprocessed/cat_chest_pain.csv' 
CSV 
HEADER
;

COPY cat_chol_exam
FROM '/home/yelmurat/uni/adbms/project/data/preprocessed/cat_examination.csv' 
CSV 
HEADER
;

COPY cat_gluc_exam
FROM '/home/yelmurat/uni/adbms/project/data/preprocessed/cat_examination.csv' 
CSV 
HEADER
;

COPY cat_eye
FROM '/home/yelmurat/uni/adbms/project/data/preprocessed/cat_eye.csv' 
CSV 
HEADER
;

COPY cat_gender
FROM '/home/yelmurat/uni/adbms/project/data/preprocessed/cat_gender.csv' 
CSV 
HEADER
;

COPY cardio
FROM '/home/yelmurat/uni/adbms/project/data/preprocessed/cardio.csv' 
CSV 
HEADER
;

COPY heart
FROM '/home/yelmurat/uni/adbms/project/data/preprocessed/heart.csv' 
CSV 
HEADER
;

COPY kidney
FROM '/home/yelmurat/uni/adbms/project/data/preprocessed/kidney.csv' 
CSV 
HEADER
;

COPY ocular_diagnostic_keywords
FROM '/home/yelmurat/uni/adbms/project/data/preprocessed/ocular_diag_keywords.csv' 
CSV 
HEADER
;

COPY ocular
FROM '/home/yelmurat/uni/adbms/project/data/preprocessed/ocular.csv' 
CSV 
HEADER
;

COPY ocular_diagnostics
FROM '/home/yelmurat/uni/adbms/project/data/preprocessed/eye_diagnostics.csv' 
CSV 
HEADER
;

COPY india_states
FROM '/home/yelmurat/uni/adbms/project/data/preprocessed/indian_states.csv' 
CSV 
HEADER
;

COPY covid_india
FROM '/home/yelmurat/uni/adbms/project/data/preprocessed/covid_india.csv' 
CSV 
HEADER
;

COPY italy_regions
FROM '/home/yelmurat/uni/adbms/project/data/preprocessed/italy_regions.csv' 
CSV 
HEADER
;

COPY italy_provinces
FROM '/home/yelmurat/uni/adbms/project/data/preprocessed/italy_provinces.csv' 
CSV 
HEADER
;

COPY covid_italy
FROM '/home/yelmurat/uni/adbms/project/data/preprocessed/covid_italy.csv' 
CSV 
HEADER
;

