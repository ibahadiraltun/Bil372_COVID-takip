class PossibleCases(db.Model):
    __tablename__ = "POSSIBLECASES"
    PC_TCKN = db.Column(db.Integer, primary_key=True)
    PC_FNAME = db.Column(db.String(15), unique=True)
    PC_PHONE = db.Column(db.String(25))
    PC_HOMEADDRESS = db.Column(db.String(10))
    PC_WORKADDRESS = db.Column(db.String(15))
    PC_TESTDATE = db.Column(db.DateTime, default=datetime.now)
    PC_AGE = db.Column(db.Integer)
    PC_GENDER = db.Column(db.String(6))
    PC_CHRONICDISEASE= db.Column(db.String(15), unique=True)

    tckn=db.relationship('Case', backref='pc', single_parent=True, cascade="all, delete-orphan", remote_side=[C_TCKN], foreign_keys='CASE.C_TCKN')


class Case(db.Model):
    __tablename__ = "CASES"
    C_TCKN = db.Column(db.Integer, db.ForeignKey("POSSIBLECASES.PC_TCKN"), primary_key=True)
    C_MEDICINELIST = db.Column(db.String(200))

    contact=db.relationship('Contact', backref='case', single_parent=True, cascade="all, delete-orphan", remote_side=[C_CASE_TCKN], foreign_keys='CONT.C_CASE_TCKN')
    medlist=db.relationship('MedicineLists', backref='case', single_parent=True, cascade="all, delete-orphan", remote_side=[ML_TCKN], foreign_keys='MEDICINELISTS.ML_TCKN')

class Contacted(db.Model):
    __tablename__ = "CONTACTED"
    CT_TCKN = db.Column(db.Integer, primary_key=True)
    CT_FNAME = db.Column(db.String(200))
    CT_LNAME = db.Column(db.String(200))
    CT_PHONE = db.Column(db.Integer)
    CT_HOMEADDRESS = db.Column(db.String(200))
    CT_WORKADDRESS = db.Column(db.String(200))

    contact=db.relationship('Contact', backref='contacted', single_parent=True, cascade="all, delete-orphan", remote_side=[C_CON_TCKN], foreign_keys='CONTACT.C_CON_TCKN')

class Contact(db.Model):
    __tablename__ = "CONTACT"
    C_CON_TCKN = db.Column(db.Integer, db.ForeignKey("CONTACTED.CT_TCKN"), primary_key=True)
    C_CASE_TCKN = db.Column(db.Integer, db.ForeignKey("CASE.C_TCKN"), primary_key=True)
    C_DATE = db.Column(db.DateTime, default=datetime.now)
    C_ADDRESS = db.Column(db.String(200))

class MedicineLists(db.Model):
    __tablename__ = "MEDICINELISTS"
    ML_TCKN = db.Column(db.Integer, db.ForeignKey("CASE.C_TCKN"), primary_key=True)
    ML_FNAME = db.Column(db.String(20))
    ML_LNAME = db.Column(db.String(20))
    ML_MNAME = db.Column(db.String(20))


class Province(db.Model):
    __tablename__ = "PROVINCE"
    P_LICNO= db.Column(db.Integer, primary_key=True)
    P_NAME= db.Column(db.String(20))
    P_PATCOUNT= db.Column(db.Integer)
    P_DOCCOUNT= db.Column(db.Integer)
    P_XCOUNT= db.Column(db.Integer)

    county=db.relationship('County', backref='province', single_parent=True, cascade="all, delete-orphan", remote_side=[CO_LICNO], foreign_keys='COUNTY.CO_LICNO')
    hospital=db.relationship('Hospital', backref='province', single_parent=True, cascade="all, delete-orphan", remote_side=[H_LICNO], foreign_keys='HOSPITAL.H_LICNO')

class County(db.Model):
    __tablename__ = "COUNTY"
    CO_LICNO= db.Column(db.Integer, db.ForeignKey("PROVINCE.P_LICNO"), primary_key=True)
    CO_ZIPCODE= db.Column(db.Integer)
    CO_NAME= db.Column(db.String(20))
    CO_PATCOUNT= db.Column(db.Integer)
    CO_DOCCOUNT= db.Column(db.Integer)
    CO_XCOUNT= db.Column(db.Integer)

    hospital=db.relationship('Hospital', backref='county', single_parent=True, cascade="all, delete-orphan", remote_side=[H_ZIPCODE], foreign_keys='HOSPITAL.H_ZIPCODE')


class Hospital(db.Model):
    __tablename__ = "HOSPITAL"
    H_NUMBER= db.Column(db.Integer, primary_key=True, unique=True, autoincrement=True)
    H_LICNO= db.Column(db.Integer, db.ForeignKey("PROVINCE.P_LICNO"), primary_key=True)
    H_ZIPCODE= db.Column(db.Integer, db.ForeignKey("COUNTY.CO_ZIPCODE"), primary_key=True)
    H_NAME= db.Column(db.String(20))
    H_PATCOUNT= db.Column(db.Integer)
    H_DOCCOUNT= db.Column(db.Integer)
    H_XCOUNT= db.Column(db.Integer)
