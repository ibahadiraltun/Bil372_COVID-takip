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