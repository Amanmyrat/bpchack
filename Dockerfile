# Build stage
FROM golang:1.19-alpine AS builder

# Install git and ca-certificates (needed for go modules)
RUN apk add --no-cache git ca-certificates

# Set working directory
WORKDIR /app

# Copy go mod files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Build the binary
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o bpchackd ./cmd/bpchackd

# Final stage
FROM alpine:latest

# Install ca-certificates and wget for HTTPS requests and health checks
RUN apk --no-cache add ca-certificates wget

# Create app directory
WORKDIR /root/

# Copy the binary from builder stage
COPY --from=builder /app/bpchackd .

# Copy configuration files
COPY --from=builder /app/configs/bpchackd.config.sample.json ./config.json

# Expose port
EXPOSE 9090

# Set default environment variables
ENV BPCHACK_CONFIG_FILE=/root/config.json

# Run the binary
CMD ["./bpchackd"]