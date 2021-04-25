import psycopg2

POSTGRESQL_HOST = 'localhost'
POSTGRESQL_DATABASE = 'projectdb'
POSTGRESQL_USER = 'yelmurat'
POSTGRESQL_PASSWORD = 'password'

conn = psycopg2.connect(
    host=POSTGRESQL_HOST,
    database=POSTGRESQL_DATABASE,
    user=POSTGRESQL_USER,
    password=POSTGRESQL_PASSWORD)


def get_cardio_age():
    query = """
SELECT
    c_age,
    (w_disease::NUMERIC / (w_disease+wo_disease)),
    (w_smoke::NUMERIC / (w_smoke+wo_smoke)),
    (w_alcohol::NUMERIC / (w_alcohol+wo_alcohol)),
    (w_active::NUMERIC / (w_active+wo_active)),
    (w_hypertension::NUMERIC / (w_hypertension+wo_hypertension)),
    (w_diabetes::NUMERIC / (w_diabetes+wo_diabetes))
FROM (
    SELECT
        c_age,
        COUNT(c_age) FILTER (WHERE c_cardio_disease) AS w_disease,
        COUNT(c_age) FILTER (WHERE NOT c_cardio_disease) AS wo_disease,
        COUNT(c_age) FILTER (WHERE c_smoke) AS w_smoke,
        COUNT(c_age) FILTER (WHERE NOT c_smoke) AS wo_smoke,
        COUNT(c_age) FILTER (WHERE c_alcohol) AS w_alcohol,
        COUNT(c_age) FILTER (WHERE NOT c_alcohol) AS wo_alcohol,
        COUNT(c_age) FILTER (WHERE c_active) AS w_active,
        COUNT(c_age) FILTER (WHERE NOT c_active) AS wo_active,
        COUNT(c_age) FILTER (WHERE c_hypertension) AS w_hypertension,
        COUNT(c_age) FILTER (WHERE NOT c_hypertension) AS wo_hypertension,
        COUNT(c_age) FILTER (WHERE c_diabetes) AS w_diabetes,
        COUNT(c_age) FILTER (WHERE NOT c_diabetes) AS wo_diabetes
    FROM
        cardio
    GROUP BY
        c_age
    ORDER BY c_age
) AS cnt;
"""
    cursor = conn.cursor()
    cursor.execute(query)
    data = cursor.fetchall()
    cursor.close()

    ages = [data[i][0] for i in range(len(data))]
    disease = [float(data[i][1])*100 for i in range(len(data))]
    smoke = [float(data[i][2])*100 for i in range(len(data))]
    alcohol = [float(data[i][3])*100 for i in range(len(data))]
    active = [float(data[i][4])*100 for i in range(len(data))]
    hypertension = [float(data[i][5])*100 for i in range(len(data))]
    diabetes = [float(data[i][6])*100 for i in range(len(data))]

    return {'ages': ages,
            'disease': disease,
            'smoke': smoke,
            'alcohol': alcohol,
            'active': active,
            'hypertension': hypertension,
            'diabetes': diabetes}


def get_heart_age():
    query = """
SELECT
    h_age,
    (w_disease::NUMERIC / (w_disease+wo_disease)),
    (w_hypertension::NUMERIC / (w_hypertension+wo_hypertension)),
    (w_diabetes::NUMERIC / (w_diabetes+wo_diabetes)),
    (w_cad::NUMERIC / (w_cad+wo_cad))
FROM (
    SELECT
        h_age,
        COUNT(h_age) FILTER (WHERE h_heart_disease) AS w_disease,
        COUNT(h_age) FILTER (WHERE NOT h_heart_disease) AS wo_disease,
        COUNT(h_age) FILTER (WHERE h_hypertension) AS w_hypertension,
        COUNT(h_age) FILTER (WHERE NOT h_hypertension) AS wo_hypertension,
        COUNT(h_age) FILTER (WHERE h_diabetes) AS w_diabetes,
        COUNT(h_age) FILTER (WHERE NOT h_diabetes) AS wo_diabetes,
        COUNT(h_age) FILTER (WHERE h_cad) AS w_cad,
        COUNT(h_age) FILTER (WHERE NOT h_cad) AS wo_cad
    FROM
        heart
    GROUP BY
        h_age
    ORDER BY h_age
) AS cnt;
"""
    cursor = conn.cursor()
    cursor.execute(query)
    data = cursor.fetchall()
    cursor.close()

    ages = [data[i][0] for i in range(len(data))]
    disease = [float(data[i][1])*100 for i in range(len(data))]
    hypertension = [float(data[i][2])*100 for i in range(len(data))]
    diabetes = [float(data[i][3])*100 for i in range(len(data))]
    cad = [float(data[i][4])*100 for i in range(len(data))]

    return {'ages': ages,
            'disease': disease,
            'hypertension': hypertension,
            'diabetes': diabetes,
            'cad': cad
            }


def get_kidney_age():
    query = """
SELECT
    k_age,
    (w_disease::NUMERIC / (w_disease+wo_disease)),
    (w_hypertension::NUMERIC / (w_hypertension+wo_hypertension)),
    (w_diabetes::NUMERIC / (w_diabetes+wo_diabetes)),
    (w_cad::NUMERIC / (w_cad+wo_cad)),
    (w_appetite::NUMERIC / (w_appetite+wo_appetite))
FROM (
    SELECT
        k_age,
        COUNT(k_age) FILTER (WHERE k_kidney_disease) AS w_disease,
        COUNT(k_age) FILTER (WHERE NOT k_kidney_disease) AS wo_disease,
        COUNT(k_age) FILTER (WHERE k_hypertension) AS w_hypertension,
        COUNT(k_age) FILTER (WHERE NOT k_hypertension) AS wo_hypertension,
        COUNT(k_age) FILTER (WHERE k_diabetes) AS w_diabetes,
        COUNT(k_age) FILTER (WHERE NOT k_diabetes) AS wo_diabetes,
        COUNT(k_age) FILTER (WHERE k_cad) AS w_cad,
        COUNT(k_age) FILTER (WHERE NOT k_cad) AS wo_cad,
        COUNT(k_age) FILTER (WHERE k_appetite) AS w_appetite,
        COUNT(k_age) FILTER (WHERE NOT k_appetite) AS wo_appetite
    FROM
        kidney
    GROUP BY
        k_age
    ORDER BY k_age
) AS cnt;
"""
    cursor = conn.cursor()
    cursor.execute(query)
    data = cursor.fetchall()
    cursor.close()

    ages = [data[i][0] for i in range(len(data))]
    disease = [float(data[i][1])*100 for i in range(len(data))]
    hypertension = [float(data[i][2])*100 for i in range(len(data))]
    diabetes = [float(data[i][3])*100 for i in range(len(data))]
    cad = [float(data[i][4])*100 for i in range(len(data))]
    appetite = [float(data[i][5])*100 for i in range(len(data))]

    return {'ages': ages,
            'disease': disease,
            'hypertension': hypertension,
            'diabetes': diabetes,
            'cad': cad,
            'appetite': appetite
            }


def get_diseases_by_gender():
    query = """
SELECT
    cardio_gender.cat,
    cardio_count,
    heart_count,
    ocular_count
FROM
(
    SELECT
        cat_gender.cat,
        COUNT(*) AS cardio_count
    FROM
        cat_gender,
        cardio
    WHERE
        cardio.c_gender_id = cat_gender.id
    GROUP BY
        cat_gender.cat
) AS cardio_gender,
(
    SELECT
        cat_gender.cat,
        COUNT(*) AS heart_count
    FROM
        cat_gender,
        heart
    WHERE
        heart.h_gender_id = cat_gender.id
    GROUP BY
        cat_gender.cat
) AS heart_gender,
(
    SELECT
        cat_gender.cat,
        COUNT(*) AS ocular_count
    FROM
        cat_gender,
        ocular,
        ocular_diagnostics,
        ocular_diagnostic_keywords
    WHERE
        ocular.o_gender_id = cat_gender.id
        AND
        ocular.o_id = ocular_diagnostics.od_id
        AND
        ocular_diagnostics.od_diag_id = ocular_diagnostic_keywords.odk_id
        AND
        ocular_diagnostic_keywords.odk_diagnostic != 'normal fundus'
    GROUP BY
        cat_gender.cat
) AS ocular_gender
WHERE
    cardio_gender.cat = heart_gender.cat
    AND
    ocular_gender.cat = cardio_gender.cat
;
"""
    cursor = conn.cursor()
    cursor.execute(query)
    data = cursor.fetchall()
    cursor.close()

    def _to_percents(data_a, data_b):
        sum_data = data_a + data_b
        return [data_a/sum_data, data_b/sum_data]

    labels = ['Cardiovascular', 'Heart', 'Ocular']
    female_data = list(data[0][1:])
    male_data = list(data[1][1:])
    for i in range(3):
        female_data[i], male_data[i] = _to_percents(female_data[i],
                                                    male_data[i])

    print(female_data, male_data)

    return {'labels': labels, 'male': male_data, 'female': female_data}


def get_cardio_prob(age: int, has_diabetes: bool, gender: int):
    query = f"""
SELECT
    COUNT(c_age) FILTER (WHERE c_cardio_disease) AS w_disease,
    COUNT(c_age) FILTER (WHERE NOT c_cardio_disease) AS wo_disease
FROM
    cardio
WHERE
    c_age={age}
    AND
    c_diabetes={has_diabetes}
    AND
    c_gender_id={gender}
;
"""
    cursor = conn.cursor()
    cursor.execute(query)
    data = cursor.fetchall()
    cursor.close()

    if (data[0][0]+data[0][1]) == 0:
        return float('nan')
    return data[0][0]/(data[0][0]+data[0][1])


def get_heart_prob(age: int, has_diabetes: bool, gender: int):
    query = f"""
SELECT
    COUNT(h_age) FILTER (WHERE h_heart_disease) AS w_disease,
    COUNT(h_age) FILTER (WHERE NOT h_heart_disease) AS wo_disease
FROM
    heart
WHERE
    h_age={age}
    AND
    h_diabetes={has_diabetes}
    AND
    h_gender_id={gender}
;
"""
    cursor = conn.cursor()
    cursor.execute(query)
    data = cursor.fetchall()
    cursor.close()

    if (data[0][0]+data[0][1]) == 0:
        return float('nan')
    return data[0][0]/(data[0][0]+data[0][1])


def get_kidney_prob(age: int, has_diabetes: bool):
    query = f"""
SELECT
    COUNT(k_age) FILTER (WHERE k_kidney_disease) AS w_disease,
    COUNT(k_age) FILTER (WHERE NOT k_kidney_disease) AS wo_disease
FROM
    kidney
WHERE
    k_age={age}
    AND
    k_diabetes={has_diabetes}
;
"""
    cursor = conn.cursor()
    cursor.execute(query)
    data = cursor.fetchall()
    cursor.close()

    if (data[0][0]+data[0][1]) == 0:
        return float('nan')
    return data[0][0]/(data[0][0]+data[0][1])


def get_eye_prob(age: int, has_diabetes: bool, gender: int):
    query = f"""
SELECT
    COUNT(o_age) FILTER (WHERE ocular_diagnostic_keywords.odk_diagnostic \
        = 'normal fundus') AS w_disease,
    COUNT(o_age) FILTER (WHERE NOT ocular_diagnostic_keywords.odk_diagnostic \
        != 'normal fundus') AS wo_disease
FROM
    ocular,
    ocular_diagnostics,
    ocular_diagnostic_keywords
WHERE
    ocular_diagnostics.od_case_id = ocular.o_id
    AND
    ocular_diagnostics.od_diag_id = ocular_diagnostic_keywords.odk_id
    AND
    o_age={age}
    AND
    o_diabetes={has_diabetes}
    AND
    o_gender_id={gender}
;
"""
    cursor = conn.cursor()
    cursor.execute(query)
    data = cursor.fetchall()
    cursor.close()

    if (data[0][0]+data[0][1]) == 0:
        return float('nan')
    return data[0][0]/(data[0][0]+data[0][1])


def get_cad_prob(age: int, has_diabetes: bool, gender: int):
    query = f"""
SELECT
    COUNT(h_age) FILTER (WHERE h_cad) AS w_disease,
    COUNT(h_age) FILTER (WHERE NOT h_cad) AS wo_disease
FROM
    heart
WHERE
    h_age={age}
    AND
    h_diabetes={has_diabetes}
    AND
    h_gender_id={gender}
;
"""
    cursor = conn.cursor()
    cursor.execute(query)
    data = cursor.fetchall()
    cursor.close()

    if (data[0][0]+data[0][1]) == 0:
        return float('nan')
    return data[0][0]/(data[0][0]+data[0][1])


def order_by_month(data):
    months = ['January', 'February', 'March', 'April', 'May', 'June', 'July',
              'August', 'September', 'October', 'November', 'December']
    return sorted(data, key=lambda x: months.index(x[0].strip()))


def cumulative_sum_to_normal(data):
    ret_data = [None]*len(data)
    for i in range(len(data)-1, 0, -1):
        ret_data[i] = data[i] - data[i-1]
    ret_data[0] = data[0]
    return ret_data


def get_covid_india():
    query = """
SELECT
    to_char(cin_date,'Month') as tmp_month,
    SUM(cin_cured),
    SUM(cin_deaths),
    SUM(cin_confirmed)
FROM
    covid_india
GROUP BY
    tmp_month;
"""
    cursor = conn.cursor()
    cursor.execute(query)
    data = cursor.fetchall()
    cursor.close()

    sorted_data = order_by_month(data)
    n = len(sorted_data)
    cured = cumulative_sum_to_normal([sorted_data[i][1] for i in range(n)])
    deaths = cumulative_sum_to_normal([sorted_data[i][2] for i in range(n)])
    confirmed = cumulative_sum_to_normal([sorted_data[i][3] for i in range(n)])

    cured.pop()
    deaths.pop()
    confirmed.pop()

    return {'cured': cured,
            'deaths': deaths,
            'confirmed': confirmed}


def get_covid_italy():
    query = """
SELECT
    to_char(cit_date, 'Month') as tmp_month,
    SUM(cit_province)
FROM
    covid_italy
GROUP BY
    tmp_month;
"""
    cursor = conn.cursor()
    cursor.execute(query)
    data = cursor.fetchall()
    cursor.close()

    sorted_data = order_by_month(data)
    cases = cumulative_sum_to_normal(
        [sorted_data[i][1] for i in range(len(sorted_data))])

    cases.pop()
    return {'cases': cases}
