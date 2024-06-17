The connection to the MongoDB database is established using the `flask_pymongo` package, which simplifies MongoDB interactions in a Flask application. Here's a detailed explanation of how the connection is configured and utilized in the provided code:

### Flask Application Configuration

1. **Install Dependencies**:
    Ensure you have installed `flask`, `pymongo`, and `flask_pymongo`:
    ```bash
    pip install flask pymongo flask_pymongo
    ```

2. **App Initialization**:
    - `UPLOAD_FOLDER`: Specifies the directory where uploaded files will be saved.
    - `ALLOWED_EXTENSIONS`: Defines the file extensions that are allowed for upload.
    - `MONGO_URI`: The URI for connecting to the MongoDB database. In this case, it connects to a MongoDB instance running on `localhost` at port `27017` and uses the `image_uploads` database.

3. **MongoDB Configuration**:
    The `PyMongo` extension is used to integrate MongoDB with the Flask application. The `mongo` object is an instance of `PyMongo`, initialized with the Flask app.

Here is the complete code for the Flask backend, including the connection to the MongoDB database and the template for listing uploaded images:

### Complete Flask Application

#### `app.py`
```python
import os
from flask import Flask, request, redirect, url_for, render_template, send_from_directory
from werkzeug.utils import secure_filename
from flask_pymongo import PyMongo

app = Flask(__name__, template_folder='templates')

# Configure the upload folder and allowed extensions
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
        
        return 'File successfully uploaded'

@app.route('/uploads/<filename>')
def uploaded_file(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'], filename)

if __name__ == '__main__':
    app.run(debug=True)
```

### HTML Template

#### `templates/index.html`
```html
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Uploaded Images</title>
</head>
<body>
    <h1>Uploaded Images</h1>
    <ul>
        {% for image in images %}
            <li>
                <img src="{{ url_for('uploaded_file', filename=image.filename) }}" alt="{{ image.filename }}" style="width: 200px; height: auto;">
                <p>{{ image.filename }}</p>
            </li>
        {% endfor %}
    </ul>
</body>
</html>
```

### Explanation

- **Configuration**:
    - `UPLOAD_FOLDER`: Directory where uploaded files will be stored.
    - `ALLOWED_EXTENSIONS`: Set of allowed file extensions.
    - `MONGO_URI`: URI for connecting to the MongoDB instance. Here, it connects to a MongoDB database named `image_uploads` running on `localhost` at port `27017`.

- **Upload Route** (`/upload`):
    - Checks if the request contains a file.
    - Validates the file extension.
    - Saves the file to the `uploads/` directory.
    - Inserts a document into the MongoDB `images` collection with the filename and filepath.

- **Index Route** (`/`):
    - Retrieves all image documents from the MongoDB `images` collection.
    - Renders the `index.html` template, passing the list of images to be displayed.

- **Serving Uploaded Files** (`/uploads/<filename>`):
    - Serves the uploaded files from the `uploads/` directory so they can be displayed on the `index.html` page.

By following these steps and using the provided code, you can create a Flask backend that handles image uploads, saves them to a specified folder, stores metadata in a MongoDB database, and displays the uploaded images on a webpage.