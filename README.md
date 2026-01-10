# DevOps Assignment

This project consists of a FastAPI backend and a Next.js frontend that communicates with the backend.

## Project Structure

```
.
├── backend/               # FastAPI backend
│   ├── app/
│   │   └── main.py       # Main FastAPI application
│   └── requirements.txt    # Python dependencies
└── frontend/              # Next.js frontend
    ├── pages/
    │   └── index.js     # Main page
    ├── public/            # Static files
    └── package.json       # Node.js dependencies
```

## Prerequisites

- Python 3.8+
- Node.js 16+
- npm or yarn

## Backend Setup

1. Navigate to the backend directory:
   ```bash
   cd backend
   ```

2. Create a virtual environment (recommended):
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: .\venv\Scripts\activate
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Run the FastAPI server:
   ```bash
   uvicorn app.main:app --reload --port 8000
   ```

   The backend will be available at `http://localhost:8000`

## Frontend Setup

1. Navigate to the frontend directory:
   ```bash
   cd frontend
   ```

2. Install dependencies:
   ```bash
   npm install
   # or
   yarn
   ```

3. Configure the backend URL (if different from default):
   - Open `.env.local`
   - Update `NEXT_PUBLIC_API_URL` with your backend URL
   - Example: `NEXT_PUBLIC_API_URL=https://your-backend-url.com`

4. Run the development server:
   ```bash
   npm run dev
   # or
   yarn dev
   ```

   The frontend will be available at `http://localhost:3000`

## Changing the Backend URL

To change the backend URL that the frontend connects to:

1. Open the `.env.local` file in the frontend directory
2. Update the `NEXT_PUBLIC_API_URL` variable with your new backend URL
3. Save the file
4. Restart the Next.js development server for changes to take effect

Example:
```
NEXT_PUBLIC_API_URL=https://your-new-backend-url.com
```

## For deployment:
   ```bash
   npm run build
   # or
   yarn build
   ```

   AND

   ```bash
   npm run start
   # or
   yarn start
   ```

   The frontend will be available at `http://localhost:3000`

## Testing the Integration

1. Ensure both backend and frontend servers are running
2. Open the frontend in your browser (default: http://localhost:3000)
3. If everything is working correctly, you should see:
   - A status message indicating the backend is connected
   - The message from the backend: "You've successfully integrated the backend!"
   - The current backend URL being used

## API Endpoints

- `GET /api/health`: Health check endpoint
  - Returns: `{"status": "healthy", "message": "Backend is running successfully"}`

- `GET /api/message`: Get the integration message
  - Returns: `{"message": "You've successfully integrated the backend!"}`
------------------------------------------------------------------------------------

---

# 🚀 DevOps Assignment — Multi-Cloud Deployment (AWS + GCP)

This repository contains a **two-tier web application** deployed using **DevOps best practices**:
- ✅ **Backend:** FastAPI (Python)
- ✅ **Frontend:** Next.js

The assignment demonstrates **end-to-end DevOps skills**:
✅ Git workflow (develop/main branches + PR flow)  
✅ Docker multi-stage builds  
✅ Automated CI/CD using GitHub Actions  
✅ Infrastructure provisioning using Terraform  
✅ Deployment on managed container platform (**AWS ECS Fargate**)  
✅ Load Balancing + High Availability  
✅ Logging & Monitoring  
✅ IAM Security best practices  

---

## 📌 Architecture Overview

### AWS Architecture (Implemented ✅)
- **ECR**: Stores Docker images (frontend + backend), tagged with **Git SHA**
- **VPC + Subnets (4)**:
  - 2 Public subnets → ALB
  - 2 Private subnets → ECS Tasks
- **NAT Gateway**: private tasks access internet to pull images
- **Security Groups**:
  - ALB SG: public access (80/443)
  - ECS SG: only ALB can access containers
- **ALB (Application Load Balancer)**:
  - `/api/*` routed to backend
  - `/` routed to frontend
- **ECS Fargate Cluster**:
  - backend service (2 tasks minimum)
  - frontend service (2 tasks minimum)
- **CloudWatch Logs**:
  - frontend & backend logs stored

---

## 🌐 Deployment URLs

### ✅ AWS (ECS + ALB)
- **Frontend:**  
  `http://<ALB-DNS-NAME>/`

- **Backend Health Endpoint:**  
  `http://<ALB-DNS-NAME>/api/health`

> ALB DNS will be printed as Terraform output inside `terraform/aws/alb`

---

## 📂 Repository Structure

```

.
├── backend/                     # FastAPI backend
│   ├── app/
│   │   └── main.py
│   ├── tests/                   # Unit tests (pytest)
│   ├── Dockerfile               # Multi-stage backend docker build
│   └── requirements.txt
│
├── frontend/                    # Next.js frontend
│   ├── pages/
│   │   └── index.js
│   ├── Dockerfile               # Multi-stage frontend docker build
│   └── package.json
│
├── terraform/
│   └── aws/
│       ├── ecr/                 # ECR repos (frontend + backend)
│       ├── vpc/                 # Networking (VPC, subnets, NAT, routes)
│       ├── security-groups/     # ALB SG + ECS SG
│       ├── alb/                 # ALB + Listener + Target Groups
│       └── ecs/                 # ECS Cluster + Task Def + Services
│
└── .github/
└── workflows/
└── ci.yml               # CI pipeline

````

---

# ✅ Step 1 — Run Locally (Without Docker)

## Backend
```bash
cd backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

uvicorn app.main:app --reload --port 8000
````

Backend: `http://localhost:8000`

---

## Frontend

```bash
cd frontend
npm install
npm run dev
```

Frontend: `http://localhost:3000`

---

## Local Testing

```bash
curl http://localhost:8000/api/health
curl http://localhost:8000/api/message
```

---

# ✅ Step 2 — Run Locally Using Docker Compose

```bash
docker compose up --build
```

App will run at:

* Frontend: `http://localhost:3000`
* Backend: `http://localhost:8000`

---

# ✅ Step 3 — CI Pipeline (Implemented ✅)

### Trigger

Runs automatically on:
✅ `push` to `develop`

### CI Steps

1. Checkout repo
2. Run backend unit tests (pytest)
3. Run frontend tests
4. Build Docker images
5. Tag Docker images using **Git SHA**
6. Push images to AWS ECR

✅ You can see pipeline runs inside GitHub Actions.

---

# ✅ Step 4 — AWS Infrastructure Provisioning (Terraform ✅)

## AWS Prerequisites

* AWS CLI installed
* IAM user configured:

```bash
aws configure
aws sts get-caller-identity
```

---

## Terraform Apply Order (AWS)

### 1️⃣ Create ECR

```bash
cd terraform/aws/ecr
terraform init
terraform apply
```

---

### 2️⃣ Create VPC & Networking

```bash
cd terraform/aws/vpc
terraform init
terraform apply
```

Outputs:

* vpc_id
* public_subnet_ids
* private_subnet_ids
* nat_gateway_id

---

### 3️⃣ Create Security Groups

```bash
cd terraform/aws/security-groups
terraform init
terraform apply -var="vpc_id=<vpc_id>"
```

Outputs:

* alb_sg_id
* ecs_sg_id

---

### 4️⃣ Create ALB + Target Groups

```bash
cd terraform/aws/alb
terraform init
terraform apply \
  -var="vpc_id=<vpc_id>" \
  -var='public_subnet_ids=["subnet-xxx","subnet-yyy"]' \
  -var="alb_sg_id=<alb_sg_id>"
```

Outputs:

* alb_dns_name
* backend_tg_arn
* frontend_tg_arn

---

### 5️⃣ Deploy ECS (Frontend + Backend)

```bash
cd terraform/aws/ecs
terraform init
terraform apply \
  -var='private_subnet_ids=["subnet-aaa","subnet-bbb"]' \
  -var="ecs_sg_id=<ecs_sg_id>" \
  -var="frontend_ecr_url=<frontend_ecr_url>" \
  -var="backend_ecr_url=<backend_ecr_url>" \
  -var="frontend_tg_arn=<frontend_tg_arn>" \
  -var="backend_tg_arn=<backend_tg_arn>" \
  -var="backend_image_tag=<git_sha>" \
  -var="frontend_image_tag=<git_sha>"
```

---

# ✅ High Availability & Load Balancing

* Each ECS service runs:
  ✅ `desired_count = 2`

* ALB distributes traffic across multiple tasks automatically.

---

# ✅ Logging & Monitoring

* CloudWatch log groups created:

  * `/ecs/devops-assignment-frontend`
  * `/ecs/devops-assignment-backend`

Logs can be viewed in AWS Console:
**CloudWatch → Log Groups**

---

# 🔐 Security Practices

✅ IAM role for ECS Task Execution (pull image + logs)
✅ ECS Tasks run inside private subnets
✅ ALB is public, ECS is private
✅ Security Groups ensure only ALB can hit ECS services

---

# 💸 Cost Management

⚠️ ECS + NAT Gateway + ALB may incur costs.

To avoid charges after testing:

```bash
terraform destroy
```

Destroy order recommended:

1. ECS
2. ALB
3. Security groups
4. VPC
5. ECR

---

# ✅ Deliverables Done So Far

✅ Git workflow followed (develop branch + PR flow)
✅ Docker multi-stage builds
✅ CI Pipeline with Git SHA tagging
✅ Terraform for AWS infra
✅ ECS Fargate deployment with ALB
✅ 2 tasks minimum for resiliency
✅ CloudWatch log groups enabled

---

# 🚧 Remaining (GCP Deployment)

This project will also be deployed on **GCP** (next stage):

* Artifact Registry
* GKE Autopilot or Cloud Run
* Load balancing + monitoring

---

## 👨‍💻 Author

**Brinesh Varshan**
DevOps / Cloud / Security Enthusiast

```

