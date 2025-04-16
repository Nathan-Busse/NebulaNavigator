from flask import Flask, jsonify
from flask_mysqldb import MySQL
from config import MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DB
from pymongo import MongoClient
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()
MONGO_URI = os.getenv("MONGO_URI", "mongodb://localhost:27017")

# Initialize Flask app
app = Flask(__name__)

# Configure MySQL connection
app.config['MYSQL_HOST'] = MYSQL_HOST
app.config['MYSQL_USER'] = MYSQL_USER
app.config['MYSQL_PASSWORD'] = MYSQL_PASSWORD
app.config['MYSQL_DB'] = MYSQL_DB

# Initialize MySQL
mysql = MySQL(app)

# Initialize MongoDB client
mongo_client = MongoClient(MONGO_URI)

# Example: Access a database and collection
db = mongo_client["code_analysis"]
code_files_collection = db["code_files"]
analysis_results_collection = db["analysis_results"]

@app.route('/')
def index():
    return "Welcome to the Code Analysis Backend!"

# Create a route to initialize the database
@app.route('/init_db', methods=['GET'])
def init_db():
    try:
        cursor = mysql.connection.cursor()
        # Create database if it doesn't exist
        cursor.execute("CREATE DATABASE IF NOT EXISTS code_analysis")
        cursor.execute("USE code_analysis")

        # Create tables
        cursor.execute('''CREATE TABLE IF NOT EXISTS code_files (
            id INT AUTO_INCREMENT PRIMARY KEY,
            file_name VARCHAR(255) NOT NULL,
            content TEXT NOT NULL,
            upload_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )''')

        cursor.execute('''CREATE TABLE IF NOT EXISTS analysis_results (
            id INT AUTO_INCREMENT PRIMARY KEY,
            file_id INT NOT NULL,
            result TEXT NOT NULL,
            analysis_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (file_id) REFERENCES code_files(id)
        )''')

        mysql.connection.commit()
        return jsonify({"message": "Database and tables initialized successfully."})
    except Exception as e:
        return jsonify({"error": str(e)})

# Create a route to initialize MongoDB collections
@app.route('/init_mongo', methods=['GET'])
def init_mongo():
    try:
        # Ensure collections exist by inserting a dummy document and deleting it
        code_files_collection.insert_one({"dummy": True})
        code_files_collection.delete_one({"dummy": True})

        analysis_results_collection.insert_one({"dummy": True})
        analysis_results_collection.delete_one({"dummy": True})

        return jsonify({"message": "MongoDB collections initialized successfully."})
    except Exception as e:
        return jsonify({"error": str(e)})