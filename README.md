# Stephanie's Preview Node

A Cardano preview testnet node setup using Docker for development and testing purposes.

## Overview

This project sets up a Cardano node connected to the preview testnet, which is perfect for:
- Testing Cardano applications
- Learning Cardano development
- Running smart contracts in a test environment

## Quick Start

1. Build and run the Cardano preview node:
   ```bash
   docker-compose up -d
   ```

2. Check node status:
   ```bash
   docker-compose logs -f cardano-node
   ```

3. Query the node:
   ```bash
   docker exec -it cardano-node cardano-cli query tip --testnet-magic 2
   ```

## Components

- **Cardano Node**: The main blockchain node
- **Configuration**: Preview testnet configuration files
- **Monitoring**: Health checks and logging

## Ports

- `3001`: Cardano node P2P port
- `12798`: Prometheus metrics endpoint

## Data Persistence

Node data is persisted in the `./data` directory to maintain blockchain state between container restarts.
