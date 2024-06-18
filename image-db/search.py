import os
import requests
from flask import Flask, request, redirect, url_for, render_template, send_from_directory
from werkzeug.utils import secure_filename
from flask_pymongo import PyMongo
from dotenv import load_dotenv

app = Flask(__name__, template_folder='templates')

load_dotenv()

# SerpAPI credentials from environment variables
API_KEY = os.getenv('SERP_API_KEY')

# Configure the upload folder and allowed extensions
RESULT_FOLDER='results/'
UPLOAD_FOLDER = 'uploads/'
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# MongoDB configuration
app.config["MONGO_URI"] = "mongodb://localhost:27017/image_uploads"
mongo = PyMongo(app)

# Ensure the upload folder exists
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/')
def index():
    images = mongo.db.images.find()
    return render_template('index.html', images=images)

@app.route('/home')
def home():
    images = list(mongo.db.images.find())
    return render_template('home.html', images=images)


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
        mongo.db.images.insert_one({'filename': filename, 'filepath': file_path})
        
        # Perform Google Reverse Image Search using SerpAPI
        search_url = "https://serpapi.com/search"
        params = {
            "engine": "google_reverse_image",
            "image_url": request.host_url + url_for('uploaded_file', filename=filename),
            "api_key": API_KEY
        }
        
        response = requests.get(search_url, params=params)
        result = response.json()
        
        # Save the search result to MongoDB (optional)
        mongo.db.images.update_one(
            {'filename': filename},
            {'$set': {'search_result': result}}
        )
        
        return 'File successfully uploaded and image search performed'

@app.route('/uploads/<filename>')
def uploaded_file(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'], filename)

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
        image_id = mongo.db.images.insert_one({'filename': filename, 'filepath': file_path}).inserted_id
        
        # Perform Google Reverse Image Search using SerpAPI
        search_url = "https://serpapi.com/search"
        params = {
            "engine": "google_reverse_image",
            "image_url": request.host_url + url_for('uploaded_file', filename=filename),
            "api_key": API_KEY
        }
        
        response = requests.get(search_url, params=params)
        result = response.json()
        
        # Save the search result to MongoDB (optional)
        mongo.db.images.update_one(
            {'_id': image_id},
            {'$set': {'search_result': result}}
        )
        
        return 'File successfully uploaded and image search performed'

if __name__ == '__main__':
    app.run(debug=True)


