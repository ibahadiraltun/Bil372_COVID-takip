from src import db
from src.tableforms import add_new_user

def drop_tables(db):
    db.drop_all()

def create_tables(db):
    db.create_all()

if __name__ == "__main__":
    drop_tables(db)
    create_tables(db)
    add_new_user(username="superadmin", password="password", admin=True)