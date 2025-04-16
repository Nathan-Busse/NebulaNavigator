import flask
from flask import request, jsonify, send_file
from flask_cors import CORS
import os
import json
import openai
import re
import logging
import time
from dotenv import load_dotenv
from typing import List, Dict, Any, Tuple
from pydantic import BaseModel, Field, ValidationError
from datetime import datetime
from pathlib import Path
from collections import defaultdict
from functools import wraps
import traceback
import sys
import shutil
import tempfile
import subprocess
import zipfile
import base64
import random
import string
import threading
import uuid
import hashlib
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Add MongoDB setup
from pymongo import MongoClient

# Load environment variables
load_dotenv()
MONGO_URI = os.getenv("MONGO_URI", "mongodb://localhost:27017")

# Initialize MongoDB client
mongo_client = MongoClient(MONGO_URI)

# Example: Access a database and collection
db = mongo_client["example_db"]
collection = db["example_collection"]