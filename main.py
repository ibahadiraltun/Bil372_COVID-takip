from flask import Blueprint, render_template, redirect, url_for, request, flash
from flask_login import login_required, current_user, logout_user
from .model import *
from . import db
from datetime import datetime
import uuid
from werkzeug.security import generate_password_hash
import random

main = Blueprint('main', __name__)


@main.route('/')
@login_required
def index():
    return render_template('index.html')

def get_possible_cases():
    cases = OlasiVakalar.query.filter_by(testdurumu = 0).all()
    return cases

@main.route('/olasi_vakalar', methods=['POST', 'GET'])
def olasi_vakalar():
    possible_cases = get_possible_cases()
    print('HEYY')
    for i in possible_cases:
        print(i.tckn)

    return render_template('olasi_vakalar.html', cases = possible_cases)

@main.route('/delete_olasi_vaka/<tckn>', methods=['POST', 'GET'])
def delete_olasi_vaka(tckn):
    possible_case = db.session.query(OlasiVakalar).filter_by(tckn = tckn).first()
    db.session.delete(possible_case)
    db.session.commit()
    return redirect(url_for('main.olasi_vakalar'))

@main.route('/yeni_olasi_vaka', methods=['POST', 'GET'])
def yeni_olasi_vaka():
    if request.method == 'POST':
        form = request.form
        print(form)
        values = form.to_dict(flat = True)
        print(values)
        new_possible_case = OlasiVakalar(tckn = values['tckn'], ad = values['ad'], soyad = values['soyad'], 
                                        telno = values['telno'], evadresi = values['evadresi'], isadresi = values['isadresi'], 
                                        testtarihi = values['testtarihi'], testdurumu = int(values['testdurumu']),
                                        yas = values['yas'], cinsiyet = values['cinsiyet'], kronikhastalik = bool(values['kronikhastalik']))
        db.session.add(new_possible_case)
        db.session.commit()
        return redirect(url_for('main.olasi_vakalar'))
    return render_template('yeni_olasi_vaka.html')



