# BPC Hack

BPC hack is a proxy server to hack the crappy "BPC" eCommerce products used in local banks.

## Components

- **bpchackd**: HTTP API server for programmatic access to BPC hacking functionality
- **bpchack-cli**: Interactive command-line interface for step-by-step BPC hacking

## Quick Start with Docker

### Prerequisites

- Docker and Docker Compose

### Running the Server

1. **Clone the repository and navigate to the project directory**

2. **Configure the application** (optional):
   - Edit `configs/bpchackd.config.json` to customize settings
   - Create a `.env` file for environment variables if needed

3. **Build and run with Docker Compose**:
   ```bash
   docker-compose up --build
   ```

   The API server will be available at `http://localhost:9090`

### API Endpoints

- `GET /api/epoch` - Server timestamp
- `GET /api/ip` - Client IP address
- `POST /api/v1/start-hack` - Start BPC hack process
- `POST /api/v1/submit-card` - Submit card information
- `POST /api/v1/resend-code` - Resend SMS verification code
- `POST /api/v1/confirm-payment` - Confirm payment with OTP

See `api/open_api.yaml` for complete API documentation.

### Environment Variables

- `BPCHACK_CONFIG_FILE` - Path to configuration file (default: `config.json`)
- `MPI_BASE_URL` - Base MPI URL for BPC systems
- `CARD_NUMBER` - Default card number for CLI
- `NAME_ON_CARD` - Default cardholder name for CLI
- `CARD_EXPIRY` - Default card expiry for CLI

## Manual Build and Run

### Build

```bash
# Build for Linux
./build_linux.sh

# Or build manually
go build -o bpchackd ./cmd/bpchackd
go build -o bpchack-cli ./cmd/bpchack-cli
```

### Configuration

Copy the sample configuration:
```bash
cp configs/bpchackd.config.sample.json configs/bpchackd.config.json
```

Edit `configs/bpchackd.config.json`:
```json
{
  "listen_address": "0.0.0.0:9090",
  "base_mpi_url": "https://your-bpc-mpi-server/payment/rest"
}
```

### Run

```bash
# Run the server
./bpchackd

# Or run the CLI
./bpchack-cli
```

## Docker Commands

```bash
# Build the image
docker build -t bpchack .

# Run the container
docker run -p 9090:9090 -v $(pwd)/configs/bpchackd.config.json:/root/config.json bpchack

# Or use docker-compose
docker-compose up -d
docker-compose logs -f
docker-compose down
```

## Development

### Requirements

- Go 1.19 or later
- Git

### Install dependencies

```bash
go mod download
```

### Run tests

```bash
go test ./...
```