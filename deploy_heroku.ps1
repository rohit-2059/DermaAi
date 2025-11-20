# Quick Heroku Deployment Script for DermaSense.ai
# Run this script in PowerShell

Write-Host "🚀 DermaSense.ai - Heroku Deployment Helper" -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Heroku CLI is installed
Write-Host "✓ Checking Heroku CLI installation..." -ForegroundColor Yellow
try {
    $herokuVersion = heroku --version
    Write-Host "✅ Heroku CLI is installed: $herokuVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Heroku CLI is not installed!" -ForegroundColor Red
    Write-Host "Please install from: https://devcenter.heroku.com/articles/heroku-cli" -ForegroundColor Yellow
    exit
}

# Check if logged in to Heroku
Write-Host ""
Write-Host "✓ Checking Heroku login status..." -ForegroundColor Yellow
$herokuAuth = heroku auth:whoami 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Logged in as: $herokuAuth" -ForegroundColor Green
} else {
    Write-Host "⚠️  Not logged in to Heroku" -ForegroundColor Yellow
    Write-Host "Running heroku login..." -ForegroundColor Cyan
    heroku login
}

# Check if Git is initialized
Write-Host ""
Write-Host "✓ Checking Git repository..." -ForegroundColor Yellow
if (Test-Path .git) {
    Write-Host "✅ Git repository initialized" -ForegroundColor Green
} else {
    Write-Host "⚠️  Initializing Git repository..." -ForegroundColor Yellow
    git init
    Write-Host "✅ Git initialized" -ForegroundColor Green
}

# Ask user for app name
Write-Host ""
Write-Host "📝 Enter your Heroku app name (or press Enter for random name):" -ForegroundColor Cyan
$appName = Read-Host "App name"

# Create Heroku app
Write-Host ""
Write-Host "✓ Creating Heroku app..." -ForegroundColor Yellow
if ($appName) {
    heroku create $appName
} else {
    heroku create
}

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Heroku app created successfully!" -ForegroundColor Green
} else {
    Write-Host "❌ Failed to create Heroku app" -ForegroundColor Red
    Write-Host "The app name might already be taken. Try a different name." -ForegroundColor Yellow
    exit
}

# Get the app URL
$appInfo = heroku info --json | ConvertFrom-Json
$appUrl = $appInfo.app.web_url

Write-Host ""
Write-Host "🎉 Your app will be available at: $appUrl" -ForegroundColor Green

# Ask for MongoDB URI
Write-Host ""
Write-Host "🔐 Environment Variables Setup" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "⚠️  IMPORTANT: Set up MongoDB Atlas first!" -ForegroundColor Yellow
Write-Host "Visit: https://www.mongodb.com/cloud/atlas" -ForegroundColor Cyan
Write-Host ""
Write-Host "Do you want to set environment variables now? (Y/N)" -ForegroundColor Yellow
$setEnv = Read-Host

if ($setEnv -eq "Y" -or $setEnv -eq "y") {
    Write-Host ""
    Write-Host "Enter your MongoDB Atlas URI:" -ForegroundColor Cyan
    $mongoUri = Read-Host "MONGO_URI"
    
    Write-Host "Enter your Twilio Account SID:" -ForegroundColor Cyan
    $twilioSid = Read-Host "TWILIO_SID"
    
    Write-Host "Enter your Twilio Auth Token:" -ForegroundColor Cyan
    $twilioToken = Read-Host "TWILIO_AUTH_TOKEN"
    
    Write-Host "Enter your Twilio Phone Number (e.g., +1234567890):" -ForegroundColor Cyan
    $twilioPhone = Read-Host "TWILIO_PHONE_NUMBER"
    
    Write-Host "Enter your personal phone number (e.g., +919876543210):" -ForegroundColor Cyan
    $yourPhone = Read-Host "YOUR_PHONE_NUMBER"
    
    # Set environment variables
    Write-Host ""
    Write-Host "✓ Setting environment variables..." -ForegroundColor Yellow
    heroku config:set MONGO_URI="$mongoUri"
    heroku config:set TWILIO_SID="$twilioSid"
    heroku config:set TWILIO_AUTH_TOKEN="$twilioToken"
    heroku config:set TWILIO_PHONE_NUMBER="$twilioPhone"
    heroku config:set YOUR_PHONE_NUMBER="$yourPhone"
    
    Write-Host "✅ Environment variables set!" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "⚠️  Remember to set environment variables later using:" -ForegroundColor Yellow
    Write-Host "heroku config:set KEY=VALUE" -ForegroundColor Cyan
}

# Check if remote is added
Write-Host ""
Write-Host "✓ Checking Git remote..." -ForegroundColor Yellow
$remotes = git remote -v
if ($remotes -match "heroku") {
    Write-Host "✅ Heroku remote configured" -ForegroundColor Green
} else {
    Write-Host "❌ Heroku remote not found" -ForegroundColor Red
}

# Stage files
Write-Host ""
Write-Host "✓ Staging files for deployment..." -ForegroundColor Yellow
git add .

# Commit
Write-Host ""
Write-Host "Enter commit message (or press Enter for default):" -ForegroundColor Cyan
$commitMsg = Read-Host "Commit message"
if (-not $commitMsg) {
    $commitMsg = "Deploy DermaSense.ai to Heroku"
}

git commit -m "$commitMsg"

# Ask to deploy
Write-Host ""
Write-Host "🚀 Ready to deploy to Heroku!" -ForegroundColor Cyan
Write-Host "Do you want to deploy now? (Y/N)" -ForegroundColor Yellow
$deploy = Read-Host

if ($deploy -eq "Y" -or $deploy -eq "y") {
    Write-Host ""
    Write-Host "✓ Deploying to Heroku..." -ForegroundColor Yellow
    Write-Host "This may take several minutes..." -ForegroundColor Cyan
    
    git push heroku main
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "🎉 Deployment successful!" -ForegroundColor Green
        Write-Host "Your app is live at: $appUrl" -ForegroundColor Cyan
        
        # Scale dynos
        Write-Host ""
        Write-Host "✓ Scaling web dyno..." -ForegroundColor Yellow
        heroku ps:scale web=1
        
        # Open app
        Write-Host ""
        Write-Host "Opening your app in browser..." -ForegroundColor Cyan
        heroku open
        
        # Show logs
        Write-Host ""
        Write-Host "📊 Viewing app logs (Press Ctrl+C to exit)..." -ForegroundColor Yellow
        heroku logs --tail
    } else {
        Write-Host ""
        Write-Host "❌ Deployment failed!" -ForegroundColor Red
        Write-Host "Check the error messages above." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Common issues:" -ForegroundColor Cyan
        Write-Host "1. Make sure all dependencies are in requirements.txt" -ForegroundColor White
        Write-Host "2. Check that Procfile is correct" -ForegroundColor White
        Write-Host "3. Verify environment variables are set" -ForegroundColor White
        Write-Host ""
        Write-Host "View logs with: heroku logs --tail" -ForegroundColor Yellow
    }
} else {
    Write-Host ""
    Write-Host "📝 Deploy later with:" -ForegroundColor Yellow
    Write-Host "git push heroku main" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "✅ Setup complete! Check HEROKU_DEPLOYMENT.md for detailed instructions." -ForegroundColor Green
Write-Host ""
