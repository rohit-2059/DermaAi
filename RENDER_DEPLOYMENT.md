# 🚀 Render.com Deployment Guide for DermaSense.ai

## Why Render?
- ✅ **Easier than Heroku** - No CLI needed
- ✅ **Free tier available** - 750 hours/month
- ✅ **Auto-deploy from GitHub** - Push code and it deploys
- ✅ **Simple dashboard** - Everything in web interface
- ✅ **Great for Flask apps** - Native Python support

---

## 📋 Step-by-Step Deployment

### Step 1: Create Render Account
1. Go to https://render.com/
2. Click "Get Started for Free"
3. Sign up with GitHub (recommended) or email

---

### Step 2: Connect GitHub Repository
1. After login, click "New +" → "Web Service"
2. Click "Connect GitHub account" (if not connected)
3. Grant Render access to your repositories
4. Select your repository: **AiDermasense** or **DermaAi**
5. Click "Connect"

---

### Step 3: Configure Your Web Service

Fill in these details:

#### Basic Info:
- **Name**: `dermasense-ai` (or any name you prefer)
- **Region**: Choose closest to your location
- **Branch**: `main`
- **Root Directory**: Leave empty (or put folder path if needed)

#### Build Settings:
- **Runtime**: `Python 3`
- **Build Command**: 
  ```
  pip install -r requirements.txt
  ```
- **Start Command**:
  ```
  gunicorn app:app
  ```

#### Plan:
- Select **Free** (0$/month)

---

### Step 4: Add Environment Variables

Click "Advanced" and add these environment variables:

| Key | Value | Notes |
|-----|-------|-------|
| `PYTHON_VERSION` | `3.10.14` | Python version |
| `TWILIO_SID` | `your_twilio_sid` | From .env file |
| `TWILIO_AUTH_TOKEN` | `your_twilio_token` | From .env file |
| `TWILIO_PHONE_NUMBER` | `+1234567890` | Your Twilio number |
| `YOUR_PHONE_NUMBER` | `+919876543210` | Your phone |
| `MONGO_URI` | `mongodb+srv://...` | MongoDB connection (add later) |

**Note**: Leave MONGO_URI empty for now if you don't have MongoDB Atlas set up yet.

---

### Step 5: Deploy!

1. Click "Create Web Service"
2. Render will:
   - Clone your repository
   - Install dependencies
   - Build your app
   - Deploy it
3. Wait 3-5 minutes for first deployment
4. Watch the logs in real-time

---

### Step 6: Access Your App

Once deployed:
- Your app URL: `https://dermasense-ai.onrender.com`
- Click the URL to open your app
- Test all features

---

## 🔄 Auto-Deploy (Best Feature!)

Every time you push to GitHub `main` branch:
- Render automatically detects changes
- Rebuilds your app
- Deploys new version

**No manual deployment needed!**

```bash
git add .
git commit -m "Update app"
git push origin main
# Render auto-deploys! 🎉
```

---

## 📊 Monitor Your App

### View Logs:
1. Go to Render Dashboard
2. Click your service
3. Click "Logs" tab
4. Real-time logs appear

### Check Status:
- **Live**: Green dot - App is running
- **Building**: Yellow - App is deploying
- **Failed**: Red - Check logs

---

## 🐛 Troubleshooting

### Issue: Build Failed
**Solution:**
- Check logs for error message
- Verify `requirements.txt` is correct
- Ensure Python version matches

### Issue: App Crashes
**Solution:**
```bash
# Check start command is correct:
gunicorn app:app

# Verify environment variables are set
```

### Issue: Static Files Not Loading
**Solution:**
- Render serves static files automatically
- Make sure `static/` folder is in Git
- Check file paths are relative

### Issue: Model File Too Large
**Solution:**
- Render free tier has 512MB limit
- Your model (25MB) is fine
- If issues, use Git LFS

---

## 💰 Render Free Tier Limits

- **750 hours/month** free
- **512 MB RAM**
- **Spins down after 15 min inactivity**
- **Cold start** ~30 seconds to wake up
- **Great for testing and low traffic**

### Upgrade Options:
- **Starter**: $7/month (no sleep, 512MB RAM)
- **Standard**: $25/month (no sleep, 2GB RAM)

---

## 🔒 Security Best Practices

✅ Environment variables stored securely on Render
✅ HTTPS enabled automatically (free SSL)
✅ Never commit `.env` file to Git
✅ Use environment variables for all secrets

---

## 🎯 Quick Setup Checklist

- [ ] Render account created
- [ ] GitHub repository connected
- [ ] Web service configured
- [ ] Environment variables set
- [ ] App deployed successfully
- [ ] App URL works
- [ ] Features tested
- [ ] Logs checked (no errors)

---

## 📱 MongoDB Atlas Setup (Optional - Add Later)

If you want to add MongoDB:

1. Create MongoDB Atlas account: https://cloud.mongodb.com/
2. Create free cluster (M0)
3. Get connection string
4. Add to Render environment variables:
   ```
   MONGO_URI=mongodb+srv://username:password@cluster.mongodb.net/contactDB
   ```
5. Redeploy (Render will auto-detect env var change)

---

## 🔄 Update Your App

### Method 1: Push to GitHub (Auto-Deploy)
```bash
git add .
git commit -m "Your changes"
git push origin main
# Render automatically deploys!
```

### Method 2: Manual Deploy
1. Go to Render Dashboard
2. Click "Manual Deploy" → "Clear build cache & deploy"

---

## 🎉 Success!

Your app is now live at:
```
https://your-app-name.onrender.com
```

**Share your app with the world! 🌍**

---

## 📞 Support

- Render Docs: https://render.com/docs
- Render Community: https://community.render.com/
- Status: https://status.render.com/

---

## 🎊 Advantages Over Heroku

| Feature | Render | Heroku |
|---------|--------|--------|
| **Free Tier** | ✅ 750 hrs/month | ❌ No free tier |
| **Auto-Deploy** | ✅ From GitHub | ⚠️ Manual push |
| **Easy Setup** | ✅ Web dashboard | ⚠️ CLI required |
| **SSL/HTTPS** | ✅ Free | ✅ Free |
| **Cold Starts** | ⚠️ ~30 sec | ⚠️ ~15 sec |
| **Dashboard** | ✅ Modern | ⚠️ Old UI |

---

**Made with ❤️ for DermaSense.ai - Now on Render!**
