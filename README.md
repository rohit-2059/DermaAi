# 🩺 DermaSense.ai - Skin Disease Detection System

An AI-powered web application that detects and classifies skin diseases from uploaded images using deep learning and computer vision.

## 🌟 Features

- **🔍 AI-Powered Detection**: Identifies 24 different skin conditions with confidence scores
- **📱 SMS Notifications**: Sends analysis results via SMS using Twilio integration
- **🖼️ Image Upload**: Supports multiple image formats (PNG, JPG, JPEG, GIF, BMP)
- **📊 Detailed Reports**: Provides disease description, causes, and treatment recommendations
- **📝 Contact System**: Built-in contact form with MongoDB storage
- **🔐 User Authentication**: Separate authentication microservice
- **💻 Web Interface**: Clean, responsive web interface

## 🎯 Supported Skin Conditions

The AI model can detect 24 different skin conditions:

| ID  | Disease            | ID  | Disease               |
| --- | ------------------ | --- | --------------------- |
| 0   | Acne               | 12  | Moles                 |
| 1   | Actinic Keratosis  | 13  | Psoriasis             |
| 2   | Benign Tumors      | 14  | Rosacea               |
| 3   | Bullous            | 15  | Seborrh Keratoses     |
| 4   | Candidiasis        | 16  | Skin Cancer           |
| 5   | Drug Eruption      | 17  | Sunlight Damage       |
| 6   | Eczema             | 18  | Tinea                 |
| 7   | Hives (Urticaria)  | 19  | Unknown or No Disease |
| 8   | Infestations Bites | 20  | Vascular Tumors       |
| 9   | Lichen             | 21  | Vasculitis            |
| 10  | Lupus              | 22  | Vitiligo              |
| 11  | Melanoma           | 23  | Warts                 |

## 🏗️ Architecture

### Core Components

- **Flask Web Application** (`app.py`) - Main application server
- **AI Model** (`model_checkpoint.h5`) - Pre-trained MobileNetV2-based CNN
- **Contact Service** (`contact-us/`) - Node.js microservice for contact forms
- **Auth Service** (`derma-auth/`) - Node.js microservice for user authentication

### Technology Stack

- **Backend**: Python Flask, TensorFlow/Keras
- **Frontend**: HTML, CSS, JavaScript
- **Database**: MongoDB (for contact forms)
- **AI Model**: MobileNetV2 Transfer Learning
- **SMS Service**: Twilio API
- **Image Processing**: PIL/Pillow, OpenCV

## 🚀 Installation & Setup

### Prerequisites

- Python 3.8+
- MongoDB (for contact functionality)
- Node.js (for microservices)
- Twilio Account (for SMS features)

### 1. Clone Repository

```bash
git clone <repository-url>
cd Skin_Disease_Detection
```

### 2. Python Dependencies

```bash
pip install -r requirements.txt
```

### 3. MongoDB Setup

```bash
# Install MongoDB Community Edition
# Start MongoDB service
mongod --dbpath /path/to/your/db
```

### 4. Twilio Configuration

Update Twilio credentials in `app.py`:

```python
TWILIO_SID = "your_account_sid"
TWILIO_AUTH_TOKEN = "your_auth_token"
TWILIO_PHONE_NUMBER = "your_twilio_number"
YOUR_PHONE_NUMBER = "your_verified_number"
```

### 5. Contact Service (Optional)

```bash
cd contact-us
npm install
node index.js
```

### 6. Auth Service (Optional)

```bash
cd derma-auth
npm install
node server.js
```

## 🏃‍♂️ Running the Application

### Start Main Flask App

```bash
python app.py
```

The application will be available at: `http://localhost:5000`

### Available Endpoints

- `/` - Main application interface
- `/predict` - Image upload and prediction API
- `/send_sms` - SMS notification service
- `/contact` - Contact form
- `/location` - Location page
- `/test_sms` - SMS functionality testing

## 📱 Usage

### 1. Image Upload & Analysis

1. Navigate to `http://localhost:5000`
2. Click "Choose File" and select a skin image
3. Click "Analyze Image"
4. View prediction results with confidence score

### 2. SMS Notifications

1. After analysis, enter your phone number
2. Click "Send SMS Report"
3. Receive detailed analysis via SMS

### 3. Contact Form

1. Navigate to `/contact`
2. Fill out the contact form
3. Messages are stored in MongoDB

## 🧠 Model Details

### Architecture

- **Base Model**: MobileNetV2 (pre-trained on ImageNet)
- **Custom Layers**:
  - GlobalAveragePooling2D
  - Dropout (0.3)
  - Dense (1024 units, ReLU)
  - Dense (24 units, Softmax)

### Training Details

- **Input Size**: 224x224x3
- **Optimizer**: Adam (lr=0.0001)
- **Loss Function**: Categorical Crossentropy
- **Data Augmentation**: Rotation, shifts, zoom, horizontal flip

### Model Performance

- **Classes**: 24 skin conditions
- **Architecture**: Transfer Learning with MobileNetV2
- **Inference Time**: ~1-2 seconds per image

## 📁 Project Structure

```
├── app.py                  # Main Flask application
├── model.py               # Model training script
├── model_checkpoint.h5    # Pre-trained model weights
├── requirements.txt       # Python dependencies
├── check_labels.py       # Label verification utility
├── static/               # Static files (CSS, images)
│   ├── style.css
│   ├── images/
│   └── uploads/          # Uploaded images storage
├── templates/            # HTML templates
│   ├── index.html
│   ├── location.html
│   └── test.html
├── contact-us/          # Contact microservice
│   ├── index.js
│   ├── package.json
│   ├── models/
│   └── routes/
└── derma-auth/          # Authentication microservice
    ├── server.js
    ├── package.json
    └── models/
```

## 🔧 Configuration

### Environment Variables

Create `.env` file for sensitive configurations:

```env
MONGO_URI=mongodb://localhost:27017/contactDB
TWILIO_SID=your_sid
TWILIO_AUTH_TOKEN=your_token
TWILIO_PHONE=your_phone
```

### Model Configuration

- Image preprocessing: 224x224 RGB
- Confidence threshold: Display percentage
- Supported formats: PNG, JPG, JPEG, GIF, BMP

## 🚨 Important Notes

### ⚠️ Medical Disclaimer

This application is for **educational and research purposes only**. It should **NOT** be used as a substitute for professional medical diagnosis or treatment. Always consult qualified healthcare professionals for medical concerns.

### 🔒 Privacy & Security

- Images are stored locally in `static/uploads/`
- No personal medical data is permanently stored
- SMS messages contain AI predictions only
- Contact form data is stored in local MongoDB

## 🐛 Troubleshooting

### Common Issues

1. **Model Loading Errors**

```bash
# Check TensorFlow version compatibility
pip install tensorflow==2.12.0
```

2. **MongoDB Connection Issues**

```bash
# Ensure MongoDB is running
sudo systemctl start mongod
```

3. **SMS Not Working**

```bash
# Test SMS functionality
curl -X GET http://localhost:5000/test_sms
```

4. **Image Upload Errors**

- Check file permissions on `static/uploads/`
- Ensure supported file format
- Check file size limits

## 📈 Performance Optimization

### For Better Accuracy

- Use high-quality, well-lit images
- Ensure clear view of affected skin area
- Remove any filters or heavy editing

### For Faster Processing

- Resize large images before upload
- Use JPEG format for faster processing
- Ensure stable internet connection for SMS

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author

**Rohit** - Skin Disease Detection System

## 🙏 Acknowledgments

- TensorFlow team for the ML framework
- MobileNetV2 model architecture
- Twilio for SMS API
- MongoDB for database solutions
- Flask development team

---

### 🔗 Quick Links

- [Model Training Guide](model.py)
- [API Documentation](#available-endpoints)
- [SMS Testing Page](http://localhost:5000/test_sms)
- [Contact Form](http://localhost:5000/contact)

**Remember**: This AI system provides suggestions only. Always consult healthcare professionals for proper medical diagnosis and treatment! 🏥
