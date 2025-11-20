# Memory Optimization Guide for DermaSense.ai

## Current Issue: Memory Exhaustion on Render Free Tier

### Problem
The application is experiencing worker timeout and memory exhaustion errors on Render's free tier:
```
[CRITICAL] WORKER TIMEOUT (pid:XXX)
[ERROR] Worker (pid:XXX) was sent SIGKILL! Perhaps out of memory?
```

### Root Cause
- **TensorFlow + MobileNetV2 Model**: Uses ~400-500MB RAM just for model loading
- **Render Free Tier Limit**: Only 512MB RAM available
- **Result**: Not enough memory for model inference, causing worker crashes

## Applied Optimizations

### 1. **Gunicorn Configuration** (render.yaml)
```yaml
--workers 1           # Single worker to minimize memory
--threads 2           # Use threading instead of multiple workers
--timeout 120         # Longer timeout for slow predictions
--max-requests 10     # Restart worker after 10 requests (prevent memory leaks)
--preload             # Load model once before forking
```

### 2. **TensorFlow Memory Optimization** (app.py)
```python
# Limit TensorFlow memory usage
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'
os.environ['TF_FORCE_GPU_ALLOW_GROWTH'] = 'true'
tf.config.threading.set_inter_op_parallelism_threads(1)
tf.config.threading.set_intra_op_parallelism_threads(1)

# Clear memory after each prediction
gc.collect()
tf.keras.backend.clear_session()
```

### 3. **Python Version** (.python-version)
- Using Python 3.11.9 for optimal TensorFlow 2.16 compatibility

## Long-Term Solutions

### Option 1: Upgrade Render Plan (Recommended)
**Render Starter Plan**: $7/month
- **Memory**: 2GB RAM (4x more than free tier)
- **Benefits**: 
  - Stable predictions
  - Faster processing
  - No worker timeouts
  - Better user experience

**How to Upgrade**:
1. Go to [Render Dashboard](https://dashboard.render.com/)
2. Select your `dermasense-ai` service
3. Click "Settings" → "Instance Type"
4. Choose "Starter" plan ($7/month)
5. Click "Save Changes"

### Option 2: Use Smaller Model Architecture
Replace MobileNetV2 with lighter alternatives:
- **MobileNetV3-Small**: ~50% smaller than MobileNetV2
- **EfficientNet-Lite**: Designed for mobile/edge devices
- **Quantized Models**: Reduce model size by 75% with minimal accuracy loss

**Trade-off**: May reduce prediction accuracy by 5-10%

### Option 3: External Model Hosting
Host the model separately on:
- **Hugging Face Inference API**: Free tier available
- **AWS Lambda**: Pay per prediction
- **Google Cloud Run**: Free tier + pay-as-you-go

**Benefits**: Main app uses minimal memory, model runs elsewhere

### Option 4: Model Quantization
Convert model to TensorFlow Lite:
```python
# Reduce model size by ~75%
converter = tf.lite.TFLiteConverter.from_keras_model(model)
converter.optimizations = [tf.lite.Optimize.DEFAULT]
tflite_model = converter.convert()
```

**Benefits**: 
- Model size: 25MB → 6-8MB
- Memory usage: 400MB → 100MB
- Prediction speed: Faster

## Current Status

✅ **Optimizations Applied**:
- Single worker with threading
- Memory cleanup after predictions
- Increased timeouts
- Worker recycling after 10 requests

⚠️ **Expected Behavior**:
- First prediction: May take 30-60 seconds (model loading)
- Subsequent predictions: 5-10 seconds
- Occasional timeouts still possible on free tier
- Worker restarts every 10 predictions

## Monitoring & Debugging

### Check Logs
```bash
# View real-time logs
Visit: https://dashboard.render.com → Your Service → Logs
```

### Look for These Patterns
✅ **Good Signs**:
```
Model loaded successfully!
Prediction complete: Acne (85.23%)
```

❌ **Warning Signs**:
```
WORKER TIMEOUT
Worker was sent SIGKILL
Perhaps out of memory?
```

## Recommendations

### For Development/Testing:
- Current free tier with optimizations should work
- Expect occasional timeouts
- Restart service if it becomes unresponsive

### For Production Use:
- **Upgrade to Starter Plan ($7/month)** - Most reliable
- OR implement model quantization for free tier
- Set up monitoring alerts for worker crashes

## Cost Comparison

| Platform | Tier | RAM | Cost | Stability |
|----------|------|-----|------|-----------|
| Render Free | 512MB | $0 | ⚠️ Unstable |
| Render Starter | 2GB | $7/month | ✅ Stable |
| Heroku Basic | 512MB | $7/month | ⚠️ Similar issues |
| Railway Starter | 8GB | $5/month | ✅ Very stable |
| Fly.io Free | 256MB | $0 | ❌ Worse |

## Conclusion

**Best Solution**: Upgrade to Render Starter ($7/month) for reliable performance.

**Alternative**: If you want to stay on free tier, implement model quantization to reduce memory footprint by 75%.

**Current Setup**: Should work but with occasional timeouts. Good for testing/demo, not production-ready.

---

**Need Help?** Check [Render's Memory Optimization Guide](https://render.com/docs/troubleshooting-memory-issues)
