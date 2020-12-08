from flask_login import UserMixin
from sqlalchemy import String

from __init__ import db

from sqlalchemy.ext.mutable import Mutable
from sqlalchemy.dialects.postgresql import ARRAY

class MutableList(Mutable, list):
    def append(self, value):
        list.append(self, value)
        self.changed()

    @classmethod
    def coerce(cls, key, value):
        if not isinstance(value, MutableList):
            if isinstance(value, list):
                return MutableList(value)
            return Mutable.coerce(key, value)
        else:
            return value


class Users(UserMixin, db.Model):
    __tablename__ = 'users'
    authenticationid = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(13))
    password = db.Column(db.String(200))

    def __init__(self, authenticationid,username, password):
        self.authenticationid = authenticationid
        self.username = username
        self.password = password


    def get_id(self):
        return (self.authenticationid)

class Il(db.Model):
    __tablename__ = 'il'
    plakano = db.Column(db.Integer, primary_key=True)
    isim = db.Column(db.String(50))
    hastasayisi = db.Column(db.Integer)
    doktorsayisi = db.Column(db.Integer)
    olusayisi = db.Column(db.Integer)


    def __init__(self, plakano,isim,hastasayisi,doktorsayisi,olusayisi):
        self.plakano = plakano
        self.isim = isim
        self.hastasayisi = hastasayisi
        self.doktorsayisi = doktorsayisi
        self.olusayisi = olusayisi


class Ilce(db.Model):
    __tablename__ = 'ilçe'
    plakano = db.Column(db.Integer,db.ForeignKey(
        Il.plakano) , primary_key=True)
    postakodu = db.Column(db.Integer, primary_key=True)
    isim = db.Column(db.String(50))
    hastasayisi = db.Column(db.Integer)
    doktorsayisi = db.Column(db.Integer)
    olusayisi = db.Column(db.Integer)


    def __init__(self, plakano,postakodu,isim,hastasayisi,doktorsayisi,olusayisi):
        self.plakano = plakano
        self.postakodu= postakodu
        self.isim = isim
        self.hastasayisi = hastasayisi
        self.doktorsayisi = doktorsayisi
        self.olusayisi = olusayisi

class Hastane(db.Model):
    ___tablename__ = 'hastane'
    hastaneno = db.Column(db.Integer, primary_key=True)
    plakano = db.Column(db.Integer,db.ForeignKey(
        Ilce.plakano) , primary_key=True)
    postakodu = db.Column(db.Integer, db.ForeignKey(
        Ilce.postakodu), primary_key=True)
    isim = db.Column(db.String(50))
    hastasayisi = db.Column(db.Integer)
    doktorsayisi = db.Column(db.Integer)
    olumsayisi = db.Column(db.Integer)


    def __init__(self, hastaneno,plakano,postakodu,isim,hastasayisi,doktorsayisi,olumsayisi):
        self.hastaneno = hastaneno
        self.plakano = plakano
        self.postakodu = postakodu
        self.isim = isim
        self.hastasayisi = hastasayisi
        self.doktorsayisi = doktorsayisi
        self.olumsayisi = olumsayisi


class Calisanlar(db.Model):
    __tablename__ = 'çalışanlar'
    tckn = db.Column(db.String(13), primary_key=True)
    password = db.Column(db.String(50))
    plakano = db.Column(db.Integer , db.ForeignKey(
        Hastane.plakano))
    hastaneno = db.Column(db.Integer, db.ForeignKey(
        Hastane.hastaneno))
    ad = db.Column(db.String(50))
    soyad = db.Column(db.String(50))
    telno = db.Column(db.String(50))
    postakodu = db.Column(db.Integer , db.ForeignKey(
        Hastane.postakodu))
    tur = db.Column(db.SMALLINT) # 0 = admin 1 = doktor 2= hemşire

    def __init__(self, tckn,plakano,hastaneno,password,ad,soyad,telno,postakodu,tur):
        self.tckn = tckn
        self.password = password
        self.plakano = plakano
        self.hastaneno = hastaneno
        self.ad = ad
        self.soyad = soyad
        self.telno = telno
        self.postakodu = postakodu
        self.tur = tur

class OlasiVakalar(db.Model):
    __tablename__ = 'olasıvakalar'
    tckn = db.Column(db.String(13), primary_key=True)
    ad = db.Column(db.String(50))
    soyad = db.Column(db.String(50))
    telno = db.Column(db.String(50))
    evadresi = db.Column(db.String(200))
    isadresi = db.Column(db.String(200))
    testtarihi = db.Column(db.DateTime)
    testdurumu = db.Column(db.SMALLINT)
    yas = db.Column(db.SMALLINT)
    cinsiyet = db.Column(db.String(20))
    kronikhastalik = db.Column(db.BOOLEAN)

    def __init__(self, tckn,ad,soyad,telno,evadresi,isadresi,testtarihi,testdurumu,yas,cinsiyet,kronikhastalik):
        self.tckn = tckn
        self.ad = ad
        self.soyad = soyad
        self.telno = telno
        self.evadresi = evadresi
        self.isadresi = isadresi
        self.testtarihi = testtarihi
        self.testdurumu = testdurumu
        self.yas = yas
        self.cinsiyet = cinsiyet
        self.kronikhastalik = kronikhastalik

class Vakalar(db.Model):
    __tablename__ = 'vakalar'
    tckn = db.Column(db.Integer,db.ForeignKey(
        OlasiVakalar.tckn) , primary_key=True)
    durum = db.Column(db.Integer)
    ilaclistesi = db.Column(db.ARRAY(String, dimensions=3))

    def __init__(self, tckn,durum,ilaclistesi):
        self.tckn = tckn
        self.durum = durum
        self.ilaclistesi = ilaclistesi



class Temaslilar(db.Model):
    __tablename__ = 'temaslılar'
    temaslitckn = db.Column(db.String(13), primary_key=True)
    ad = db.Column(db.String(50))
    soyad = db.Column(db.String(50))
    telno = db.Column(db.String(50))
    evadresi = db.Column(db.String(200))
    isadresi = db.Column(db.String(200))

    def __init__(self, temaslitckn, ad, soyad, telno, evadresi, isadresi):
        self.temaslitckn = temaslitckn
        self.ad = ad
        self.soyad = soyad
        self.telno = telno
        self.evadresi = evadresi
        self.isadresi = isadresi

class Temas(db.Model):
    __tablename__ = 'temas'
    temaslitckn = db.Column(db.String(13), db.ForeignKey(
        Temaslilar.temaslitckn), primary_key=True)
    tckn = db.Column(db.String(13), db.ForeignKey(
        Vakalar.tckn), primary_key=True)
    temasyeri = db.Column(db.String(50))
    temastarihi = db.Column(db.DateTime)
    temasliisim = db.Column(db.String(50))
    temaslisoyisim = db.Column(db.String(50))

    def __init__(self, temaslitckn, tckn, temasyeri, temastarihi, temasliisim, temaslisoyisim):
        self.temaslitckn = temaslitckn
        self.tckn = tckn
        self.temasyeri = temasyeri
        self.temastarihi = temastarihi
        self.temasliisim = temasliisim
        self.temaslisoyisim = temaslisoyisim



class IlacListesi(db.Model):
    __tablename__ = 'ilaçlistesi'
    tckn = db.Column(db.String(13), db.ForeignKey(Vakalar.tckn),primary_key=True)
    vakaisim = db.Column(db.String(50))
    vakasoyisim = db.Column(db.String(50))
    ilacadi = db.Column(db.String(50))

    def __init__(self, tckn , fname, lname, medicinename):
        self.tckn = tckn
        self.vakaisim = fname
        self.vakasoyisim = lname
        self.ilacadi = medicinename



