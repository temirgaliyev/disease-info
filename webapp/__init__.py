from flask import (
    Flask,
    render_template,
    send_from_directory,
    url_for,
    redirect,
    request
)
from . import db


app = Flask(__name__, template_folder='templates')


@app.route('/plugins/<path:path>')
def static_plugins(path):
    return send_from_directory('plugins', path)


@app.route('/dist/<path:path>')
def static_dist(path):
    return send_from_directory('dist', path)


@app.route('/')
def page_overview():
    return redirect(url_for('page_general'))


@app.route('/general')
def page_general():
    cardio_data = db.get_cardio_age()
    heart_data = db.get_heart_age()
    kidney_data = db.get_kidney_age()

    by_gender = db.get_diseases_by_gender()

    return render_template('general.html',
                           data={'cardio': cardio_data,
                                 'heart': heart_data,
                                 'kidney': kidney_data
                                 },
                           by_gender=by_gender)


@app.route('/personal')
def page_personal():
    return render_template('personal.html')


def format_float_percentage(float_number: float) -> str:
    return f'{float_number*100:.2f}%'


def bp_to_cat(ap_hi: int = 120, ap_lo: int = 80) -> int:
    '''
    blood pressure to category:
        0 - low (hypotension)
        1 - normal
        2 - elevated
        3 - hypertension stage 1
        4 - hypertension stage 2
        5 - hypertension crisis
    '''
    if ap_hi <= 90 and ap_lo <= 60:
        return 'hypotension'
    if ap_hi <= 120 and ap_lo <= 80:
        return 'normal'
    if ap_hi <= 130 and ap_lo <= 80:
        return 'elevated'
    if ap_hi < 140 or ap_lo < 90:
        return 'hypertension stage 1'
    if ap_hi < 180 or ap_lo < 120:
        return 'hypertension stage 2'
    return 'hypertension crisis'


def chol_to_cat(chol: int) -> int:
    '''
    cholesterol to category:
        0 - normal
        1 - above normal
        2 - well above normal
    '''
    if chol < 200:
        return 'normal'
    if chol < 240:
        return 'above normal'
    return 'well above normal'


def gluc_to_cat(gluc: int) -> int:
    '''
    glucose to category:
        0 - normal
        1 - above normal
        2 - well above normal
    '''
    if gluc < 100:
        return 'normal'
    if gluc < 125:
        return 'above normal'
    return 'well above normal'


@app.route('/personal_stats')
def page_personal_stats():
    gender = int(request.args.get('gender', 'na') == 'female')
    age = request.args.get('age', '0')
    diabetes = (request.args.get('diabetes', 'na') == 'yes')
    systolic = request.args.get('systolic', '0')
    diastolic = request.args.get('diastolic', '0')
    chol = request.args.get('chol', '0')
    gluc = request.args.get('gluc', '0')

    age = int('-1' if age == '' else age)
    systolic = int('-1' if systolic == '' else systolic)
    diastolic = int('-1' if diastolic == '' else diastolic)
    chol = int('-1' if chol == '' else chol)
    gluc = int('-1' if gluc == '' else gluc)

    prob_cardio = db.get_cardio_prob(age, diabetes, gender)
    prob_heart = db.get_heart_prob(age, diabetes, gender)
    prob_kidney = db.get_kidney_prob(age, diabetes)
    prob_eye = db.get_eye_prob(age, diabetes, gender)
    prob_cad = db.get_cad_prob(age, diabetes, gender)

    bp_cat = bp_to_cat(systolic, diastolic)
    if bp_cat == 'normal':
        text_bp = 'Your blood pressure is normal'
    elif bp_cat == 'hypertension crisis':
        text_bp = f"You may have {bp_cat}.\
It's highly recommended to call your doctor."
    else:
        text_bp = f'You may have {bp_cat}'

    gluc_cat = gluc_to_cat(gluc)
    text_gluc = f'You glucose level is {gluc_cat}'

    chol_cat = gluc_to_cat(gluc)
    text_chol = f'You cholesterol level is {chol_cat}'

    return render_template('personal_stats.html',
                           prob_cardio=format_float_percentage(prob_cardio),
                           prob_heart=format_float_percentage(prob_heart),
                           prob_kidney=format_float_percentage(prob_kidney),
                           prob_eye=format_float_percentage(prob_eye),
                           prob_cad=format_float_percentage(prob_cad),
                           text_gluc=text_gluc,
                           text_bp=text_bp,
                           text_chol=text_chol
                           )


@app.route('/covid')
def page_covid():
    data_india = db.get_covid_india()
    data_italy = db.get_covid_italy()
    return render_template('covid.html', **data_india, **data_italy)
