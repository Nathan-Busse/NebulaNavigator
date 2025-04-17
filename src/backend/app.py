from flask import Flask, jsonify, request
from flask_mysqldb import MySQL
from config import MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DB
from pymongo import MongoClient
import os
from dotenv import load_dotenv
from datetime import datetime

# Load environment variables
load_dotenv()
MONGO_URI = os.getenv("MONGO_URI", "mongodb://localhost:27017")

# Initialize MongoDB client
mongo_client = MongoClient(MONGO_URI)

# Access the database
db = mongo_client["code_analysis"]

# Example: Access a collection
code_files_collection = db["code_files"]
analysis_results_collection = db["analysis_results"]

# Function to insert a code file into the database
def insert_code_file(file_name: str, content: str):
    document = {
        "file_name": file_name,
        "content": content,
        "upload_time": datetime.utcnow()
    }
    result = code_files_collection.insert_one(document)
    return str(result.inserted_id)

# Function to retrieve all code files
def get_all_code_files():
    return list(code_files_collection.find({}, {"_id": 0}))

# Function to insert analysis results
def insert_analysis_result(file_id: str, result: str):
    document = {
        "file_id": file_id,
        "result": result,
        "analysis_time": datetime.utcnow()
    }
    result = analysis_results_collection.insert_one(document)
    return str(result.inserted_id)

# Function to retrieve analysis results for a specific file
def get_analysis_results(file_id: str):
    return list(analysis_results_collection.find({"file_id": file_id}, {"_id": 0}))

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

# Route to upload a code file
@app.route('/upload_code', methods=['POST'])
def upload_code():
    try:
        data = request.json
        file_name = data.get('file_name')
        content = data.get('content')

        if not file_name or not content:
            return jsonify({"error": "file_name and content are required."}), 400

        file_id = insert_code_file(file_name, content)
        return jsonify({"message": "File uploaded successfully.", "file_id": file_id})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Route to retrieve all code files
@app.route('/get_code_files', methods=['GET'])
def get_code_files():
    try:
        files = get_all_code_files()
        return jsonify(files)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# Route to fetch analysis results for a specific file
@app.route('/get_analysis_results/<file_id>', methods=['GET'])
def fetch_analysis_results(file_id):
    try:
        results = get_analysis_results(file_id)
        return jsonify(results)
    except Exception as e:
        return jsonify({"error": str(e)}), 500