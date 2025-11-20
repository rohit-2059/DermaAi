# 🚀 Heroku Deployment Guide for DermaSense.ai

This guide will help you deploy your DermaSense.ai application to Heroku step by step.

---

## 📋 Prerequisites

Before you begin, make sure you have:

- ✅ Heroku account (free or paid)
- ✅ Git installed on your computer
- ✅ Heroku CLI installed
- ✅ MongoDB Atlas account (for database)
- ✅ Twilio account (for SMS functionality)

---

## 🔧 Step 1: Install Heroku CLI

### Windows:
```bash
# Download and install from:
https://devcenter.heroku.com/articles/heroku-cli

# Or use Chocolatey:
choco install heroku-cli
```

### Verify Installation:
```bash
heroku --version
```

---

## 🔐 Step 2: Login to Heroku

```bash
heroku login
```

This will open your browser for authentication.

---

## 📦 Step 3: Prepare Your Project

Your project already has the necessary files:

### ✅ Files Created:
1. **`Procfile`** - Tells Heroku how to run your app
   ```
   web: gunicorn app:app
   ```

2. **`runtime.txt`** - Specifies Python version
   ```
   python-3.10.14
   ```

3. **`requirements.txt`** - Updated with all dependencies including `gunicorn`

4. **`.gitignore`** - Already exists (make sure it includes `.env`)

---

## 🗄️ Step 4: Set Up MongoDB Atlas (Free Database)

### 4.1 Create MongoDB Atlas Account:
1. Go to https://www.mongodb.com/cloud/atlas
2. Sign up for free
3. Create a new cluster (free tier - M0)
4. Wait 5-10 minutes for cluster creation

### 4.2 Configure Database Access:
1. Click "Database Access" → "Add New Database User"
2. Create username and password (save these!)
3. Set permissions to "Read and write to any database"

### 4.3 Configure Network Access:
1. Click "Network Access" → "Add IP Address"
2. Click "Allow Access from Anywhere" (0.0.0.0/0)
3. Confirm

### 4.4 Get Connection String:
1. Click "Database" → "Connect"
2. Choose "Connect your application"
3. Copy the connection string (looks like):
   ```
   mongodb+srv://<username>:<password>@cluster0.xxxxx.mongodb.net/contactDB?retryWrites=true&w=majority
   ```
4. Replace `<username>` and `<password>` with your credentials

---

## 🚀 Step 5: Create Heroku App

```bash
# Navigate to your project directory
cd C:\Users\rohit\Downloads\final_Derma\Skin_Disease_Detection\Skin_Disease_Detection

# Create Heroku app (choose a unique name)
heroku create your-dermasense-app

# Or let Heroku generate a random name:
heroku create
```

This will create your app and add Heroku as a Git remote.

---

## 🔑 Step 6: Set Environment Variables on Heroku

Set all your environment variables (DO NOT include quotes):

```bash
# Twilio Configuration
heroku config:set TWILIO_SID=your_twilio_account_sid
heroku config:set TWILIO_AUTH_TOKEN=your_twilio_auth_token
heroku config:set TWILIO_PHONE_NUMBER=+1234567890
heroku config:set YOUR_PHONE_NUMBER=+919876543210

# MongoDB Configuration
heroku config:set MONGO_URI="mongodb+srv://username:password@cluster0.xxxxx.mongodb.net/contactDB?retryWrites=true&w=majority"

# Google Maps API (if you're using it)
heroku config:set GOOGLE_MAPS_API_KEY=your_google_maps_api_key

# Flask Secret Key (generate a random string)
heroku config:set SECRET_KEY=your_super_secret_random_key_here
```

### To verify environment variables:
```bash
heroku config
```

---

## 📤 Step 7: Initialize Git (if not already done)

```bash
# Check if Git is initialized
git status

# If not initialized, run:
git init

# Add all files
git add .

# Commit changes
git commit -m "Prepare for Heroku deployment"
```

---

## 🚢 Step 8: Deploy to Heroku

```bash
# Push to Heroku
git push heroku main

# If you're on 'master' branch instead of 'main':
git push heroku master
```

### Watch the deployment logs:
```bash
heroku logs --tail
```

---

## 🔍 Step 9: Scale Your App

```bash
# Ensure at least one web dyno is running
heroku ps:scale web=1
```

---

## 🌐 Step 10: Open Your App

```bash
# Open in browser
heroku open

# Or get the URL
heroku info
```

Your app will be live at: `https://your-dermasense-app.herokuapp.com`

---

## ✅ Step 11: Verify Deployment

### Check if app is running:
```bash
heroku ps
```

### View logs:
```bash
heroku logs --tail
```

### Test your app:
1. Visit: `https://your-app-name.herokuapp.com`
2. Test image upload and prediction
3. Test location search
4. Test contact form
5. Test SMS functionality

---

## 🐛 Troubleshooting

### Problem: App crashes on startup
```bash
# Check logs
heroku logs --tail

# Common issues:
# 1. Missing environment variables
# 2. Wrong Python version
# 3. Missing dependencies
```

### Problem: H10 Error (App crashed)
```bash
# Check if dyno is running
heroku ps

# Restart dynos
heroku restart

# Check configuration
heroku config
```

### Problem: ModuleNotFoundError
```bash
# Make sure requirements.txt is complete
# Redeploy:
git add requirements.txt
git commit -m "Update requirements"
git push heroku main
```

### Problem: MongoDB connection issues
```bash
# Verify MONGO_URI is set correctly
heroku config:get MONGO_URI

# Test MongoDB connection from Heroku
heroku run python
>>> import os
>>> from pymongo import MongoClient
>>> client = MongoClient(os.getenv('MONGO_URI'))
>>> print(client.list_database_names())
```

### Problem: Static files not loading
- Heroku serves static files automatically via Flask
- Make sure your `static/` folder is committed to Git
- Check file paths are relative (not absolute)

---

## 🔄 Updating Your App

After making changes locally:

```bash
# Stage changes
git add .

# Commit changes
git commit -m "Your commit message"

# Push to GitHub (optional)
git push origin main

# Deploy to Heroku
git push heroku main
```

---

## 📊 Monitoring Your App

### View app metrics:
```bash
heroku open --app your-app-name
# Then go to "Metrics" tab in Heroku dashboard
```

### View app logs:
```bash
heroku logs --tail
```

### Check dyno usage:
```bash
heroku ps
```

---

## 💰 Heroku Pricing Information

### Free Tier (Eco Dynos - $5/month):
- 1000 dyno hours/month
- Sleeps after 30 minutes of inactivity
- Wakes up when accessed (cold start ~10-30 seconds)
- 512 MB RAM
- Good for testing and low-traffic apps

### Basic Dyno ($7/month):
- Never sleeps
- 512 MB RAM
- Good for small production apps

### Standard Dynos ($25-$50/month):
- Never sleeps
- 1-2 GB RAM
- Better for production with moderate traffic

---

## 🔐 Security Best Practices

### 1. Never commit sensitive data:
```bash
# Make sure .env is in .gitignore
echo ".env" >> .gitignore
```

### 2. Use environment variables for all secrets
- Twilio credentials
- MongoDB URI
- API keys

### 3. Enable HTTPS (Automatic on Heroku)

### 4. Set up CORS properly (already configured in app.py)

---

## 🎯 Post-Deployment Checklist

- [ ] App is accessible via browser
- [ ] Image upload works
- [ ] Disease prediction works
- [ ] SMS notifications work
- [ ] Location search works
- [ ] Contact form works
- [ ] MongoDB is connected
- [ ] All pages load correctly
- [ ] Mobile view works
- [ ] Environment variables are set
- [ ] Logs show no errors
- [ ] Custom domain set up (optional)

---

## 📱 Setting Up Custom Domain (Optional)

### Add domain to Heroku:
```bash
heroku domains:add www.yourdermasense.com
```

### Configure DNS:
1. Go to your domain registrar
2. Add CNAME record:
   - Name: `www`
   - Value: `your-app-name.herokuapp.com`

### Enable SSL (automatic):
```bash
heroku certs:auto:enable
```

---

## 🔄 Database Backups (MongoDB Atlas)

MongoDB Atlas automatically backs up your data.

### Manual backup:
1. Go to MongoDB Atlas Dashboard
2. Click your cluster
3. Click "..." → "Backup"
4. Download backup

---

## 📞 Support Resources

### Heroku Help:
- Documentation: https://devcenter.heroku.com/
- Support: https://help.heroku.com/

### MongoDB Atlas:
- Documentation: https://docs.atlas.mongodb.com/
- Support: https://support.mongodb.com/

### Twilio:
- Documentation: https://www.twilio.com/docs
- Support: https://support.twilio.com/

---

## 🎉 Success!

Your DermaSense.ai app is now live on Heroku! 

**Share your app URL:**
`https://your-app-name.herokuapp.com`

---

## 📝 Quick Command Reference

```bash
# Login to Heroku
heroku login

# Create app
heroku create

# Set environment variable
heroku config:set KEY=VALUE

# View environment variables
heroku config

# Deploy
git push heroku main

# View logs
heroku logs --tail

# Restart app
heroku restart

# Open app in browser
heroku open

# Run commands on Heroku
heroku run python

# Scale dynos
heroku ps:scale web=1

# View app info
heroku info
```

---

**Made with ❤️ for DermaSense.ai**
