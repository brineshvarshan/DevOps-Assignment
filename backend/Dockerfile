# -------- Stage 1: Build dependencies --------
    FROM python:3.10-slim AS builder

    WORKDIR /app
    
    COPY requirements.txt .
    RUN pip install --no-cache-dir --upgrade pip \
        && pip install --no-cache-dir -r requirements.txt
    
    # -------- Stage 2: Runtime image --------
    FROM python:3.10-slim
    
    WORKDIR /app
    
    # Copy installed Python packages
    COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
    
    # Copy application code
    COPY app ./app
    
    EXPOSE 8000
    
    CMD ["python", "-m", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
    