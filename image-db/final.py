import os
import requests
from flask import Flask, request, jsonify
from flask_pymongo import PyMongo
from flask_bcrypt import Bcrypt
from werkzeug.security import generate_password_hash, check_password_hash
from flask import Flask, request, url_for, render_template, send_from_directory
from werkzeug.utils import secure_filename
from flask_pymongo import PyMongo
from dotenv import load_dotenv
import logging

app = Flask(__name__, template_folder='templates')

# Load environment variables from .env file
load_dotenv()

# SerpAPI credentials from environment variables
API_KEY = os.getenv('SERP_API_KEY')

# Configure the upload folder and allowed extensions
UPLOAD_FOLDER = 'uploads/'
RESULT_FOLDER = 'results/'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['RESULT_FOLDER'] = RESULT_FOLDER

# MongoDB configuration
app.config["MONGO_URI"] = "mongodb://localhost:27017/stalkdb"
mongo = PyMongo(app)
# Ensure the upload and result folders exist
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
os.makedirs(RESULT_FOLDER, exist_ok=True)

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/signup', methods=['POST'])
def signup():
    data = request.get_json()
    username = data.get('username')
    password = data.get('password')
    
    if not username or not password:
        return jsonify({'error': 'Username and password are required'}), 400
    
    # Check if the username already exists
    user = mongo.db.users.find_one({'username': username})
    if user:
        return jsonify({'error': 'Username already exists'}), 400
    
    # Hash the password and save the user in the database
    hashed_password = generate_password_hash(password).decode('utf-8')
    mongo.db.users.insert_one({'username': username, 'password': hashed_password})
    
    return jsonify({'message': 'User registered successfully'}), 201


@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return 'No file part'
    file = request.files['file']
    if file.filename == '':
        return 'No selected file'
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(file_path)
        
        # Save file info to MongoDB
        #mongo.db.images.insert_one({'filename': filename, 'filepath': file_path})
        image_doc = {'filename': filename, 'filepath': file_path}
        image_id = mongo.db.images.insert_one(image_doc).inserted_id
        # Perform Google Reverse Image Search using SerpAPI

        search_url = "https://serpapi.com/search"
        params = {
            "engine": "google_reverse_image",
            "image_url": request.host_url + url_for('uploaded_file', filename=filename),
            "api_key": API_KEY
        }
        response = requests.get(search_url, params=params)
        result = response.json()
        # Update the specific document with the search result
        mongo.db.images.update_one(
            {'_id': image_id},
            {'$set': {'search_result': result}}
        )
        
        return 'File successfully uploaded and image search performed'


@app.route('/home')
def home():
    images = list(mongo.db.images.find())
    for image in images:
        app.logger.info(f"Image: {image}")
    return render_template('index.html', images=images)

@app.route('/upload-data', methods=['POST'])
def upload_file_search():
    if 'file' not in request.files:
        return 'No file part'
    file = request.files['file']
    if file.filename == '':
        return 'No selected file'
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        file_path = os.path.join(app.config['RESULT_FOLDER'], filename)
        file.save(file_path)
        
        # Save file info to MongoDB
        image_doc = {'filename': filename, 'filepath': file_path}
        image_id = mongo.db.images.insert_one(image_doc).inserted_id
        
        # Perform Google Reverse Image Search using SerpAPI
        search_url = "https://serpapi.com/search"
        params = {
            "engine": "google_reverse_image",
            "image_url": request.host_url + url_for('uploaded_file', filename=filename),
            "api_key": API_KEY
        }
        
        response = requests.get(search_url, params=params)
        result = response.json()
        
        app.logger.info(f"Search result: {result}")
        
        # Update the specific document with the search result
        mongo.db.images.update_one(
            {'_id': image_id},
            {'$set': {'search_result': result}}
        )
        
        return 'File successfully uploaded and image search performed'

@app.route('/uploads/<filename>')
def uploaded_file(filename):
    return send_from_directory(app.config['RESULT_FOLDER'], filename)

if __name__ == '__main__':
    app.run(debug=True)

