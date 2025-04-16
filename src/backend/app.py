from flask import Flask
from flask_mysqldb import MySQL
from config import MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DB

# Initialize Flask app
app = Flask(__name__)

# Configure MySQL connection
app.config['MYSQL_HOST'] = MYSQL_HOST
app.config['MYSQL_USER'] = MYSQL_USER
app.config['MYSQL_PASSWORD'] = MYSQL_PASSWORD
app.config['MYSQL_DB'] = MYSQL_DB

# Initialize MySQL
mysql = MySQL(app)

@app.route('/')
def index():
    return "Welcome to the Code Analysis Backend!"