from flask import Blueprint, render_template, redirect, url_for, request, flash
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import login_user, logout_user, login_required
from .model import *
from __init__ import db
from sqlalchemy import func
from datetime import datetime
import random


tables = Blueprint('tables',__name__)

@tables.route('/tables', methods=['GET', 'POST'])
def show():
    if request.form.get("plaka"):
        print('plaka: ', request.form.get('plaka'))
        return redirect(url_for('tables.show2',plaka_no = str(request.form.get("plaka"))))
    il = Il.query.order_by(Il.plakano).all()
    return render_template('tables.html', data=il)

@tables.route('/tables2', methods=['GET', 'POST'])
def show2():
    if request.form.get("plaka"):
        print('plaka: ', request.form.get('plaka'))
        return redirect(url_for('tables.show3',posta_kodu=request.form.get("plaka")))
    plaka_no = request.args.get('plaka_no')
    ilce = Ilce.query.filter_by(plakano=plaka_no).order_by(Ilce.postakodu).all()
    
    return render_template('tables2.html', data=ilce)

@tables.route('/tables3', methods=['GET', 'POST'])
def show3():
    if request.form.get("plaka"):
        print('plaka: ', request.form.get('plaka'))
    posta_kodu = request.args.get('posta_kodu')
    hastane = Hastane.query.filter_by(postakodu=posta_kodu).order_by(Hastane.isim).all()
    
    return render_template('tables3.html', data=hastane)