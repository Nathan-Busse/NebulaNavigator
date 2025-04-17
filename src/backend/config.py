import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# MySQL Database Configuration
MYSQL_HOST = os.getenv("MYSQL_HOST", "localhost")
MYSQL_USER = os.getenv("MYSQL_USER", "root")
MYSQL_PASSWORD = os.getenv("MYSQL_PASSWORD", "")
MYSQL_DB = os.getenv("MYSQL_DB", "CodeAnalysis")
MYSQL_DB_PORT = os.getenv("MYSQL_DB_PORT", 3306)
MYSQL_DB_URL = f"mysql+pymysql://{MYSQL_USER}:{MYSQL_PASSWORD}@{MYSQL_HOST}:{MYSQL_DB_PORT}/{MYSQL_DB}"
