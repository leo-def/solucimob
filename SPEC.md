# Solucimob - Technical Specification

> Technical specification for the Real Estate Microservices Orchestrator.
> Reference for understanding Docker Compose architecture and microservice coordination.

## Executive Summary

- **Project**: Solucimob (Real Estate Solution Orchestrator)
- **Type**: Docker Compose Orchestrator / Microservices Coordinator
- **Language**: Docker Compose YAML + Node.js services
- **Status**: Active Development
- **Owner**: Development team

---

## 1. Problem Statement

### Context
Solucimob is the central orchestrator for a real estate microservices ecosystem. It coordinates multiple backend services (Calculation, Configuration) with infrastructure (Nginx gateway, MongoDB Atlas) using Docker Compose for local development and deployment.

### Goals
- **Primary**: Orchestrate microservices and infrastructure as single deployable unit
- **Secondary**: Manage service dependencies and communication
- **Tertiary**: Provide development/staging/production configurations

### Success Metrics
- [x] Coordinates multiple services with docker-compose
- [x] Nginx load balancer configuration
- [x] MongoDB Atlas integration
- [x] Environment variable management
- [x] Service health checks
- [ ] Automatic service discovery
- [ ] Rolling deployment support

---

## 2. Technology Stack

| Component | Technology | Version | Rationale |
|-----------|-----------|---------|-----------|
| Orchestration | Docker Compose | 2.0+ | Multi-container coordination |
| Load Balancer | Nginx | Latest | Reverse proxy, routing |
| Services | Node.js | 18.0+ | Backend microservices |
| Database | MongoDB Atlas | Latest | Cloud NoSQL database |
| Container Runtime | Docker | 20.0+ | Container execution |
| Configuration | .env files | - | Environment variable management |

### Key Services Coordinated
- **solucimob-calc**: Calculation microservice (depends on solucimob-config)
- **solucimob-config**: Configuration microservice (no dependencies)
- **nginx**: Load balancer routing to services
- **mongodb**: Database service (Atlas connection)

---

## 3. Architecture

### Microservices Topology

```
┌───────────────────────────────────────────────────────────┐
│          Public Internet / API Clients                    │
└─────────────────────────┬─────────────────────────────────┘
                          │ :8080
                          ▼
┌───────────────────────────────────────────────────────────┐
│    Nginx Load Balancer (Reverse Proxy)                    │
│  - Routes /api/calc → solucimob-calc:3001                │
│  - Routes /api/config → solucimob-config:3002            │
│  - Handles SSL/TLS, compression, rate limiting            │
└───┬────────────────────────────────────────┬──────────────┘
    │                                        │
    ▼                                        ▼
┌─────────────────────┐          ┌──────────────────────────┐
│  Calc Service       │          │  Config Service          │
│  :3001              │          │  :3002                   │
│  (Business Logic)   │◄─────────│  (Tenant Configuration)  │
│                     │          │                          │
└─────────────────────┘          └──────────────────────────┘
           │                              │
           └──────────────┬───────────────┘
                          │
                          ▼
            ┌──────────────────────────────┐
            │   MongoDB Atlas              │
            │   (Cloud Database)           │
            └──────────────────────────────┘
```

### Service Dependencies

```
solucimob-calc
  ↓ depends on
solucimob-config

nginx
  ↓ routes to
solucimob-calc, solucimob-config
```

---

## 4. Docker Compose Structure

### Configuration Layers

```yaml
version: '3.8'

services:
  nginx:
    image: nginx:latest
    ports:
      - "8080:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - calc-service
      - config-service

  config-service:
    build: ./solucimob-config
    environment:
      - DATABASE_URL=${DATABASE_URL}
      - NODE_ENV=${NODE_ENV}
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3002/health"]

  calc-service:
    build: ./solucimob-calc
    environment:
      - DATABASE_URL=${DATABASE_URL}
      - CONFIG_SERVICE_URL=http://config-service:3002
    depends_on:
      - config-service
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3001/health"]
```

---

## 5. Project Structure

```
solucimob/                   (Root orchestrator)
├── docker-compose.yml       # Multi-container config
├── docker-compose.prod.yml  # Production overrides
├── .env.example             # Template (commit to git)
├── .env                     # Actual secrets (DON'T commit)
├── nginx.conf               # Load balancer config
├── README.md
├── solucimob-calc/          # Calculation service (external)
│   └── ...
├── solucimob-config/        # Configuration service (external)
│   └── ...
└── docker/
    ├── postgres/            # Optional postgres config
    └── mongodb/             # Optional MongoDB setup
```

---

## 6. Key Patterns & Decisions

### Environment Management
- `.env.example`: Template with non-sensitive defaults
- `.env`: Actual values (in .gitignore)
- `docker-compose.yml`: Uses `${VAR_NAME}` interpolation

### Service Communication
- Internal: Service-to-service via Docker network (http://service-name:port)
- External: Via Nginx on `localhost:8080`

### Health Checks
- Each service exposes `/health` endpoint
- Docker monitors and can restart unhealthy services
- Orchestrator waits for health before routing traffic

### Volumes
- Config files mounted from host (nginx.conf, app configs)
- Data volumes for persistent state (if needed)

---

## 7. Deployment Scenarios

### Local Development
```bash
docker-compose up --build
# Access at http://localhost:8080
```

### Staging
```bash
docker-compose -f docker-compose.yml -f docker-compose.staging.yml up
```

### Production
```bash
docker-compose -f docker-compose.prod.yml up -d
```

