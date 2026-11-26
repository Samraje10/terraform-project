#!/bin/bash
# Install Python and pip (handles both Ubuntu and Amazon Linux)
if command -v apt-get &> /dev/null; then
    apt-get update -y
    apt-get install -y python3-pip
else
    yum update -y
    yum install -y python3-pip
fi

# Install FastAPI and Uvicorn globally for quick testing
pip3 install fastapi uvicorn

# Create the FastAPI application with 4 live test endpoints + health check
cat << 'EOF' > /opt/main.py
from fastapi import FastAPI, APIRouter
import socket
import datetime

app = FastAPI()

# --- /app endpoints ---
app_router = APIRouter(prefix="/app")

@app_router.get("/")
def app_home():
    return {
        "route": "/app",
        "message": "App service is live!",
        "instance_hostname": socket.gethostname(),
        "timestamp": datetime.datetime.now(datetime.timezone.utc).isoformat()
    }

@app_router.get("/items/{item_id}")
def get_item(item_id: int, q: str = "default"):
    return {
        "route": "/app/items",
        "item_id": item_id,
        "query_param": q,
        "status": "found"
    }

# --- /admin endpoints ---
admin_router = APIRouter(prefix="/admin")

@admin_router.get("/")
def admin_home():
    return {
        "route": "/admin",
        "message": "Admin portal is live!",
        "instance_hostname": socket.gethostname()
    }

@admin_router.get("/users")
def list_users():
    return {
        "route": "/admin/users",
        "users": [
            {"id": 1, "name": "Alice", "role": "superadmin"},
            {"id": 2, "name": "Bob", "role": "moderator"}
        ]
    }

# --- Load Balancer Health Check ---
@app.get("/health")
def health():
    return {"status": "healthy"}

app.include_router(app_router)
app.include_router(admin_router)
EOF

# Create a systemd service so the app stays running and auto-restarts
cat << 'EOF' > /etc/systemd/system/fastapi-test.service
[Unit]
Description=FastAPI Path Routing Test App
After=network.target

[Service]
User=root
WorkingDirectory=/opt
ExecStart=/usr/bin/python3 -m uvicorn main:app --host 0.0.0.0 --port 8000
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Start and enable the service
systemctl daemon-reload
systemctl enable fastapi-test
systemctl start fastapi-test
