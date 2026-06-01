# Solucimob (Real Estate Solution Orchestrator)

A high-performance microservices environment designed for the real estate market. This repository acts as the central Docker-Compose orchestrator that coordinates, configures, and routes traffic between multiple backend services.

## 🛠️ Microservices Architecture

---

## 📚 Documentation & Specifications

This project follows **Specification-Driven Development**. Start here:

- **[SPEC.md](SPEC.md)** - Technical specification and architecture
- **[.instructions.md](.instructions.md)** - Development guidelines and patterns
- **[.agent.md](.agent.md)** - AI agent configuration (Claude, Cursor, etc.)

**Quick Links**:
- Architecture: [See SPEC.md](SPEC.md#3-architecture) or [See SPEC.md](SPEC.md#architecture)
- Development Workflow: [See .instructions.md](.instructions.md)
- AI Usage: [See .agent.md](.agent.md)

---


The system consists of the following microservices:

| Service | Path / Codebase | Description | Dependencies |
| :--- | :--- | :--- | :--- |
| **Calculation Service** | `solucimob-calc` | Executes business logic, real estate evaluations, and metrics calculations. | Config Service |
| **Configuration Service** | `solucimob-config` | Manages global tenant configurations, rules, and parameters. | None |

## 🚀 Environment Setup

### Prerequisites

- [Docker](https://www.docker.com/) & [Docker-Compose](https://docs.docker.com/compose/)
- [Node.js 18+](https://nodejs.org/)

### Local Execution (Docker Orchestration)

To spin up the entire cluster (MongoDB Atlas, Nginx Gateway, Calculation Service, Configuration Service):

```bash
docker-compose up
```

The gateway routes internal traffic through standard ports, exposing the Nginx load balancer locally at `http://localhost:8080`.

---

## 🔒 Security Best Practices

> [!WARNING]
> Hardcoded MongoDB connection strings inside `docker-compose.yml` should be removed and migrated to `.env` variables to prevent security vulnerabilities. Always use the `.env.example` file to coordinate local keys without committing them to the Git history.
