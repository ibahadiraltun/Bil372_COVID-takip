from flask import Blueprint, render_template, redirect, url_for, request, flash
from flask_login import login_required, current_user, logout_user
from .model import *
from __init__ import db
from datetime import datetime
import uuid
from werkzeug.security import generate_password_hash
import random
main = Blueprint('main', __name__)


@main.route('/')
@login_required
def index():
    return render_template('index.html')

@main.route('/medicinelists')
@login_required
def medicinelists():
    return render_template('medicinelists.html')

@main.route('/medicinelists', methods=['POST'])
@login_required
def medicinelists_post():
    tckn = request.form.get('tckn')
    isim = request.form.get('vakaisim')
    soyisim = request.form.get('vakasoyisim')
    ilac = request.form.get('vakailacı')

    vaka = Vakalar.query.filter_by(tckn=tckn).first()
    olasivaka=OlasiVakalar.query.filter_by(tckn=tckn).first()

    if not vaka:
        flash('Bu TC Kimlik Numarasına sahip bir vaka yok, ilaç listesi oluşturulamaz.')
        return redirect(url_for('main.medicinelists'))
    if olasivaka.ad != isim or olasivaka.soyad != soyisim:
        flash('Bu TC Kimlik Numarasına sahip vakanın ismi veya soyismi yanlış girildi.')
        return redirect(url_for('main.medicinelists'))

    vaka.ilaclistesi.append(ilac)
    print(vaka.ilaclistesi)
    
    db.session.commit()

    return redirect(url_for('main.medicinelists'))