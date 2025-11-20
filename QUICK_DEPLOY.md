# 🚀 Quick Start - Heroku Deployment in 5 Minutes

## Prerequisites
✅ Heroku account  
✅ Git installed  
✅ MongoDB Atlas account  

---

## 🎯 Super Quick Deployment

### 1️⃣ Install Heroku CLI
```bash
# Windows: Download from https://devcenter.heroku.com/articles/heroku-cli
# Or use the automated script
```

### 2️⃣ Run PowerShell Script (Easiest Way)
```powershell
cd C:\Users\rohit\Downloads\final_Derma\Skin_Disease_Detection\Skin_Disease_Detection
.\deploy_heroku.ps1
```

**The script will:**
- ✅ Check Heroku CLI installation
- ✅ Login to Heroku
- ✅ Initialize Git
- ✅ Create Heroku app
- ✅ Set environment variables
- ✅ Deploy your app
- ✅ Open in browser

---

## 🔧 Manual Deployment (If script doesn't work)

```bash
# 1. Login
heroku login

# 2. Navigate to project
cd C:\Users\rohit\Downloads\final_Derma\Skin_Disease_Detection\Skin_Disease_Detection

# 3. Initialize Git (if needed)
git init
git add .
git commit -m "Deploy to Heroku"

# 4. Create app
heroku create

# 5. Set environment variables (replace with your values)
heroku config:set MONGO_URI="your_mongodb_uri"
heroku config:set TWILIO_SID="your_twilio_sid"
heroku config:set TWILIO_AUTH_TOKEN="your_twilio_token"
heroku config:set TWILIO_PHONE_NUMBER="+1234567890"
heroku config:set YOUR_PHONE_NUMBER="+919876543210"

# 6. Deploy
git push heroku main

# 7. Scale
heroku ps:scale web=1

# 8. Open
heroku open
```

---

## 🗄️ MongoDB Atlas Setup (Required)

### Quick Setup:
1. Go to https://cloud.mongodb.com/
2. Sign up → Create free cluster (M0)
3. Database Access → Add user → Save credentials
4. Network Access → Allow 0.0.0.0/0
5. Database → Connect → Get connection string
6. Copy string and set as MONGO_URI on Heroku

**Connection String Format:**
```
mongodb+srv://username:password@cluster0.xxxxx.mongodb.net/contactDB?retryWrites=true&w=majority
```

---

## ✅ Verify Deployment

### Check Status:
```bash
heroku ps
```

### View Logs:
```bash
heroku logs --tail
```

### Open App:
```bash
heroku open
```

---

## 🐛 Quick Troubleshooting

### App crashed?
```bash
heroku logs --tail
heroku restart
```

### Can't connect to MongoDB?
```bash
heroku config:get MONGO_URI
# Verify the URI is correct
```

### Static files not loading?
```bash
git add static/
git commit -m "Add static files"
git push heroku main
```

---

## 📱 Your App URL

After deployment, your app will be at:
```
https://your-app-name.herokuapp.com
```

---

## 🎉 Done!

That's it! Your DermaSense.ai app is now live on Heroku!

For detailed instructions, see: **HEROKU_DEPLOYMENT.md**

---

**Need Help?**
- Full Guide: See `HEROKU_DEPLOYMENT.md`
- Checklist: See `DEPLOYMENT_CHECKLIST.md`
- Heroku Docs: https://devcenter.heroku.com/
