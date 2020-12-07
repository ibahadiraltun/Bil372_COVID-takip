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


@main.route('/hospitals')
@login_required
def hospitals():
    return render_template('hospitals.html')

@main.route('/hospitals', methods=['POST'])
@login_required
def hospitals_post():
    hastaneno = request.form.get('hastaneno')
    ilplakano = request.form.get('plakano')
    ilismi = request.form.get('ilismi')
    ilcepostakodu = request.form.get('postakodu')
    ilceismi = request.form.get('ilceismi')
    isim = request.form.get('isim')
    hastasayisi = request.form.get('hastasayisi')
    doktorsayisi = request.form.get('doktorsayisi')
    olusayisi = request.form.get('olusayisi')

    il=Il.query.filter_by(plakano=ilplakano).first()
    ilce=Ilce.query.filter_by(plakano=ilplakano, postakodu=ilcepostakodu).first()
    hastane=Hastane.query.filter_by(hastaneno = hastaneno, plakano=ilplakano, postakodu=ilcepostakodu).first()

    if hastane:
        flash('Bu bilgilere sahip bir hastane zaten var.')
        return redirect(url_for('main.hospitals'))

    if not il:
        new_il = Il(ilplakano,ilismi, hastasayisi, doktorsayisi, olusayisi)
        new_ilce = Ilce(ilplakano, ilcepostakodu, ilceismi, hastasayisi, doktorsayisi, olusayisi)
        hastane=Hastane(hastaneno, ilplakano, ilcepostakodu, isim, hastasayisi, doktorsayisi, olusayisi)
        
        db.session.add(new_il)
        db.session.commit()
        
        db.session.add(new_ilce)
        db.session.commit()
        
        db.session.add(hastane)
        db.session.commit()
        return redirect(url_for('main.hospitals'))
    elif il and not ilce:
        new_ilce = Ilce(ilplakano, ilcepostakodu, ilceismi, hastasayisi, doktorsayisi, olusayisi)
        db.session.add(new_ilce)
        db.session.commit()
        
        il.hastasayisi = il.hastasayisi+int(hastasayisi)
        il.doktorsayisi = il.doktorsayisi+int(doktorsayisi)
        il.olusayisi = il.olusayisi+int(olusayisi)
        
        hastane=Hastane(hastaneno, ilplakano, ilcepostakodu, isim, hastasayisi, doktorsayisi, olusayisi)
        db.session.add(hastane)
        db.session.commit()
    else:
        hastane=Hastane(hastaneno, ilplakano, ilcepostakodu, isim, hastasayisi, doktorsayisi, olusayisi)
        db.session.add(hastane)
        ilce.hastasayisi = il.hastasayisi+int(hastasayisi)
        ilce.doktorsayisi = il.doktorsayisi+int(doktorsayisi)
        ilce.olusayisi = il.olusayisi+int(olusayisi)

        il.hastasayisi = il.hastasayisi+int(hastasayisi)
        il.doktorsayisi = il.doktorsayisi+int(doktorsayisi)
        il.olusayisi = il.olusayisi+int(olusayisi)
        db.session.commit()

    return redirect(url_for('main.hospitals'))