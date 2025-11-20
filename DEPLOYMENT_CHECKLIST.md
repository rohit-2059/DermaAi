# 🚀 Heroku Deployment Checklist

## ✅ Pre-Deployment Checklist

### Local Setup
- [x] Python 3.10 installed
- [x] All dependencies in `requirements.txt`
- [x] Procfile created
- [x] runtime.txt created
- [x] .gitignore configured
- [x] Environment variables in `.env` (not committed)
- [x] Code updated to use relative URLs
- [x] App tested locally

### Accounts & Services
- [ ] Heroku account created
- [ ] Heroku CLI installed
- [ ] Git installed and configured
- [ ] MongoDB Atlas account created
- [ ] MongoDB Atlas cluster created
- [ ] MongoDB Atlas database user created
- [ ] MongoDB Atlas network access configured
- [ ] Twilio account set up
- [ ] Twilio phone number verified

### Project Files Required
- [x] `Procfile` - Contains: `web: gunicorn app:app`
- [x] `runtime.txt` - Contains: `python-3.10.14`
- [x] `requirements.txt` - Updated with gunicorn
- [x] `.gitignore` - Excludes .env and sensitive files
- [x] `.env.example` - Template for environment variables
- [x] `HEROKU_DEPLOYMENT.md` - Deployment instructions
- [x] `deploy_heroku.ps1` - Deployment helper script

---

## 📋 Deployment Steps

### Step 1: Install Heroku CLI ✓
```bash
# Verify installation
heroku --version
```

### Step 2: Login to Heroku
```bash
heroku login
```

### Step 3: Navigate to Project
```bash
cd C:\Users\rohit\Downloads\final_Derma\Skin_Disease_Detection\Skin_Disease_Detection
```

### Step 4: Initialize Git (if needed)
```bash
git status
# If not initialized:
git init
git add .
git commit -m "Initial commit for Heroku deployment"
```

### Step 5: Create Heroku App
```bash
# Option 1: With custom name
heroku create your-dermasense-app

# Option 2: Random name
heroku create
```

### Step 6: Set Environment Variables
```bash
# MongoDB
heroku config:set MONGO_URI="mongodb+srv://username:password@cluster.mongodb.net/contactDB"

# Twilio
heroku config:set TWILIO_SID=your_account_sid
heroku config:set TWILIO_AUTH_TOKEN=your_auth_token
heroku config:set TWILIO_PHONE_NUMBER=+1234567890
heroku config:set YOUR_PHONE_NUMBER=+919876543210

# Verify
heroku config
```

### Step 7: Deploy to Heroku
```bash
git push heroku main
# or
git push heroku master
```

### Step 8: Scale Dynos
```bash
heroku ps:scale web=1
```

### Step 9: Open App
```bash
heroku open
```

### Step 10: Monitor Logs
```bash
heroku logs --tail
```

---

## 🔍 Post-Deployment Verification

### Functionality Tests
- [ ] App loads successfully at Heroku URL
- [ ] Home page displays correctly
- [ ] Image upload works
- [ ] Disease prediction returns results
- [ ] Prediction results are accurate
- [ ] SMS notification sends successfully
- [ ] Location search page loads
- [ ] Google Maps displays correctly
- [ ] Dermatologist search works
- [ ] Contact form loads
- [ ] Contact form submission works
- [ ] Data saves to MongoDB
- [ ] Mobile view is responsive
- [ ] All navigation links work
- [ ] Static files (CSS, images) load
- [ ] No console errors in browser

### Technical Checks
- [ ] `heroku ps` shows web dyno running
- [ ] `heroku logs` shows no errors
- [ ] `heroku config` shows all environment variables
- [ ] MongoDB connection successful
- [ ] Twilio integration working
- [ ] Response time is acceptable
- [ ] Memory usage within limits

---

## 🐛 Common Issues & Solutions

### Issue: H10 Error (App Crashed)
**Solution:**
```bash
heroku logs --tail
heroku ps
heroku restart
```

### Issue: Module Not Found
**Solution:**
```bash
# Update requirements.txt
pip freeze > requirements.txt
git add requirements.txt
git commit -m "Update requirements"
git push heroku main
```

### Issue: MongoDB Connection Failed
**Solution:**
- Check MONGO_URI is set: `heroku config:get MONGO_URI`
- Verify MongoDB Atlas network access (0.0.0.0/0)
- Check database user credentials
- Test connection string locally

### Issue: Static Files Not Loading
**Solution:**
- Ensure `static/` folder is committed
- Check file paths are relative
- Verify files exist in Git: `git ls-files static/`

### Issue: Twilio SMS Not Working
**Solution:**
- Verify Twilio credentials: `heroku config | grep TWILIO`
- Check phone numbers are verified
- Test locally first
- Check Twilio console for errors

### Issue: Procfile Error
**Solution:**
- Verify Procfile content: `web: gunicorn app:app`
- No file extension (.txt)
- Correct capitalization

### Issue: Python Version Mismatch
**Solution:**
- Check runtime.txt: `python-3.10.14`
- Use supported version
- Redeploy after fixing

---

## 📊 Monitoring Commands

```bash
# View app info
heroku info

# Check dyno status
heroku ps

# View logs
heroku logs --tail

# View recent logs
heroku logs --num=500

# View config
heroku config

# Restart app
heroku restart

# Open in browser
heroku open

# Run Python shell
heroku run python

# Check buildpacks
heroku buildpacks
```

---

## 💰 Cost Management

### Free Tier (Eco Dynos)
- Cost: $5/month for 1000 hours
- Sleeps after 30 minutes inactivity
- Good for testing

### Upgrade to Basic ($7/month)
```bash
heroku ps:scale web=1:basic
```

### Check Usage
- Dashboard: https://dashboard.heroku.com/
- Billing: https://dashboard.heroku.com/account/billing

---

## 🔒 Security Checklist

- [ ] `.env` file in `.gitignore`
- [ ] No credentials in code
- [ ] All secrets in environment variables
- [ ] HTTPS enabled (automatic on Heroku)
- [ ] CORS configured properly
- [ ] MongoDB network access restricted
- [ ] Strong database passwords
- [ ] Twilio credentials secure

---

## 🔄 Update Workflow

When making changes:

```bash
# 1. Make changes locally
# 2. Test locally
python app.py

# 3. Commit changes
git add .
git commit -m "Your change description"

# 4. Deploy to Heroku
git push heroku main

# 5. Monitor deployment
heroku logs --tail

# 6. Test live app
heroku open
```

---

## 📞 Get Help

### Heroku Support
- Docs: https://devcenter.heroku.com/
- Status: https://status.heroku.com/
- Support: https://help.heroku.com/

### MongoDB Atlas
- Docs: https://docs.atlas.mongodb.com/
- Support: https://support.mongodb.com/

### Twilio
- Docs: https://www.twilio.com/docs
- Console: https://console.twilio.com/

---

## ✅ Final Verification

Before considering deployment complete:

- [ ] App is live and accessible
- [ ] All features working
- [ ] No errors in logs
- [ ] Environment variables set
- [ ] Database connected
- [ ] SMS working
- [ ] Performance acceptable
- [ ] Mobile responsive
- [ ] Custom domain (optional)
- [ ] SSL enabled
- [ ] Monitoring set up
- [ ] Backup strategy planned

---

## 🎉 Success Criteria

✅ App URL: https://your-app-name.herokuapp.com
✅ Status: Running
✅ Features: All working
✅ Errors: None
✅ Performance: Good
✅ Security: Configured

---

**Deployment Date:** _____________
**App URL:** _____________
**Status:** _____________

---

**🎊 Congratulations! Your DermaSense.ai app is live on Heroku!**
