#!/bin/bash

echo "🚀 Starting local API documentation server..."
echo ""
echo "Choose your preferred viewer:"
echo "1. Redoc (recommended - beautiful and fast)"
echo "2. Swagger UI (classic)"
echo "3. Simple text view"
echo ""

if command -v npm &> /dev/null; then
    echo "📦 npm detected - installing and starting Redoc..."
    npm install
    npm run docs
elif command -v python3 &> /dev/null; then
    echo "🐍 Python detected - starting simple HTTP server..."
    echo "Open: http://localhost:8000/api/open_api.yaml"
    cd api && python3 -m http.server 8000
elif command -v docker &> /dev/null; then
    echo "🐳 Docker detected - starting Swagger UI..."
    echo "Open: http://localhost:8080"
    docker run -p 8080:8080 -v $(pwd)/api/open_api.yaml:/tmp/openapi.yaml -e SWAGGER_JSON=/tmp/openapi.yaml swaggerapi/swagger-ui
else
    echo "❌ No supported tools found. Please install one of:"
    echo "  - Node.js/npm (recommended)"
    echo "  - Python 3"
    echo "  - Docker"
    echo ""
    echo "📄 Raw YAML file: api/open_api.yaml"
fi