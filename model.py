from flask_login import UserMixin
from __init__ import db


class Users(UserMixin, db.Model):
    __tablename__ = 'users'
    authenticationid = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(13))
    password = db.Column(db.String(200))
    tür = db.Column(db.SMALLINT)

    def __init__(self, authenticationid,username, password,tür):
        self.authenticationid = authenticationid
        self.username = username
        self.password = password
        self.tür = tür

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
    olusayisi = db.Column(db.Integer)


    def __init__(self, hastaneno,plakano,postakodu,isim,hastasayisi,doktorsayisi,olusayisi):
        self.hastaneno = hastaneno
        self.plakano = plakano
        self.postakodu = postakodu
        self.isim = isim
        self.hastasayisi = hastasayisi
        self.doktorsayisi = doktorsayisi
        self.olusayisi = olusayisi


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

    def __init__(self, tckn,plakano,hastaneno,password,ad,soyad,telno,postakodu):
        self.tckn = tckn
        self.password = password
        self.plakano = plakano
        self.hastaneno = hastaneno
        self.ad = ad
        self.soyad = soyad
        self.telno = telno
        self.postakodu = postakodu

