# 📱 Twilio SMS Setup Guide for DermaSense.ai

## Current Status

✅ **Twilio SDK installed** (version 9.8.5)  
✅ **Environment variable system configured**  
✅ **SMS functionality implemented**  
⚠️ **Twilio credentials need to be configured**

## Quick Setup Steps

### 1. Get Your Twilio Credentials

1. Visit [Twilio Console](https://console.twilio.com/)
2. Sign up for a free account if you don't have one
3. Get your credentials:
   - **Account SID** (starts with 'AC...')
   - **Auth Token** (32-character string)
   - **Twilio Phone Number** (you'll get one for free)

### 2. Configure Environment Variables

Open the `.env` file in your project root and replace the placeholder values:

```env
# Replace these with your actual Twilio credentials
TWILIO_SID=ACxxxxxxxxxxxxxxxxxxxxxxxxxxxx
TWILIO_AUTH_TOKEN=your_32_character_auth_token_here
TWILIO_PHONE_NUMBER=+1234567890  # Your Twilio phone number
YOUR_PHONE_NUMBER=+919876543210   # Your personal phone number
```

### 3. Verify Phone Numbers (Important!)

**For Twilio Trial Accounts:**

- SMS can only be sent to verified phone numbers
- Go to: [Twilio Console > Phone Numbers > Verified Caller IDs](https://console.twilio.com/us1/develop/phone-numbers/manage/verified)
- Click "Add a new number"
- Enter and verify the phone numbers you want to test with

### 4. Test Your Setup

#### Option A: Use the Test Route

1. Start your Flask app: `python app.py`
2. Visit: `http://localhost:5000/test_sms`
3. Enter a verified phone number and test

#### Option B: Manual Test

```python
from dotenv import load_dotenv
import os
from twilio.rest import Client

load_dotenv()
client = Client(os.getenv('TWILIO_SID'), os.getenv('TWILIO_AUTH_TOKEN'))

message = client.messages.create(
    body="Test from DermaSense.ai!",
    from_=os.getenv('TWILIO_PHONE_NUMBER'),
    to='+919876543210'  # Replace with your verified number
)
print(f"Message sent! SID: {message.sid}")
```

## SMS Features in DermaSense.ai

### 1. Disease Analysis Reports

When users upload skin images, they can receive SMS reports containing:

- Detected disease name
- Description of the condition
- Treatment recommendations
- Disclaimer for medical consultation

### 2. Automatic SMS Integration

The `/send_sms` endpoint automatically:

- Formats disease information for SMS
- Validates phone numbers
- Handles errors gracefully
- Provides user feedback

### 3. Error Handling

The system handles common issues:

- **Unverified numbers**: Provides verification instructions
- **Invalid credentials**: Clear error messages
- **SMS failures**: Fallback messages and guidance

## Cost Information

### Free Tier Limits

- **$15.50 in free credit** for new accounts
- **SMS costs**: ~$0.0075 per message
- **Voice calls**: ~$0.0085 per minute
- You can send approximately **2,000 SMS messages** with free credits

### Production Considerations

- Upgrade to a paid account to remove trial restrictions
- Consider implementing rate limiting for SMS sends
- Monitor usage through Twilio Console

## Troubleshooting

### Common Issues

**1. "The number is unverified" error**

- Solution: Verify the number in Twilio Console
- Link: https://console.twilio.com/us1/develop/phone-numbers/manage/verified

**2. "Authentication failed" error**

- Check your Account SID and Auth Token
- Ensure no extra spaces in `.env` file
- Restart your Flask app after updating credentials

**3. SMS not received**

- Check if the phone number is in international format (+country_code)
- Verify the number can receive SMS
- Check Twilio Console logs for delivery status

**4. "Permission denied" errors**

- Ensure your account is active and has sufficient balance
- Check if SMS is supported in the destination country

### Debug Commands

```bash
# Test environment variables
python -c "from dotenv import load_dotenv; import os; load_dotenv(); print(os.getenv('TWILIO_SID'))"

# Test Twilio import
python -c "from twilio.rest import Client; print('Twilio SDK working')"

# Test full SMS functionality
python -c "import app; print('App imports working')"
```

## Security Best Practices

1. **Never commit `.env` file to Git**
2. **Use environment variables in production**
3. **Implement rate limiting** to prevent SMS spam
4. **Validate phone numbers** before sending
5. **Monitor usage** regularly in Twilio Console

## Support Links

- [Twilio Documentation](https://www.twilio.com/docs/sms)
- [Twilio Python SDK](https://www.twilio.com/docs/libraries/python)
- [Twilio Console](https://console.twilio.com/)
- [SMS Best Practices](https://www.twilio.com/docs/sms/best-practices)

---

**Need help?** Check the Twilio Console logs or contact support through their help center.
