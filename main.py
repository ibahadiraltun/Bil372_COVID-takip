from flask import Blueprint, render_template, redirect, url_for, request, flash
from flask_login import login_required, current_user, logout_user
from .model import *
from __init__ import db
from datetime import date
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
    if(vaka.ilaclistesi==None):
        vaka.ilaclistesi=[ilac]
    else:
        vaka.ilaclistesi.append(ilac)
    print(vaka.ilaclistesi)
    
    db.session.commit()

    return redirect(url_for('main.medicinelists'))

@main.route('/deletemedicinelists')
@login_required
def deletemedicinelists():
    return render_template('deletemedicinelists.html')

@main.route('/deletemedicinelists', methods=['POST'])
@login_required
def deletemedicinelists_delete():
    tckn = request.form.get('tckn')
    isim = request.form.get('vakaisim')
    soyisim = request.form.get('vakasoyisim')
    ilac = request.form.get('vakailacı')

    vaka = Vakalar.query.filter_by(tckn=tckn).first()
    olasivaka=OlasiVakalar.query.filter_by(tckn=tckn).first()

    if not vaka:
        flash('Bu TC Kimlik Numarasına sahip bir vaka yok, ilaç silinemez.')
        return redirect(url_for('main.deletemedicinelists'))
    if olasivaka.ad != isim or olasivaka.soyad != soyisim:
        flash('Bu TC Kimlik Numarasına sahip vakanın ismi veya soyismi yanlış girildi.')
        return redirect(url_for('main.deletemedicinelists'))
    if(vaka.ilaclistesi==None):
        flash('Bu TC Kimlik Numarasına sahip vakanın bu ilacı bulunamadı.')
        return redirect(url_for('main.deletemedicinelists'))
    else:
        vaka.ilaclistesi.remove(ilac)
    print(vaka.ilaclistesi)
    
    db.session.commit()

    return redirect(url_for('main.deletemedicinelists'))


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

    il=Il.query.filter_by(plakano=ilplakano).first()
    ilce=Ilce.query.filter_by(plakano=ilplakano, postakodu=ilcepostakodu).first()
    hastane=Hastane.query.filter_by(hastaneno = hastaneno, plakano=ilplakano, postakodu=ilcepostakodu).first()

    if hastane:
        flash('Bu bilgilere sahip bir hastane zaten var.')
        return redirect(url_for('main.hospitals'))

    if not il:
        new_il = Il(ilplakano,ilismi, 0, 0, 0)
        new_ilce = Ilce(ilplakano, ilcepostakodu, ilceismi, 0, 0, 0)
        hastane=Hastane(hastaneno, ilplakano, ilcepostakodu, isim, 0, 0, 0)
        
        db.session.add(new_il)
        db.session.commit()
        
        db.session.add(new_ilce)
        db.session.commit()
        
        db.session.add(hastane)
        db.session.commit()
        return redirect(url_for('main.hospitals'))
    elif il and not ilce:
        new_ilce = Ilce(ilplakano, ilcepostakodu, ilceismi, 0, 0, 0)
        db.session.add(new_ilce)
        db.session.commit()
        
        hastane=Hastane(hastaneno, ilplakano, ilcepostakodu, isim, 0, 0, 0)
        db.session.add(hastane)
        db.session.commit()
    else:
        hastane=Hastane(hastaneno, ilplakano, ilcepostakodu, isim, 0, 0, 0)
        db.session.add(hastane)
        db.session.commit()

    return redirect(url_for('main.hospitals'))

@main.route('/deletehospitals')
@login_required
def deletehospitals():
    return render_template('deletehospitals.html')

@main.route('/deletehospitals', methods=['POST'])
@login_required
def deletehospitals_delete():
    hastaneno = request.form.get('hastaneno')
    ilplakano = request.form.get('plakano')
    ilcepostakodu = request.form.get('postakodu')

    hastane=Hastane.query.filter_by(hastaneno = hastaneno, plakano=ilplakano, postakodu=ilcepostakodu).first()
    il=Il.query.filter_by(plakano=ilplakano).first()
    ilce=Ilce.query.filter_by(plakano=ilplakano, postakodu=ilcepostakodu).first()
    calisanlar= Calisanlar.query.filter_by(plakano=ilplakano, hastaneno=hastane.hastaneno).all()

    if not hastane:
        flash('Böyle bir hastane yok, silinemez.')
        return redirect(url_for('main.deletehospitals'))
    else:
        db.session.remove(hastane)
        il.hastasayisi= il.hastasayisi-int(hastane.hastasayisi)
        il.doktorsayisi= il.doktorsayisi-int(hastane.doktorsayisi)
        il.olusayisi= il.olusayisi-int(hastane.olusayisi)

        ilce.hastasayisi= ilce.hastasayisi-int(hastane.hastasayisi)
        il.doktorsayisi= ilce.doktorsayisi-int(hastane.doktorsayisi)
        il.olusayisi= ilce.olusayisi-int(hastane.olusayisi)

        for x in calisanlar:
            db.session.remove(x)

    db.session.commit()

    return redirect(url_for('main.deletehospitals'))


def get_possible_cases():
    cases = OlasiVakalar.query.filter_by(testdurumu = 0).all()
    return cases

@main.route('/olasi_vakalar', methods=['POST', 'GET'])
def olasi_vakalar():
    possible_cases = get_possible_cases()
    return render_template('olasi_vakalar.html', cases = possible_cases)

@main.route('/delete_olasi_vaka/<tckn>', methods=['POST', 'GET'])
def delete_olasi_vaka(tckn):
    possible_case = db.session.query(OlasiVakalar).filter_by(tckn = tckn).first()
    db.session.delete(possible_case)
    db.session.commit()
    return redirect(url_for('main.olasi_vakalar'))

@main.route('/update_olasi_vaka/<tckn>', methods=['POST', 'GET'])
def update_olasi_vaka(tckn):
    if request.method == 'POST':
        form = request.form
        values = form.to_dict(flat = True)
        existing_case = db.session.query(OlasiVakalar).filter_by(tckn = tckn).first()
        existing_case.tckn = values['tckn']
        existing_case.ad = values['ad']
        existing_case.soyad = values['soyad']
        existing_case.telno = values['telno']
        existing_case.evadresi = values['evadresi']
        existing_case.isadresi = values['isadresi']
        existing_case.testtarihi = values['testtarihi']
        existing_case.testdurumu = int(values['testdurumu'])
        existing_case.yas = values['yas']
        existing_case.cinsiyet = values['cinsiyet']
        if (values['kronikhastalik'] == '0'): existing_case.kronikhastalik = 0
        else: existing_case.kronikhastalik = 1
        db.session.commit()
        return redirect(url_for('main.olasi_vakalar'))

    possible_case = db.session.query(OlasiVakalar).filter_by(tckn = tckn).first()
    return render_template('update_olasi_vaka.html', case = possible_case)

@main.route('/yeni_olasi_vaka', methods=['POST', 'GET'])
def yeni_olasi_vaka():
    if request.method == 'POST':
        form = request.form
        values = form.to_dict(flat = True)
        new_possible_case = OlasiVakalar(tckn = values['tckn'], ad = values['ad'], soyad = values['soyad'], 
                                        telno = values['telno'], evadresi = values['evadresi'], isadresi = values['isadresi'], 
                                        testtarihi = values['testtarihi'], testdurumu = int(values['testdurumu']),
                                        yas = values['yas'], cinsiyet = values['cinsiyet'], kronikhastalik = bool(values['kronikhastalik']))
        db.session.add(new_possible_case)
        db.session.commit()
        return redirect(url_for('main.olasi_vakalar'))
    return render_template('yeni_olasi_vaka.html')



@main.route('/vaka/ekle', methods=["GET"])
@login_required
def ekle_vaka():

    pozitif_vakalar = db.session.query(OlasiVakalar).filter(
        OlasiVakalar.testdurumu == 1).all()


    return render_template('ekle_vaka.html', vaka=pozitif_vakalar)


@main.route('/vaka/ekle/<ekle>', methods=["POST", "GET"])
@login_required
def ekle_vaka2(ekle):

    hasta = db.session.query(OlasiVakalar).filter(
        OlasiVakalar.tckn == ekle).one()

    tc = current_user.username

    calisan = db.session.query(Calisanlar).filter(
        Calisanlar.tckn == tc).one()

    il = db.session.query(Il).filter(
        Il.plakano == calisan.plakano
    ).one()
    il.hastasayisi = il.hastasayisi + 1

    ilce = db.session.query(Ilce).filter(
        Ilce.postakodu == calisan.postakodu and
        Ilce.plakano == calisan.plakano
    ).one()
    ilce.hastasayisi = ilce.hastasayisi + 1

    hastane = db.session.query(Hastane).filter(
        Hastane.hastaneno == calisan.hastaneno and
        Hastane.postakodu == calisan.postakodu and
        Hastane.plakano == calisan.plakano
        ).one()
    hastane.hastasayisi = hastane.hastasayisi +1





    vaka = Vakalar(hasta.tckn,0,None)

    hasta.testdurumu=-2

    db.session.add(vaka)
    db.session.commit()
    db.session.add(hasta)
    db.session.commit()

    return redirect(url_for('main.ekle_vaka'))


@main.route('/vaka/guncelle', methods=["GET"])
@login_required
def guncelle_vaka():
    vakalar = db.session.query(Vakalar).filter(
        Vakalar.durum == 0).all()


    return render_template('guncelle_vaka.html', vaka=vakalar)

@main.route('/vaka/guncelle/<tckn>/<durum>', methods=["POST", "GET"])
@login_required
def guncelle_vaka2(tckn,durum):
    tc = current_user.username

    calisan = db.session.query(Calisanlar).filter(
        Calisanlar.tckn == tc).one()

    if durum == '1':
       vaka=  db.session.query(Vakalar).filter(
            Vakalar.tckn == tckn).one()
       db.session.delete(vaka)
       db.session.commit()

    elif durum == '-1':
        vaka = db.session.query(Vakalar).filter(
            Vakalar.tckn == tckn).one()
        vaka.durum = -1
        db.session.add(vaka)
        db.session.commit()

        il = db.session.query(Il).filter(
            Il.plakano == calisan.plakano
        ).one()
        il.olusayisi = il.olusayisi + 1
        db.session.add(il)
        db.session.commit()

        ilce = db.session.query(Ilce).filter(
            Ilce.postakodu == calisan.postakodu and
            Ilce.plakano == calisan.plakano
        ).one()
        ilce.olusayisi = ilce.olusayisi + 1
        db.session.add(ilce)
        db.session.commit()

        hastane = db.session.query(Hastane).filter(
            Hastane.hastaneno == calisan.hastaneno and
            Hastane.postakodu == calisan.postakodu and
            Hastane.plakano == calisan.plakano
        ).one()
        hastane.olumsayisi = hastane.olumsayisi + 1
        db.session.add(hastane)
        db.session.commit()

    il = db.session.query(Il).filter(
        Il.plakano == calisan.plakano
    ).one()
    il.hastasayisi = il.hastasayisi - 1
    db.session.add(il)
    db.session.commit()

    ilce = db.session.query(Ilce).filter(
        Ilce.postakodu == calisan.postakodu and
        Ilce.plakano == calisan.plakano
    ).one()
    ilce.hastasayisi = ilce.hastasayisi - 1
    db.session.add(ilce)
    db.session.commit()

    hastane = db.session.query(Hastane).filter(
        Hastane.hastaneno == calisan.hastaneno and
        Hastane.postakodu == calisan.postakodu and
        Hastane.plakano == calisan.plakano
    ).one()
    hastane.hastasayisi = hastane.hastasayisi - 1
    db.session.add(hastane)
    db.session.commit()


    return redirect(url_for('main.guncelle_vaka'))


@main.route('/temasli/ekle', methods=["GET"])
@login_required
def ekle_temasli():
    vakalar = db.session.query(Vakalar).filter(
        Vakalar.durum == 0).all()


    return render_template('ekle_temasli.html', vaka=vakalar)

@main.route('/temasli/ekle', methods=['POST'])
@login_required
def ekle_temasli_post():

    tckn = request.form.get('tckn')
    ttckn = request.form.get('ttckn')
    ad = request.form.get('tad')
    soyad = request.form.get('tsoyad')
    telno = request.form.get('ttno')
    ev = request.form.get('tev')
    isy = request.form.get('tis')
    tarih = request.form.get('ttarih')
    yer = request.form.get('tyer')

    ttarih = date(*map(int, tarih.split('-')))
    yeni_temasli = Temaslilar(ttckn,ad,soyad,telno,ev,isy)
    yeni_temas = Temas(ttckn,tckn,yer,ttarih,ad,soyad)
    db.session.add(yeni_temasli)
    db.session.commit()
    db.session.add(yeni_temas)
    db.session.commit()


    return redirect(url_for('main.ekle_temasli'))