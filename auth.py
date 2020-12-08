from flask import Blueprint, render_template, redirect, url_for, request, flash
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import login_user, logout_user, login_required
from .model import *
from __init__ import db
from datetime import datetime
import random

auth = Blueprint('auth', __name__)


@auth.route('/login')
def login():
    return render_template('login.html')


@auth.route('/login', methods=['POST'])
def login_post():
    username = request.form.get('username')
    password = request.form.get('password')
    remember = True if request.form.get('remember') else False

    user = Users.query.filter_by(username=username).first()

    if not user or not check_password_hash(user.password, password):
        flash('Please check your login details and try again.')
        return redirect(url_for('auth.login'))

    login_user(user, remember=remember)

    return redirect(url_for('main.index'))

@auth.route('/signup')
def signup():
    return render_template('signup.html')

@auth.route('/signup', methods=['POST'])
def signup_post():
    tckn = request.form.get('tckn')
    password = request.form.get('password')
    plakano = request.form.get('plakano')
    hastaneno = request.form.get('hastaneno')
    ad = request.form.get('ad')
    soyad = request.form.get('soyad')
    telno = request.form.get('telno')
    pkodu = request.form.get('pkodu')
    hemsire = request.form.get('hemsire')
    doktor = request.form.get('doktor')

    if doktor == '1' and hemsire == '2':
        flash("İkisini birden seçemezsiniz")
        return redirect(url_for('auth.signup'))

    user = Users.query.filter_by(username=tckn).first()


    if user:
        flash('TCKN already exists.')
        return redirect(url_for('auth.signup'))
    try:
        maxID = db.session.query(func.max(Users.authenticationid)).scalar() + 1
    except:
        maxID = 1

    new_user = Users(authenticationid=maxID, username=tckn,
                     password=generate_password_hash(password, method='sha256'))

    new_calisan= ""
    if doktor == '1':
        new_calisan = Calisanlar(tckn=tckn, password=password, plakano=plakano,
                              hastaneno=hastaneno, ad=ad, soyad=soyad, telno=telno, postakodu=pkodu, tur=1)
    elif hemsire == '2':
        new_calisan = Calisanlar(tckn=tckn, password=password, plakano=plakano,
                                 hastaneno=hastaneno, ad=ad, soyad=soyad, telno=telno, postakodu=pkodu, tur=2)
    else:
        flash("Doktor veya hemşire olmalısınız.")

    db.session.add(new_user)
    db.session.commit()
    db.session.add(new_calisan)
    db.session.commit()


    return redirect(url_for('auth.login'))

@auth.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('main.index'))
