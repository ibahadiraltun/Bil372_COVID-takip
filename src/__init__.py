from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from flask_login import LoginManager

app = Flask(__name__)
app.config["SECRET_KEY"] = "1dc5e33cf48b805a000ea86d3cb63b7c"
app.config["SQLALCHEMY_DATABASE_URI"] = "postgresql://postgres:password@localhost/project"
db = SQLAlchemy(app)
bcrypt = Bcrypt(app)
login_manager = LoginManager(app)
login_manager.login_view = "login"
login_manager.login_message_category = "info"

from src import routes