# Solucimob - Technical Specification

> Orchestration layer for the Solução Imobiliária microservices suite.
> Nginx reverse proxy + Docker Compose + frontend shell composing solucimob-config and solucimob-calc.

## Executive Summary

Solucimob is the **top-level orchestration project** for the "Solução Imobiliária" real estate platform. It contains the **Docker Compose** definition that starts all microservices together, an **Nginx reverse proxy** configuration that routes requests to the correct services, and a lightweight **frontend shell** that ties together the calc and config UI. It is the entry point for running the full suite locally.

---

## 1. Problem Statement

### Context
The "Solução Imobiliária" suite consists of two microservices (`solucimob-config` on port 3000, `solucimob-calc` on port 3001) and a frontend. This project provides the glue to run them all together behind a single Nginx gateway.

### Goals
- Single `docker-compose up` to start the entire suite
- Nginx proxies `/config` to `solucimob-config` and `/calc` to `solucimob-calc`
- Serve the frontend static files
- Centralize configuration for the suite

---

## 2. Technology Stack

| Component | Technology |
|-----------|-----------|
| Proxy | Nginx |
| Orchestration | Docker Compose |
| Frontend | Node.js (package.json) |
| Config | solucimob-config microservice |
| Calculator | solucimob-calc microservice |

---

## 3. Architecture

```
Client Browser
      │
      ▼
Nginx (default.conf)
  ├── /config → solucimob-config:3000
  ├── /calc   → solucimob-calc:3001
  └── /       → frontend static files
      │
      ▼
Docker Compose (docker-compose.yml)
  ├── solucimob (nginx + frontend)
  ├── solucimob-config (port 3000)
  └── solucimob-calc (port 3001)
```

---

## 4. Module Structure

```
docker-compose.yml       # Orchestrates all services
default.conf             # Nginx reverse proxy config
config/                  # solucimob-config source (or reference)
calc/                    # solucimob-calc source (or reference)
package.json             # Frontend shell dependencies
```

---

## 5. API Routing (Nginx)

```nginx
GET /config    → proxy_pass to solucimob-config:3000
POST /calc     → proxy_pass to solucimob-calc:3001
```

---

## 6. Deployment & Operations

```bash
docker-compose up    # Start the full suite
```

---

## 7. Issues Found

### Architecture
- **`config/` and `calc/` directories** — unclear if these are copies of the sibling services or just references. If they are copies, changes in `solucimob-config` or `solucimob-calc` must be manually synced here — a maintenance hazard. Should use git submodules or Docker image references instead.
- **No health checks in `docker-compose.yml`** — services start in parallel without waiting for dependencies (e.g., calc service tries to call config service before config is ready). Should use `depends_on` with health checks.
- **No HTTPS configuration** — Nginx serves HTTP only. Production use requires TLS termination.
