# BPC Hack API Documentation 📚

View the API documentation locally using any of these methods:

## 🚀 Quick Start

### Method 1: HTML File (Simplest)
Just open `docs.html` in your web browser!

```bash
# Open in default browser
open docs.html      # macOS
xdg-open docs.html  # Linux
start docs.html     # Windows
```

### Method 2: Auto-Detect Script
```bash
./view-docs.sh
```
This script automatically detects available tools and starts the best viewer.

### Method 3: Node.js/Redoc (Recommended)
```bash
# Install dependencies
npm install

# Start live documentation server
npm run docs

# Or build static HTML
npm run docs:build
```

### Method 4: Go Server
```bash
# Build and run
go run docs.go

# Or specify port
go run docs.go 3000
```

### Method 5: Python Server
```bash
# Serve the YAML file directly
cd api && python3 -m http.server 8000
# Open: http://localhost:8000/open_api.yaml
```

### Method 6: Docker (Swagger UI)
```bash
docker run -p 8080:8080 \
  -v $(pwd)/api/open_api.yaml:/tmp/openapi.yaml \
  -e SWAGGER_JSON=/tmp/openapi.yaml \
  swaggerapi/swagger-ui
```

## 📋 Available Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/epoch` | Server timestamp |
| GET | `/api/ip` | Client IP address |
| POST | `/api/v1/start-hack` | Start BPC hack process |
| POST | `/api/v1/submit-card` | Submit card information |
| POST | `/api/v1/resend-code` | Resend SMS verification code |
| POST | `/api/v1/confirm-payment` | Confirm payment with OTP |

## 📄 Raw Files

- **OpenAPI Spec**: `api/open_api.yaml`
- **HTML Viewer**: `docs.html`
- **Package Config**: `package.json`

## 🛠️ Development

The documentation is generated from `api/open_api.yaml` using the OpenAPI 3.0.1 specification.

All viewers provide:
- Interactive endpoint testing
- Request/response examples
- Schema validation
- Parameter descriptions

Choose the method that works best with your setup! 🎯