# Improvement Guide - Solucimob Orchestrator

An exceptional **Docker-Compose orchestrator** coordinating a multi-service real estate platform: Nginx proxying traffic to separate calculation and configuration services.

## 🛠️ Audit Status & Recommendations

- **Category**: Keep & Secure (Microservices Orchestration Showcase)
- **Documentation**: Standard. Replaced the legacy Portuguese documentation with standard English explanations.
- **Code Comments**: Exceptional. Completely clean Nginx config.
- **Makefile**: Created a standard `Makefile` wrapping build, clean, up, and submodule commands.
- **GitOps Pipeline**: Created `.github/workflows/ci.yml` validating compose syntax on push.
- **Git Config**: Local git configs set successfully (Leonardo de Freitas Oliveira, email, GPG signatures).
- **Ignored Files**: **CRITICAL ISSUE FOUND**. Active, live MongoDB Atlas cluster credentials are leaked inside the compose environment definitions!

---

## 🚀 Standout Improvements & Features

### 1. ⚠️ CRITICAL: Remove Exposed MongoDB Credentials
- **Issue**: `docker-compose.yml` leaks a live database connection string:
  `mongodb+srv://admin:admin31admin23@solucimobdev.a5bhg.mongodb.net/...`
- **Why**: Exposing raw database passwords in the version control history is a major security vulnerability.
- **Action**:
  - Replace the environment values with variables in `docker-compose.yml`:
    ```yaml
    environment:
      - DB=${DATABASE_URL}
    ```
  - Create a `.env` file containing the connection string locally, and make sure it is added to `.gitignore`.
  - Rotate the database credentials for that Atlas user immediately.

### 2. Standardize Nginx Path Routing
- **Why**: Currently, `default.conf` exposes raw ports or simple proxies. Decoupling services behind a unified path prefix is a best practice.
- **Action**:
  - Update `default.conf` to serve calculation routes under `/api/v1/calc` and configuration under `/api/v1/config`.
  - This allows client applications (mobile/web) to target a single port (`8080`) without needing to know which service handles the request.

### 3. Establish Git Submodule Integrity
- **Why**: The project references `calc` and `config` as submodules inside `.gitmodules`, but they remain empty directories locally because the codebases were cloned separately at `/home/leo-def/projects/lab/solucimob-calc` and `/home/leo-def/projects/lab/solucimob-config`.
- **Action**: Update the submodule paths or detail in the README how to run `git submodule update --init --recursive` to ensure that cloning this repository automatically sets up the entire workspace cleanly.
