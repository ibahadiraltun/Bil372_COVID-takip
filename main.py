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

@main.route('/yeni_vaka', methods=['POST', 'GET'])
def yeni_vaka():
    print('ASDASD')
    return render_template('index.html')



